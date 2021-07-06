//
//  SendMoneyViewController.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 21/06/2021.
//

import UIKit

class SendMoneyViewController: BaseViewController {

    private let viewModel = SendMoneyViewModel()

    // MARK: - IBOutlet

    @IBOutlet weak var firstnameTextField: FormTextField! {
        didSet {
            self.firstnameTextField.bind { self.viewModel.firstname.value = $0 }
        }
    }

    @IBOutlet weak var lastnameTextField: FormTextField! {
        didSet {
            self.lastnameTextField.bind { self.viewModel.lastname.value = $0 }
        }
    }

    @IBOutlet weak var phoneNumberTextField: NumberTextField! {
        didSet {
            self.phoneNumberTextField.bind { self.viewModel.phoneNumber.value = $0 }
        }
    }

    @IBOutlet weak var amountTextField: FormTextField! {
        didSet {
            self.amountTextField.bind { self.viewModel.binarianMoney.value = $0 }
        }
    }

    @IBOutlet weak var recipientAmountTextField: FormTextField! {
        didSet {
            self.recipientAmountTextField.bind { self.viewModel.recipientBinarianMoney.value = $0 }
        }
    }

    @IBOutlet weak var currencyLabel: UILabel!

    @IBOutlet weak var zeroButton: RoundedButton!
    @IBOutlet weak var oneButton: RoundedButton!
    @IBOutlet weak var deleteButton: RoundedButton!

    @IBOutlet weak var recipientCurrencyLabel: ObservableLabel!

    @IBOutlet weak var sendButton: RoundedButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PenguinPay"
        configUI()
    }

    private func configUI() {
        firstnameTextField.inputType = .firstname
        firstnameTextField.returnKeyType = .next
        lastnameTextField.inputType = .lastname
        lastnameTextField.returnKeyType = .next

        phoneNumberTextField.inputType = .phoneNumber
        phoneNumberTextField.returnKeyType = .next
        phoneNumberTextField.addTarget(phoneNumberTextField,
                                       action: #selector(textFieldDidChange),
                                       for: .editingChanged)
        phoneNumberTextField.numberDelegate = self

        viewModel.updateCurrency(code: phoneNumberTextField.defaultRegion)

        amountTextField.isUserInteractionEnabled = false

        zeroButton.backgroundColor = .blue
        zeroButton.addTarget(self, action: #selector(addZeroToTextField), for: .touchUpInside)

        oneButton.backgroundColor = .blue
        oneButton.addTarget(self, action: #selector(addOneToTextField), for: .touchUpInside)

        deleteButton.tintColor = .red
        deleteButton.addTarget(self, action: #selector(deleteBackward), for: .touchUpInside)
        addLongPressGestureToDeleteButton()

        recipientCurrencyLabel.textDidChange = { text in
            self.viewModel.currencyName.value = text
            print("Currency Code: \(String(describing: text))")
        }

        recipientAmountTextField.isUserInteractionEnabled = false

        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        updateSendButton()
    }

    private func updateRecipientCurrencyLabel(currency: String?) {
        recipientCurrencyLabel.text = currency
    }

    private func updateSendButton() {
        sendButton.backgroundColor = viewModel.isValid ? .blue : .gray
        sendButton.isEnabled = viewModel.isValid
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        print("textChanged \(text)")
    }

    @objc private func addZeroToTextField() {
        amountTextField.text?.append("0")
        updateRecipientAmountField()
    }

    @objc private func addOneToTextField() {
        amountTextField.text?.append("1")
        updateRecipientAmountField()
    }

    @objc private func deleteBackward() {
        amountTextField.text?.removeLast()
        updateRecipientAmountField()
    }

    @objc func longPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            amountTextField.text?.removeAll()
        }
        updateRecipientAmountField()
    }

    @objc func sendButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Sendwave", message: "All Good ☺️.\nThanks for reviewing 👏🏾.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }

    private func updateRecipientAmountField() {
        updateRecipientAmount(with: amountTextField.text)
        updateSendButton()
    }

    private func addLongPressGestureToDeleteButton() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
        longPress.minimumPressDuration = 0.5
        deleteButton.addGestureRecognizer(longPress)
    }

    func updateRecipientAmount(with text: String?, currencyCode: String? = nil) {
        let recipientAmount = viewModel.computeCurrencyRateInBinary(amount: text)
        recipientAmountTextField.text = "\(recipientAmount)"
        recipientCurrencyLabel.text = viewModel.currencyName.value
    }

}

extension SendMoneyViewController: NumberTextFieldDelegate {

    func didUpdateCountry(_ country: Country) {
        print("Country updated to: \(country)")
        guard let newCountry = Countries(rawValue: country.code) else { return }
        print("newCurrency: \(newCountry.currency)")
        print("newCountry name: \(newCountry.name)")
        viewModel.updateCurrency(code: country.code)
        updateRecipientAmount(with: amountTextField.text, currencyCode: newCountry.currency)
    }

    func numberDidChange(valid: Bool) {
        viewModel.isPhoneNumberValid = valid
        updateSendButton()
    }
}

extension SendMoneyViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        updateSendButton()
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstnameTextField:
            lastnameTextField.becomeFirstResponder()
        case lastnameTextField:
            phoneNumberTextField.becomeFirstResponder()
        default:
            amountTextField.resignFirstResponder()
        }
        return true
    }
}
