//
//  AddNewKampagneView.swift
//  net360
//
//  Created by Arben on 23.7.24.
//

import SwiftUI

struct AddNewKampagneView: View {
    @ObservedObject var viewModel: EventViewModel
    @State private var dateFields: [EventModel] = [EventModel()]
    @State private var numberofPersons = 0
    @State private var buttonText = "Speichern"
    @State private var buttonColor = Color.blue
    @State private var buttonDisabled = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Color.bgColor
                    .ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        VStack(alignment: .leading, spacing: 5) {
                            DescText("Neue Kampagne", 16, color: .black)
                            CustomTextField(placeholder: "Kampagnenname", text: $viewModel.campaignName)
                            Button {
                                if !viewModel.campaignName.isEmpty {
                                    viewModel.chooseCampaignList.append(viewModel.campaignName)
                                    viewModel.campaignName = ""
                                    updateButton()
                                }
                            } label: {
                                DescText(buttonText, 16, color: .white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(buttonColor)
                                    .cornerRadius(10)
                            }.disabled(buttonDisabled)
                        }
                        Divider()
                        VStack (alignment: .leading) {
                            DescText("ERSTELLEN SIE EINE NEUE VERANSTALTUNG", 16, color: .black)
                            CustomDropDownLineView(placeholder: "Kampagne wählen", selectedValue: $viewModel.chooseCampaignValue, value: "", dropDownList: viewModel.chooseCampaignList, shouldShowDropDown: $viewModel.chooseCampaign, validate: .date)
                                .onTapGesture {
                                    viewModel.chooseCampaign = true
                                }
                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                CustomDropDownLineView(placeholder: "Verantwortlich", selectedValue: $viewModel.responsibleValue, value: "", dropDownList: viewModel.responsibleList, shouldShowDropDown: $viewModel.responsible, validate: .date)
                                    .onTapGesture {
                                        viewModel.responsible = true
                                    }
                                CustomDropDownLineView(placeholder: "Stv. Verantwortlich", selectedValue: $viewModel.deputyResponsibleValue, value: "", dropDownList: viewModel.deputyResponsibleList, shouldShowDropDown: $viewModel.deputyResponsible, validate: .date)
                                    .onTapGesture {
                                        viewModel.deputyResponsible = true
                                    }
                            }
                            CustomTextField(placeholder: "Beschreibung", text: $viewModel.description, validate: .requiredField)
                            CustomTextField(placeholder: "Ort", text: $viewModel.place, validate: .requiredField)
                            CustomTextField(placeholder: "Notice", text: $viewModel.notes, validate: .requiredField)
                            
                            ZStack(alignment: .bottom) {
                                VStack {
                                    ForEach($dateFields) { $field in
                                        VStack {
                                            DateTextField(text: $field.selectedDateAsString, onClick: $field.showCalendarPicker, placeholder: "Birthdate", iconName: "calendarIcon", validate: .date, isClear: .constant(false))
                                                .font(.ubuntuCustomFont(ofSize: 16))
                                            if field.showCalendarPicker {
                                                DatePicker(
                                                    "",
                                                    selection: $field.selectedFirstDate,
                                                    in: ...Date(),
                                                    displayedComponents: [.date]
                                                )
                                                .modifier(DatePickerModifier())
                                                .onTapGesture(count: 99999, perform: {
                                                    // overrides tap gesture to fix ios 17.1 bug
                                                })
                                                .onChange(of: field.selectedFirstDate) { value in
                                                    let dateFormatter = DateFormatter()
                                                    dateFormatter.dateStyle = .medium
                                                    field.selectedDateAsString = dateFormatter.string(from: value)
                                                }
                                            }
                                            DatePicker(selection: $field.startTime, in: ...Date(), displayedComponents: .hourAndMinute) {
                                                DescText("Start time", 14, color: .gray.opacity(0.7))
                                            }
                                            DatePicker(selection: $field.endTime, in: ...Date(), displayedComponents: .hourAndMinute) {
                                                DescText("End time", 14, color: .gray.opacity(0.7))
                                            }
                                            LabeledStepper(
                                                "Personenzahl be:",
                                                description: "",
                                                value: $field.numberofPersons
                                            )
                                        }.verticalPadding(5)
                                    }
                                    
                                }.padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.blue.opacity(0.5), lineWidth: 1)
                                    )
                                Button(action: {
                                    dateFields.append(EventModel())
                                }) {
                                    ImageButton(systemName: "plus", padding: 8, hexColor: "#00A3FF").bold()
                                        .cornerRadius(30)
                                }.bottomPadding(-17)
                            }
                        }.paddingTB(10, 75)
                    }.horizontalPadding(20)
                }
                Button {
                } label: {
                    DescText("Speichern", 16, color: .white)
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                    
                }.horizontalPadding(20)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.bgColor)
            }
        }
    }
    
    private func updateButton() -> Void {
        withAnimation {
            buttonText = "Add Successfully"
            buttonColor = Color.green
            buttonDisabled = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                buttonText = "Speichern"
                buttonColor = Color.blue
                buttonDisabled = false
            }
        }
    }
}

struct AddNewKampagneView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewKampagneView(viewModel: EventViewModel())
    }
}


struct DatePickerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .labelsHidden()
            .datePickerStyle(.graphical)
            .allPadding()
            .frame(width: 340, height: 320)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: .gray, radius: 5)
    }
}
