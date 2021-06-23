//
//  SendMoneyViewModel.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 21/06/2021.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import CoreGraphics

final class SendMoneyViewModel {

    let baseRate: String = Constants.baseRateCurrencyCode

    var rates: [Currency] = []

    // swiftlint:disable line_length
    var currencies: String {
        "\(CountryId.kenya.currency),\(CountryId.nigeria.currency),\(CountryId.tanzania.currency),\(CountryId.uganda.currency)"
    }
    // swiftlint:enable line_length

    let firstnameSubject = BehaviorRelay<String?>(value: nil)
    let lastnameSubject = BehaviorRelay<String?>(value: nil)
    let phoneNumberSubject = BehaviorRelay<String?>(value: nil)
    let amountSubject = BehaviorRelay<String?>(value: nil)
    let currencySubject = BehaviorRelay<String?>(value: nil)
    let sendButtonEnabled = BehaviorRelay(value: false)

    let formSubmittingSubject: BehaviorRelay<Bool> = BehaviorRelay.init(value: false)

    private let numberTextField = NumberTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    private let disposeBag = DisposeBag()

    let openExchangeRatesClient = OpenExchangeRatesClient()

    lazy var submitAction: Action<Void, Form> = {
        Action(enabledIf: sendButtonEnabled.asObservable()) {
            self.formSubmittingSubject.accept(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.formSubmittingSubject.accept(false)
            }
            return self.getFormData()
        }
    }()

    private func getFormData() -> Observable<Form> {
        let firstname = firstnameSubject.value.orEmpty
        let lastname = lastnameSubject.value.orEmpty
        let phoneNumber = phoneNumberSubject.value.orEmpty
        let amountToSend = amountSubject.value.orEmpty
        let currency = currencySubject.value.orEmpty
        numberTextField.text = phoneNumber
        let fromData = Form(
            firstname: firstname,
            lastname: lastname,
            amountSent: amountToSend,
            currency: currency,
            countryCode: numberTextField.getCountryCode(),
            phoneNumber: !(numberTextField.text?.isEmpty ?? false) ? numberTextField.getNumber() : .empty
        )
        return .just(fromData)
    }

    init() {
        Observable.combineLatest(
            firstnameSubject,
            lastnameSubject,
            phoneNumberSubject,
            amountSubject
        ) { [weak self] (firstname, lastname, number, amount) -> Bool in
            self?.numberTextField.text = number
            return (!firstname.isNilOrEmpty &&
                    !lastname.isNilOrEmpty &&
                    !amount.isNilOrEmpty &&
                    !number.isNilOrEmpty)
                    // (!number.isNilOrEmpty ? (self?.numberTextField.isValidNumber ?? false) : true)
        } ~> sendButtonEnabled => disposeBag // One-way binding

        getRates()
    }

    func getRates() {
        // swiftlint:disable line_length
        openExchangeRatesClient.getRates(base: baseRate, to: currencies) { [weak self] (result: Result<OpenExchangeRatesPayload, OpenExchangeRatesServiceError>) in
        // swiftlint:enable line_length
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.updateRates(response: response)
                print("response: \(response)")
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }

    func updateRates(response: OpenExchangeRatesPayload) {
        rates = response.rates.currencies
    }

}
