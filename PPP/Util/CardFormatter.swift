//
//  CardFormatter.swift
//  PPP
//
//  Created by Jhovan Gallardo on 07/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import Foundation

class CardFormatter {
    
    let rowNames = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    var rows: Int
    var columns: Int
    var passcodeLength: Int
    
    init(rows: Int, columns: Int, passCodeLength: Int) {
        self.rows = rows
        self.columns = columns
        self.passcodeLength = passCodeLength
    }
    
    func format(chars: String) -> String {
        var string = "\t"
        var chars = chars
        for i in 1 ... columns {
            for _ in 1 ... passcodeLength {
                string.append(" ")
            }
            string.append(String(rowNames[i - 1]) + "\t")
        }
        
        for i in 1 ... rows {
            string.append("\n\(i):\t")
            for _ in 1 ... columns {
                var passcode = ""
                for _ in 1 ... passcodeLength {
                    passcode.append(chars.removeFirst())
                }
                string.append("\(passcode)\t")
            }
        }
        return string
    }

}
