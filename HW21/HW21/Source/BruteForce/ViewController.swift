//
//  ViewController.swift
//  HW21
//
//  Created by  Евгений on 15.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Var/Let
    private let queue = OperationQueue()
    
    // MARK: - Set UI elements
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var create: UIButton!
    
    @IBAction func ganerateButton(_ sender: Any) {
        modeStartCracking()
        let password = textField.text ?? "ХХХХХХХХХХ"
        let splitedPassword = password.split()
        var arrayBruteForcePassword = [BruteForcePassword]()

        splitedPassword.forEach { i in
            arrayBruteForcePassword.append(BruteForcePassword(password: i))
        }

        arrayBruteForcePassword.forEach { operation in
            queue.addOperation(operation)
        }

        queue.addBarrierBlock { [unowned self] in
            OperationQueue.main.addOperation {
                self.modeCompletedCracking()
            }
        }
    }

    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        modeNotStartCracking()
    }
    
    // MARK: - Other functions
    func modeNotStartCracking() {
        textField.isSecureTextEntry = true
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

    func modeStartCracking() {
        label.text = "Hacking..."
        textField.text = String.random()
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func modeCompletedCracking() {
        sleep(2)
        label.text = "Пароль взломан: \(self.textField.text ?? "Ошибка")"
        create.setTitle("Снова", for: .normal)
        textField.isSecureTextEntry = false
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}

