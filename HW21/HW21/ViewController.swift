//
//  ViewController.swift
//  HW21
//
//  Created by  Евгений on 15.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Set UI elements
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var againButton: UIButton!
    @IBOutlet weak var again: UIButton!
    @IBOutlet weak var create: UIButton!
    
    
    @IBAction func searchButton(_ sender: UIButton) {
        self.bruteForce(passwordToUnlock: textField.text ?? "")
        self.create.isHidden = true
        label.isHidden = false

    }
    
    @IBAction func ganerateButton(_ sender: UIButton) {
        textField.text = "\(randomPasswordGenerate())"
        self.button.isHidden = false
        self.create.isHidden = true

    }
    @IBAction func againButton(_ sender: UIButton) {
        textField.text = ""
        label.text = ""
        textField.isSecureTextEntry = true
        create.isHidden = false
        again.isHidden = true

    }
    
    
    //MARK: - Lifecycle
override func viewDidLoad() {
    super.viewDidLoad()
    activityIndicator.isHidden = true
    textField.isSecureTextEntry = true
    again.isHidden = true
    button.isHidden = true
    label.isHidden = true


}
    // MARK: - Functions
func bruteForce(passwordToUnlock: String) {
    DispatchQueue.main.async {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.button.isHidden = true


        
        DispatchQueue.global(qos: .background).async {
            let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }
            var password: String = ""
            while password != passwordToUnlock {
                password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
                
                DispatchQueue.main.async {
                    self.label.text = "Hacking.. \(password)"
                    if password == passwordToUnlock {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.textField.isSecureTextEntry = false
                        self.label.text = "Hacked! Password: \(password)"
                        self.again.isHidden = false
                        self.button.isHidden = true

                    }
                }
            }
        }
    }
}
    
    func randomPasswordGenerate() -> String {
        let passwordLength = 3
        let passwordCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        let randomPassword = String((0..<passwordLength).compactMap{ _ in passwordCharacters.randomElement() })
        return randomPassword
    }
    
}
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
}
    // MARK: - Brut force
func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
                               : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string

    if str.count <= 0 {
        str.append(characterAt(index: 0, array))
    }
    else {
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }

    return str
}

