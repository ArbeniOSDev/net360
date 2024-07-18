//
//  TextStyles.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI

struct MandatoryText: View {
    var text: String
    var color: Color = .gray.opacity(0.7)
    
    var body: some View {
        HStack (alignment: .lastTextBaseline, spacing: 1) {
            Text(text)
                .foregroundColor(color)
                .lineLimit(2)
//                .font(.ubuntuCustomFont(ofSize: 16))
            Text(" *")
                .foregroundColor(.red).opacity(0.5)
//                .font(.ubuntuCustomFont(ofSize: 16))
        }
    }
}

struct TitleText: View {
    
    private var size: CGFloat
    private var weight: Font.Ubuntu
    private var text: String
    private var color: Color
    private var textAlignment: TextAlignment = .leading
    
    init(_ text: String, _ size: CGFloat = 32, _ weight: Font.Ubuntu = .regular, color: Color = Color.mainColor, textAlignment: TextAlignment = .leading) {
        self.text = text
        self.size = size
        self.weight = weight
        self.color = color
        self.textAlignment = textAlignment
    }
    
    var body: some View {
        parseText()
            .font(Font(weight, size: size)).bold()
//            .lineLimit(4)
            .multilineTextAlignment(textAlignment)
            .foregroundColor(color)
    }
    
    private func parseText() -> Text {
        let processedText = processText(text)
        
        var components: [Text] = []
        let scanner = Scanner(string: processedText)
        scanner.charactersToBeSkipped = nil
        
        while !scanner.isAtEnd {
            if let regularText = scanner.scanUpToCharacters(from: CharacterSet(charactersIn: "*")) {
                components.append(Text(regularText))
            }
            
            if scanner.scanString("**") != nil {
                if let boldText = scanner.scanUpToString("**") {
                    components.append(Text(boldText).bold())
                }
                _ = scanner.scanString("**")
            } else if scanner.scanString("*") != nil {
                if let italicText = scanner.scanUpToString("*") {
                    components.append(Text(italicText).italic())
                }
                _ = scanner.scanString("*")
            }
        }
        return components.reduce(Text(""), +)
    }
    
    private func processText(_ text: String) -> String {
        let lines = text.components(separatedBy: .newlines)
        var processedLines = [String]()
        
        for line in lines {
            if !processedLines.isEmpty && line.isEmpty && processedLines.last == "" {
                continue
            }
            processedLines.append(line)
        }
        
        return processedLines.joined(separator: "\n")
    }
}

struct SubText: View {
    private var size: CGFloat
    private var weight: Font.Ubuntu
    private var text: String
    private var color: Color
    private var textAlignment: TextAlignment = .leading
    
    init(_ text: String, _ size: CGFloat = LayoutConstants.fontSize20, _ weight: Font.Ubuntu = .regular, color: Color = Color.mainColor, textAlignment: TextAlignment = .leading) {
        self.text = text
        self.size = size
        self.weight = weight
        self.color = color
        self.textAlignment = textAlignment
    }
    
    var body: some View {
        parseText()
            .font(Font(weight, size: size))
            .multilineTextAlignment(textAlignment)
            .foregroundColor(color)
            .lineSpacing(7)
    }
    
    private func parseText() -> Text {
        let processedText = processText(text)
        
        var components: [Text] = []
        let scanner = Scanner(string: processedText)
        scanner.charactersToBeSkipped = nil
        
        while !scanner.isAtEnd {
            if let regularText = scanner.scanUpToCharacters(from: CharacterSet(charactersIn: "*")) {
                components.append(Text(regularText))
            }
            
            if scanner.scanString("**") != nil {
                if let boldText = scanner.scanUpToString("**") {
                    components.append(Text(boldText).bold())
                }
                _ = scanner.scanString("**")
            } else if scanner.scanString("*") != nil {
                if let italicText = scanner.scanUpToString("*") {
                    components.append(Text(italicText).italic())
                }
                _ = scanner.scanString("*")
            }
        }
        return components.reduce(Text(""), +)
    }
    
    private func processText(_ text: String) -> String {
        let lines = text.components(separatedBy: .newlines)
        var processedLines = [String]()
        
        for line in lines {
            if !processedLines.isEmpty && line.isEmpty && processedLines.last == "" {
                continue
            }
            processedLines.append(line)
        }
        
        return processedLines.joined(separator: "\n")
    }
}

struct SubTextBold: View {
    private var size: CGFloat
    private var weight: Font.Ubuntu
    private var text: String
    private var color: Color
    private var textAlignment: TextAlignment = .leading
    
    init(_ text: String, _ size: CGFloat = LayoutConstants.fontSize20, _ weight: Font.Ubuntu = .regular, color: Color = Color.mainColor, textAlignment: TextAlignment = .leading) {
        self.text = text
        self.size = size
        self.weight = weight
        self.color = color
        self.textAlignment = textAlignment
    }
    
    var body: some View {
        parseText()
            .font(Font(weight, size: size)).bold()
            .multilineTextAlignment(textAlignment)
            .foregroundColor(color)
            .lineSpacing(3)
    }
    
