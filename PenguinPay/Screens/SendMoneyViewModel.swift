//
//  SendMoneyViewModel.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 21/06/2021.
//

import Foundation
import CoreGraphics

protocol SendMoneyViewModelProtocol {

    var isValid: Bool { get }
}

final class SendMoneyViewModel: SendMoneyViewModelProtocol {

    // MARK: - Form fields

    var firstname = Dynamic<String>(.empty)

    var lastname = Dynamic<String>(.empty)

    var phoneNumber = Dynamic<String>(.empty)

    var binarianMoney = Dynamic<String>(.empty)

    var currencyName = Dynamic<String>(.empty)

    // MARK: - Exchange rates

    let baseRate: String = Constants.baseRateCurrencyCode

    let openExchangeRatesClient = OpenExchangeRatesClient()

    var rates: [Currency] = []

    // swiftlint:disable line_length
    var currencies: String {
        "\(Countries.kenya.currency),\(Countries.nigeria.currency),\(Countries.tanzania.currency),\(Countries.uganda.currency)"
    }
    // swiftlint:enable line_length

    // MARK: - Initialization

    init() {
        // getRates()
    }

    // MARK: - Form validation

    var isValid: Bool {
        !firstname.value.isNilOrEmpty &&
            !lastname.value.isNilOrEmpty &&
            !phoneNumber.value.isNilOrEmpty &&
            !binarianMoney.value.isNilOrEmpty
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
