//
//  SendMoneyViewController.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 21/06/2021.
//

import UIKit
import RxSwift

class SendMoneyViewController: BaseViewController {

    // MARK: - IBOutlet -
    @IBOutlet weak var firstnameTextField: FormTextField!
    @IBOutlet weak var lastnameTextField: FormTextField!
    @IBOutlet weak var phoneNumberTextField: NumberTextField!
    @IBOutlet weak var amountTextField: FormTextField!

    @IBOutlet weak var recipientAmountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!

    @IBOutlet weak var sendButton: RoundedButton!

    let rxbag = DisposeBag()

    private let formViewModel = SendMoneyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()

        configUI()
    }

    func bindViewModel() {

        formViewModel.firstnameSubject <~> firstnameTextField.rx.text => rxbag
        formViewModel.lastnameSubject <~> lastnameTextField.rx.text => rxbag
        formViewModel.phoneNumberSubject <~> phoneNumberTextField.rx.text => rxbag

        formViewModel.sendButtonEnabled ~> sendButton.rx.valid => rxbag

        sendButton.rx.bind(to: formViewModel.submitAction, input: ())
        formViewModel.submitAction.executionObservables
            .switchLatest()
            .subscribe(onNext: { formData in
                print(formData.parameters as Any)
                // Show a notification that money has been sent
            }) => rxbag

        formViewModel.formSubmittingSubject.skip(1)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {return}
                self.view.endEditing(true)
                // Do something for loading
            }) => rxbag

    }

    func configUI() {
        firstnameTextField.inputType = .firstname
        lastnameTextField.inputType = .lastname
        phoneNumberTextField.inputType = .phoneNumber
        amountTextField.inputType = .decimal
    }

}
