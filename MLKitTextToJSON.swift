//
//  MLKitTextToJSON.swift
//  Created by flrngel on 2021/01/06.
//

import MLKit

struct MLKitTextToJSON {
    static func encode(data: Text) throws -> String {
        return String(data: try JSONEncoder().encode(ClonedText(text: data)), encoding: .utf8)!
    }
}

fileprivate struct ClonedText: Codable {
    var text: String
    var blocks: [ClonedTextBlock]
    
    init(text:Text) {
        self.text = text.text
        self.blocks = text.blocks.map { block in
            ClonedTextBlock(block:block)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case text
        case blocks
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decode(String.self, forKey: .text)
        blocks = try values.decode([ClonedTextBlock].self, forKey: .blocks)
    }
}

fileprivate struct ClonedTextBlock: Codable {
    var text: String
    var lines: [ClonedTextLine]
    var frame: CGRect
    var recognizedLanguages: [ClonedTextRecognizedLanguage]
    var cornerPoints: [CGPoint]
    
    init(block:TextBlock) {
        self.text = block.text
        self.lines = block.lines.map { line in
            ClonedTextLine(line:line)
        }
        self.frame = block.frame
        self.recognizedLanguages = block.recognizedLanguages.map { language in
            ClonedTextRecognizedLanguage(language:language)
        }
        self.cornerPoints = block.cornerPoints.map { cornerPoint in
            cornerPoint.cgPointValue
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case text
        case lines
        case frame
        case recognizedLanguages
        case cornerPoints
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decode(String.self, forKey: .text)
        lines = try values.decode([ClonedTextLine].self, forKey: .lines)
        frame = try values.decode(CGRect.self, forKey: .frame)
        recognizedLanguages = try values.decode([ClonedTextRecognizedLanguage].self, forKey: .recognizedLanguages)
        cornerPoints = try values.decode([CGPoint].self, forKey: .cornerPoints)
    }
}

fileprivate struct ClonedTextLine: Codable {
    var text: String
    var elements: [ClonedTextElement]
    var frame: CGRect
    var recognizedLanguages: [ClonedTextRecognizedLanguage]
    var cornerPoints: [CGPoint]
    
    init(line:TextLine) {
        self.text = line.text
        self.elements = line.elements.map { element in
            ClonedTextElement(element:element)
        }
        self.frame = line.frame
        self.recognizedLanguages = line.recognizedLanguages.map { language in
            ClonedTextRecognizedLanguage(language:language)
        }
        self.cornerPoints = line.cornerPoints.map { cornerPoint in
            cornerPoint.cgPointValue
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case text
        case elements
        case frame
        case recognizedLanguages
        case cornerPoints
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decode(String.self, forKey: .text)
        elements = try values.decode([ClonedTextElement].self, forKey: .elements)
        frame = try values.decode(CGRect.self, forKey: .frame)
        recognizedLanguages = try values.decode([ClonedTextRecognizedLanguage].self, forKey: .recognizedLanguages)
        cornerPoints = try values.decode([CGPoint].self, forKey: .cornerPoints)
    }
}

fileprivate struct ClonedTextElement: Codable {
    var text: String
    var frame: CGRect
    var cornerPoints: [CGPoint]
    
    init(element:TextElement) {
        self.text = element.text
        self.frame = element.frame
        self.cornerPoints = element.cornerPoints.map { cornerPoint in
            cornerPoint.cgPointValue
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case text
        case frame
        case cornerPoints
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decode(String.self, forKey: .text)
        frame = try values.decode(CGRect.self, forKey: .frame)
        cornerPoints = try values.decode([CGPoint].self, forKey: .cornerPoints)
    }
}

fileprivate struct ClonedTextRecognizedLanguage: Codable {
    var languageCode: String?
    
    init(language:TextRecognizedLanguage) {
        self.languageCode = language.languageCode
    }
    
    enum CodingKeys: String, CodingKey {
        case languageCode
    }
}
