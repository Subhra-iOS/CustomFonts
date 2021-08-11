//
//  ViewController.swift
//  CustomFonts
//
//  Created by Subhra Roy on 11/08/21.
//  Copyright © 2021 Subhra Roy. All rights reserved.
//

import UIKit

/**"@font-face {\n  font-family: \'Tangerine\';\n  font-style: normal;\n  font-weight: 400;\n  src: url(https://fonts.gstatic.com/s/tangerine/v12/IurY6Y5j_oScZZow4VOxCZZJ.ttf) format(\'truetype\');\n}\n"*/

/**"@font-face {\n  font-family: \'Tangerine\';\n  font-style: normal;\n  font-weight: 400;\n  src: url(https://fonts.gstatic.com/s/tangerine/v12/IurY6Y5j_oScZZow4VOxCZZJ.ttf) format(\'truetype\');\n}\n"*/

struct FontsCollection {
    private let fontsArray = ["http://www.webpagepublicity.com/free-fonts/e/Earthquake%20MF.ttf", //0
                              "http://www.webpagepublicity.com/free-fonts/a/Alako-Bold.ttf", //1
                              "http://www.webpagepublicity.com/free-fonts/a/Amelia.ttf", //2
                              "http://www.webpagepublicity.com/free-fonts/a/Amazone%20BT.ttf", //3
                              "https://fonts.googleapis.com/css?family=Open%20Sans", //4
                              "https://fonts.googleapis.com/css?family=Tangerine"] //5
    
    subscript(index: Int) -> String{
        return fontsArray[index]
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var customFontLabel: UILabel!
    var customFont: UIFont?
    let fonts: FontsCollection = FontsCollection()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self.customFontLabel.text = "Hello World"
    }
    
    @IBAction func pushNewFontButton(sender: Any) {
        if let url = URL(string: fonts[5]) {
            Downloader.fetchFontMetaData(for: url) { (urlStr) in
                let extractUrl: String = urlStr.between("url(", ")") ?? ""
                let fontFamily: String = urlStr.between("font-family:", "font-style:") ?? ""
                let formatedFontFamily: String = fontFamily.between("\\\'", "\\\';\\n") ?? ""
                print("\(formatedFontFamily)")
                let fontStyle: String = urlStr.between("font-style:", "font-weight:") ?? ""
                let formatedFontStyle: String = fontStyle.between(" ", ";\\n") ?? ""
                print("\(formatedFontStyle)")
                let url = URL(string: extractUrl)!
                Downloader.load(URL: url) { [weak self] (font) in
                    self?.customFont = font
                }
            }
        }
        
    }
    
    @IBAction func pushAndSetTheNewFont(sender: Any) {
        guard let font = self.customFont  else {
            return
        }
        self.customFontLabel.font = font
    }
 

}

