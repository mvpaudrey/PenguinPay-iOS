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

    var recipientBinarianMoney = Dynamic<String>(.empty)

    var currencyName = Dynamic<String>(.empty)

    // MARK: - Exchange rates

    let baseRate: String = Constants.baseRateCurrencyCode

    let openExchangeRatesClient = OpenExchangeRatesClient()

    var rates: [Currency] = []

    var currentCode: String = .empty

    var selectedCurrency: Currency?

    // swiftlint:disable line_length
    var currencies: String {
        "\(Countries.kenya.currency),\(Countries.nigeria.currency),\(Countries.tanzania.currency),\(Countries.uganda.currency)"
    }
    // swiftlint:enable line_length

    // MARK: - Initialization

    init() {
        getRates()
    }

    // MARK: - Form validation

    var isValid: Bool {
        !firstname.value.isNilOrEmpty &&
            !lastname.value.isNilOrEmpty &&
            isPhoneNumberValid &&
            !binarianMoney.value.isNilOrEmpty
    }

    var isPhoneNumberValid: Bool = false

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

    func updateCurrency(code: String) {
        currentCode = code
        if rates.count > 0 {
            guard let countryArea = Countries.findCountryArea(with: code),
                  let currency = rates.findCurrency(with: countryArea.currency) else {
                selectedCurrency = nil
                return
            }
            selectedCurrency = currency
        }
    }

    // Move this logic to a proper extension
    func computeCurrencyRateInBinary(amount: String?) -> String {
        guard let amount = amount,
              let amountInInt = Int(amount) else { return .empty }
        print("amountInInt: \(amountInInt)")
        guard let integer = Int(amount, radix: 2),
              let currency = selectedCurrency else { return .empty }
        let amountWithConversionRate = Int(ceil(Double(integer) * currency.rate)) // Not the best solution
        currencyName.value = currency.name
        // Move back to binary
        return String(amountWithConversionRate, radix: 2)
    }

    // MARK: - Private methods

    private func updateRates(response: OpenExchangeRatesPayload) {
        rates = response.rates.currencies
        updateCurrency(code: currentCode)
    }

}
