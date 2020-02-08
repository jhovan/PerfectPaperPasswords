//
//  CharacterGenerator.swift
//  PPP
//
//  Created by Jhovan Gallardo on 07/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import Foundation
import CryptoKit

class CharacterGenerator {
    
    var key: SymmetricKey
    
    init () {
        self.key = SymmetricKey(size: .bits256)
    }
    
    init(data: Data) {
        self.key = data.withUnsafeBytes {
            $0.load(as: SymmetricKey.self)
        }
    }
    
    
    func getKeyAsData () -> Data{
        return withUnsafeBytes(of: self.key) { Data($0) }
    }
    
    func generate(counter: UInt128, numberOfCharacters: UInt) -> (String, UInt128){
        let alphabet = getAlphabetFromKeyChain()
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
    
    func getAlphabetFromKeyChain() -> [Character] {
        if let receivedData = KeyChain.load(key: "Alphabet") {
            return Array(String(decoding: receivedData, as: UTF8.self))
        }
        return Array(Constants.DEFAULT_ALPHABET)
    }
        
    

}