    private func parseText() -> Text {
        let processedText = processText(text)
        
        var components: [Text] = []
        let scanner = Scanner(string: processedText)
        scanner.charactersToBeSkipped = nil
        
        while !scanner.isAtEnd {
            if let regularText = scanner.scanUpToCharacters(from: CharacterSet(charactersIn: "*")) {
                components.append(Text(regularText))
            }
            
            if scanner.scanString("**") != nil {
                if let boldText = scanner.scanUpToString("**") {
                    components.append(Text(boldText).bold())
                }
                _ = scanner.scanString("**")
            } else if scanner.scanString("*") != nil {
                if let italicText = scanner.scanUpToString("*") {
                    components.append(Text(italicText).italic())
                }
                _ = scanner.scanString("*")
            }
        }
        return components.reduce(Text(""), +)
    }
    
    private func processText(_ text: String) -> String {
        let lines = text.components(separatedBy: .newlines)
        var processedLines = [String]()
        
        for line in lines {
            if !processedLines.isEmpty && line.isEmpty && processedLines.last == "" {
                continue
            }
            processedLines.append(line)
        }
        
        return processedLines.joined(separator: "\n")
    }
}


struct DescText: View {
    private var size: CGFloat
    private var weight: Font.Ubuntu
    private var text: String
    private var color: Color
    private var textAlignment: TextAlignment = .leading
    
    init(_ text: String, _ size: CGFloat = LayoutConstants.fontSize13, _ weight: Font.Ubuntu = .regular, color: Color = Color.mainColor, textAlignment: TextAlignment = .leading) {
        self.text = text
        self.size = size
        self.weight = weight
        self.color = color
        self.textAlignment = textAlignment
    }
    
    var body: some View {
        parseText()
            .font(Font(weight, size: size))
            .multilineTextAlignment(textAlignment)
            .foregroundColor(color)
            .lineSpacing(7)
    }
    
    private func parseText() -> Text {
        let processedText = processText(text)
        
        var components: [Text] = []
        let scanner = Scanner(string: processedText)
        scanner.charactersToBeSkipped = nil
        
        while !scanner.isAtEnd {
            if let regularText = scanner.scanUpToCharacters(from: CharacterSet(charactersIn: "*")) {
                components.append(Text(regularText))
            }
            
            if scanner.scanString("**") != nil {
                if let boldText = scanner.scanUpToString("**") {
                    components.append(Text(boldText).bold())
                }
                _ = scanner.scanString("**")
            } else if scanner.scanString("*") != nil {
                if let italicText = scanner.scanUpToString("*") {
                    components.append(Text(italicText).italic())
                }
                _ = scanner.scanString("*")
            }
        }
        return components.reduce(Text(""), +)
    }

    
    private func processText(_ text: String) -> String {
        let lines = text.components(separatedBy: .newlines)
        var processedLines = [String]()
        
        for line in lines {
            if !processedLines.isEmpty && line.isEmpty && processedLines.last == "" {
                continue
            }
            processedLines.append(line)
        }
        
        return processedLines.joined(separator: "\n")
    }
}


struct DescTextLight: View {
    private var size: CGFloat
    private var weight: Font.Ubuntu
    private var text: String
    private var color: Color
    private var textAlignment: TextAlignment = .leading
    
    init(_ text: String, _ size: CGFloat = LayoutConstants.fontSize13, _ weight: Font.Ubuntu = .regular, color: Color = Color.mainColor, textAlignment: TextAlignment = .leading) {
        self.text = text
        self.size = size
        self.weight = weight
        self.color = color
        self.textAlignment = textAlignment
    }
    
    var body: some View {
        parseText()
            .font(Font(weight, size: size)).fontWeight(.light)
            .multilineTextAlignment(textAlignment)
            .foregroundColor(color)
            .lineSpacing(7)
    }
    
    private func parseText() -> Text {
        let processedText = processText(text)
        
        var components: [Text] = []
        let scanner = Scanner(string: processedText)
        scanner.charactersToBeSkipped = nil
        
        while !scanner.isAtEnd {
            if let regularText = scanner.scanUpToCharacters(from: CharacterSet(charactersIn: "*")) {
                components.append(Text(regularText))
            }
            
            if scanner.scanString("**") != nil {
                if let boldText = scanner.scanUpToString("**") {
                    components.append(Text(boldText).bold())
                }
                _ = scanner.scanString("**")
            } else if scanner.scanString("*") != nil {
                if let italicText = scanner.scanUpToString("*") {
                    components.append(Text(italicText).italic())
                }
                _ = scanner.scanString("*")
            }
        }
        return components.reduce(Text(""), +)
    }
    
    private func processText(_ text: String) -> String {
        let lines = text.components(separatedBy: .newlines)
        var processedLines = [String]()
        
        for line in lines {
            if !processedLines.isEmpty && line.isEmpty && processedLines.last == "" {
                continue
            }
            processedLines.append(line)
        }
        
        return processedLines.joined(separator: "\n")
    }
}

struct Text_Previews: PreviewProvider {
    static var previews: some View {
        VStack (alignment: .center, spacing: 10) {
            TitleText("TitleText")
            SubText("Sub Text")
            SubTextBold("Bold Sub Text")
            DescText("Description Text")
            MandatoryText(text: "MandatoryText")
        }
    }
}

struct CheckBoxView: View {
    @Binding var isChecked: Bool

    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(isChecked ? .blue : .gray)
            }
            .padding()
        }
    }
}
