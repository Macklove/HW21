//
//  BruteForce.swift
//  HW21
//
//  Created by  Евгений on 21.07.2022.
//

import Foundation

class BruteForcePassword: Operation {
    
    private var password: String
    
    // MARK: - Init
    
    init(password: String) {
        self.password = password
    }
    
    override func main() {
        super.main()
        if isCancelled {
            return
        }
        bruteForce(passwordToUnlock: password)
    }
    
    func bruteForce(passwordToUnlock: String) -> String {
        let allowedCharacters: [String] = String().printable.map { String($0) }
        var password: String = ""
        
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: allowedCharacters)
            print(password)
        }
        print("Пароль взломан: \(password)")
        return password
    }
    
    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var password = string
        
        if password.count <= 0 {
            password.append(characterAt(index: 0, array))
        } else {
            password.replace(at: password.count - 1,
                             with: characterAt(
                                index: (indexOf(
                                    character: password.last ?? "1", array) + 1) % array.count, array)
            )
            
            if indexOf(character: password.last ?? "1", array) == 0 {
                password = String(generateBruteForce(String(password.dropLast()), fromArray: array)) + String(password.last ?? "1")
            }
        }
        return password
    }
    
    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character)) ?? Int()
    }
    
    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index]) : Character("")
    }
}
