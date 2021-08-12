//
//  GoogleFontResourceCreator.swift
//  CustomFonts
//
//  Created by Subhra Roy on 12/08/21.
//  Copyright © 2021 Subhra Roy. All rights reserved.
//

import Foundation

enum FontWeight: String{
    case thin = "100"
    case extralight = "200"
    case light = "300"
    case regular = "400"
    case medium = "500"
    case semibold = "600"
    case bold = "700"
    case extrabold = "800"
    case black = "900"
}

enum FontStyle: String{
    case italic = "ital"
    case other = "other"
}

struct GoogleFontResourceCreator {
    private let googleBaseUrl = "https://fonts.googleapis.com/css2?family="
    
    private let fontFamilyName: String!
    private var fontStyle: FontStyle = .other
    private var fontWeight: FontWeight = .regular
    
    init(familyName:String,
         style: FontStyle,
         weight: FontWeight) {
        self.fontFamilyName = familyName
        self.fontStyle = style
        self.fontWeight = weight
    }
    
    private func splitCamelCase(input: String) -> String {
        let result = input.replacingOccurrences(of:  String(format:"%s|%s|%s",
                                                      "(?<=[A-Z])(?=[A-Z][a-z])",
                                                      "(?<=[^A-Z])(?=[A-Z])",
                                                      "(?<=[A-Za-z])(?=[^A-Za-z])"
        ), with: " ")
        return result
    }
    
    private func insertPlusSignIn(fontName: String) -> String{
        let splitResults: [String] = self.splitCamelCase(input: fontName).components(separatedBy: CharacterSet.whitespaces)
        let actualFontName: String = splitResults.joined(separator: "+")
        return actualFontName
    }
    
    func generateGoogleFontResourcePath() -> String{
        var serverPath: String!
        switch self.fontStyle {
            case .italic:
                serverPath = "\(googleBaseUrl)" + self.insertPlusSignIn(fontName: self.fontFamilyName) + ":" + "\(self.fontStyle.rawValue)" + ",wght@1," + "\(self.fontWeight.rawValue)"
            default:
                 serverPath = "\(googleBaseUrl)" + self.insertPlusSignIn(fontName: self.fontFamilyName) + ":" + "wght@" + "\(self.fontWeight.rawValue)"
        }
        return serverPath
    }

}
