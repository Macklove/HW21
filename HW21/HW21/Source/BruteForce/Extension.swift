//
//  Extension.swift
//  HW21
//
//  Created by  Евгений on 21.07.2022.
//

import Foundation

// MARK: - Extensions
extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }
    
    
    
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
    
    
    // MARK: - Brut force
    static func random(length: Int = 10) -> String {
        
        let printable = String().printable.map { String($0) }
        var randomString = ""
        
        for _ in 0 ..< length {
            randomString.append(printable.randomElement()!)
        }
        return randomString
    }
    
    func split(by length: Int = 2) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()
        
        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }
        return results.map { String($0) }
    }
}
