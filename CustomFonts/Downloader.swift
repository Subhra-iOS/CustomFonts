//
//  Downloader.swift
//  CustomFonts
//
//  Created by Subhra Roy on 11/08/21.
//  Copyright © 2021 Subhra Roy. All rights reserved.
//

import Foundation
import CoreGraphics
import CoreText
import UIKit

class Downloader {
    
    class func fetchFontMetaData(for url: URL, completion: @escaping ((String) -> Void)) -> Void{
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error == nil) {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("Success: \(statusCode)")
                guard let responseData = data else {
                    completion("")
                    return
                }
            
                let dataStr = String(describing: String(bytes: responseData, encoding: .utf8))
                print("\(dataStr)")
                completion(dataStr)
            }else {
                print("Faulure: %@", error?.localizedDescription ?? "")
                completion("")
            }
        }
        task.resume()
    }
    
    class func load(URL: URL, closure: @escaping ((UIFont) -> Void)) -> Void{
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = NSMutableURLRequest(url: URL as URL)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("Success: \(statusCode)")
                guard let responseData = data else {
                    return
                }
                // This is your file-variable:
                // data
                print("\(String(describing: String(bytes: responseData, encoding: .utf8)))")
//                if let result: Any = try? JSONSerialization.jsonObject(with: responseData, options: []) as Any{
//                    print("\(result)")
//                }
               
                if let dataProvider: CGDataProvider = CGDataProvider(data: responseData as CFData), let cgFont = CGFont(dataProvider){
                    var error: Unmanaged<CFError>?
                    if !CTFontManagerRegisterGraphicsFont(cgFont, &error){
                        print("Error loading Font!")
                        DispatchQueue.main.async{
                            closure(UIFont(name: "Arial", size: 30.0)!)
                        }
                    } else {
                        if let fontName: String = cgFont.postScriptName as String?{
                            DispatchQueue.main.async {
                                if let uiFont : UIFont = UIFont(name: String(describing: fontName) , size: 30){
                                    print("\(uiFont.familyName)")
                                    closure(uiFont)
                                }
                            }
                        }
                    }
                }
                        
            }
            else {
                // Failure
                print("Faulure: %@", error?.localizedDescription ?? "")
            }
        }
        task.resume()
    }
}
