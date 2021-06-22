//
//  BaseViewController.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 21/06/2021.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {}

/// Dismiss keyboard when tap on view
extension BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
    }

    /// Hide the keyboard when the user taps somewhere ele on the screen
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    /// Hides the keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
