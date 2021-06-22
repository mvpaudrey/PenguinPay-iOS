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

    func leftViewPadding() {

        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: frame.size.height))
        view.backgroundColor = UIColor.clear
        leftView = view
        leftViewMode = .always
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
