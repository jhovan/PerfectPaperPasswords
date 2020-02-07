//
//  ViewController.swift
//  PPP
//
//  Created by Jhovan Gallardo on 07/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sequenceKeyLabel: UILabel!
    
    @IBOutlet weak var passwordsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func generateButton(_ sender: Any) {
        let generator = CharacterGenerator()
        sequenceKeyLabel.text =  generator.getKeyAsData().hexEncodedString(options: .upperCase)
        passwordsLabel.text = generator.generate(counter: 0, numberOfCharacters: 160).0
    }
        
}

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}

