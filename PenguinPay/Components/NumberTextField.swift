//
//  NumberTextField.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 21/06/2021.
//

import UIKit
import PhoneNumberKit

public class NumberTextField: PhoneNumberTextField {

    var selectedCurrency: String = "USD"

    var textChanged: (String) -> Void = { _ in }

    public override var defaultRegion: String {
        get { "NG" }
        set { self.partialFormatter.defaultRegion = newValue }
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
        flagButton.addTarget(self, action: #selector(didPressFlagCountryButton), for: .touchUpInside)
    }

    @objc func didPressFlagCountryButton() {
        let vc = CountryPickerViewController()
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        containingViewController?.present(nav, animated: true)
    }

    func bind(completion :@escaping (String) -> Void) {
        self.textChanged = completion
    }

    @objc func textFieldDidChange(_ textField: UITextField) {

        guard let text = textField.text else {
            return
        }
        self.textChanged(text)
    }

    /// ContainingViewController looks at the responder chain to find the view controller nearest to itself
    var containingViewController: UIViewController? {
        var responder: UIResponder? = self
        while !(responder is UIViewController) && responder != nil {
            responder = responder?.next
        }
        return (responder as? UIViewController)
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

extension NumberTextField: CountryPickerDelegate {

    func countryPickerDidPickCountry(_ country: Country) {
        text = isEditing ? "+" + country.prefix : ""
        defaultRegion = country.code
        partialFormatter.defaultRegion = country.code
        selectedCurrency = currencyForCountry(country.name)
        updateFlag()
        updatePlaceholder()
        containingViewController?.dismiss(animated: true)
    }

    private func currencyForCountry(_ name: String) -> String {
        let defaultCurrency = "USD"
        let matchedCountry = Countries.allCases.first { $0.name == name }
        guard let country = matchedCountry else { return defaultCurrency }
        selectedCurrency = country.currency
        return country.currency
    }
}
