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
        let rows = 10
        let columns = 4
        let passCodeLength = 4
        let generator = CharacterGenerator()
        let cardFormatter = CardFormatter(rows: rows, columns: columns, passCodeLength: passCodeLength)
        sequenceKeyLabel.text =  generator.getKeyAsData().hexEncodedString(options: .upperCase)
        let chars = generator.generate(counter: 0, numberOfCharacters: UInt(rows*columns*passCodeLength)).0
        passwordsLabel.text = cardFormatter.format(chars: chars)
        
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

