//
//  ViewController.swift
//  CustomFonts
//
//  Created by Subhra Roy on 11/08/21.
//  Copyright © 2021 Subhra Roy. All rights reserved.
//

import UIKit

struct FontsCollection {
    private let fontsArray = ["http://www.webpagepublicity.com/free-fonts/e/Earthquake%20MF.ttf", //0
                              "http://www.webpagepublicity.com/free-fonts/a/Alako-Bold.ttf", //1
                              "http://www.webpagepublicity.com/free-fonts/a/Amelia.ttf", //2
                              "http://www.webpagepublicity.com/free-fonts/a/Amazone%20BT.ttf"] //3
    
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
        if let url = NSURL(string: fonts[0]) {
                Downloader.load(URL: url) { [weak self] (font) in
                    self?.customFont = font
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

