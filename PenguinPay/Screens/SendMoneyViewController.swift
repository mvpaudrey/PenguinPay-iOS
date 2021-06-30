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

    @IBOutlet weak var recipientAmountLabel: UILabel!
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

        amountTextField.inputType = .decimal
        amountTextField.returnKeyType = .done
        amountTextField.isUserInteractionEnabled = false

        zeroButton.backgroundColor = .blue
        zeroButton.addTarget(self, action: #selector(addZeroToTextField), for: .touchUpInside)

        oneButton.backgroundColor = .blue
        oneButton.addTarget(self, action: #selector(addOneToTextField), for: .touchUpInside)

        deleteButton.tintColor = .red
        deleteButton.addTarget(self, action: #selector(deleteBackward), for: .touchUpInside)
        addLongPressGestureToDeleteButton()

        recipientCurrencyLabel.text = phoneNumberTextField.selectedCurrency
        recipientCurrencyLabel.textDidChange = { text in
            self.viewModel.currencyName.value = text
            print("Currency name: \(String(describing: text))")
        }

        sendButton.backgroundColor = viewModel.isValid ? .blue : .gray
    }

    private func updateRecipientCurrencyLabel(currency: String?) {
        recipientCurrencyLabel.text = currency
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        print("textChanged \(text)")
        // self.textChanged(text)
    }

    @objc private func addZeroToTextField() {
        amountTextField.text?.append("0")
    }

    @objc private func addOneToTextField() {
        amountTextField.text?.append("1")
    }

    @objc private func deleteBackward() {
        amountTextField.text?.removeLast()
    }

    @objc func longPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            amountTextField.text?.removeAll()
        }
    }

    private func addLongPressGestureToDeleteButton() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
        longPress.minimumPressDuration = 0.5
        deleteButton.addGestureRecognizer(longPress)
    }

}

extension SendMoneyViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        print("Hey")
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
