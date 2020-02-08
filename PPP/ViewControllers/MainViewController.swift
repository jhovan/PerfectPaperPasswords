//
//  ViewController.swift
//  PPP
//
//  Created by Jhovan Gallardo on 07/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let rows = 10
    let columns = 4
    let passCodeLength = 4

    @IBOutlet weak var sequenceKeyLabel: UILabel!
    
    @IBOutlet weak var passwordsLabel: UILabel!

    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let receivedData = KeyChain.load(key: "SequenceKey") {
            let generator = CharacterGenerator()
            let cardFormatter = CardFormatter(rows: rows, columns: columns, passCodeLength: passCodeLength)
            sequenceKeyLabel.text =  receivedData.hexEncodedString(options: .upperCase)
            let result = generator.generate(counter: 0, numberOfCharacters: UInt(rows*columns*passCodeLength))
            let chars = result.0
            counterLabel.text = "\(result.1)"
            passwordsLabel.text = cardFormatter.format(chars: chars)
        }
    }
    
    @IBAction func generateButton(_ sender: Any) {

        let generator = CharacterGenerator()
        let cardFormatter = CardFormatter(rows: rows, columns: columns, passCodeLength: passCodeLength)
        let keyData = generator.getKeyAsData()
        sequenceKeyLabel.text =  keyData.hexEncodedString(options: .upperCase)
        let result = generator.generate(counter: 0, numberOfCharacters: UInt(rows*columns*passCodeLength))
        let chars = result.0
        counterLabel.text = "\(result.1)"
        passwordsLabel.text = cardFormatter.format(chars: chars)
        
        let status = KeyChain.save(key: "SequenceKey", data: keyData)
        print(status)
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

