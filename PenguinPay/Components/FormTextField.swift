//
//  FormTextField.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import UIKit

open class FormTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    fileprivate func commonInit() {
        updateInputType(inputType)
        delegate = self
        backgroundColor = UIColor.clear
        setupTextFieldLayout()
    }

    open var inputType: FormTextFieldInputType = .default {
        didSet {
            updateInputType(inputType)
        }
    }

    // Placeholder position
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: bounds.origin.y)
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let textPadding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

}

extension FormTextField: UITextFieldDelegate {

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
