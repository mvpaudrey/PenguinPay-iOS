//
//  UITextField+Layout.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import UIKit

extension UITextField {

    func setupTextFieldLayout() {
        borderStyle = .none
        textColor = UIColor.black
        font = UIFont.systemFont(ofSize: 16, weight: .medium)
        setupRoundedLayout()
    }

    func updateInputType(_ type: FormTextFieldInputType) {
        switch type {
        case .firstname, .lastname:
            autocapitalizationType = .words
            autocorrectionType = .no

        case .phoneNumber:
            autocapitalizationType = .none
            autocorrectionType = .no
            keyboardType = .phonePad

        case .integer:
            autocapitalizationType = .none
            autocorrectionType = .no
            keyboardType = .phonePad

        case .decimal:
            autocapitalizationType = .none
            autocorrectionType = .no
            keyboardType = .numberPad

        case .default:
            break
        }
    }

}
