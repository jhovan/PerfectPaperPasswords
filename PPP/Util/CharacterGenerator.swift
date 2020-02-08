//
//  CharacterGenerator.swift
//  PPP
//
//  Created by Jhovan Gallardo on 07/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import Foundation
import CryptoKit

// standar 64 bit PPP alphabet
let alphabet = Array("!#%+23456789:=?@ABCDEFGHJKLMNPRSTUVWXYZabcdefghijkmnopqrstuvwxyz")

class CharacterGenerator {
    
    var key: SymmetricKey
    
    init () {
        key = SymmetricKey(size: .bits256)
    }
    
    
    func getKeyAsData () -> Data{
        return withUnsafeBytes(of: self.key) { Data($0) }
    }
    
    func generate(counter: UInt128, numberOfCharacters: UInt) -> (String, UInt128){
        var chars = ""
        var counter = counter
        while(chars.count < numberOfCharacters) {
            let data = withUnsafeBytes(of: counter) { Data($0) }
            let encryptedData = try? ChaChaPoly.seal(data, using: key).ciphertext
            var encryptedCounter: UInt128 = 0
            let bytesCopied = withUnsafeMutableBytes(of: &encryptedCounter, { encryptedData!.copyBytes(to: $0)} )
            assert(bytesCopied == MemoryLayout.size(ofValue: encryptedCounter))
            
            while(encryptedCounter != 0 && chars.count < numberOfCharacters) {
                let res = Int(encryptedCounter % UInt128(alphabet.count))
                encryptedCounter /= UInt128(alphabet.count)
                chars.append(alphabet[res])
            }
            counter += 1
        }
        return (chars, counter)
    }
        

}

