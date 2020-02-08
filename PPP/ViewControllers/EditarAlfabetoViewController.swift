//
//  EditarAlfabetoViewController.swift
//  PPP
//
//  Created by Jhovan Gallardo on 08/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit



class EditarAlfabetoViewController: UIViewController {
    
    @IBOutlet weak var alfabetoText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.popViewController(animated: true)


        var currentAlphabet: String

        if let receivedData = KeyChain.load(key: "Alphabet") {
            currentAlphabet = String(decoding: receivedData, as: UTF8.self)
        }
        else {
            currentAlphabet = Constants.DEFAULT_ALPHABET
        }
        alfabetoText.text = currentAlphabet
    }
    
    @IBAction func restaurarButton(_ sender: Any) {
        alfabetoText.text = Constants.DEFAULT_ALPHABET
    }
    
    @IBAction func aceptarButton(_ sender: Any) {
        var trimmedString = (alfabetoText.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedString.isEmpty {
            trimmedString = " "
        }
        let data: Data = trimmedString.data(using: .utf8)!
        //let data = withUnsafeBytes(of: trimmedString) { Data($0) }
        let status = KeyChain.save(key: "Alphabet", data: data)
        print(status)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cerrarButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func vaciarButton(_ sender: Any) {
        alfabetoText.text = ""
    }
    
}
