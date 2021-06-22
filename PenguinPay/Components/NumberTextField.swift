//
//  NumberTextField.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 21/06/2021.
//

import UIKit
import PhoneNumberKit

public class NumberTextField: PhoneNumberTextField {

    public override var defaultRegion: String {
        get {
            return "NG"
        }
        set { self.defaultRegion = newValue } // exists for backward compatibility
    }

    open var inputType: FormTextFieldInputType = .default {
        didSet {
            self.updateInputType(inputType)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    func setupUI() {
        setupTextFieldLayout()
        withPrefix = true
        withFlag = true
        withExamplePlaceholder = true
        withDefaultPickerUI = false
    }

}

// MARK: - Computed properties

extension NumberTextField {

    func getNumber() -> String {
        nationalNumber
    }

    func getCountryCode() -> String {
        "\(String(describing: phoneNumber?.countryCode))"
    }

}
