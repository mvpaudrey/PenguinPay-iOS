//
//  CountryPickerViewModel.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import Foundation
import PhoneNumberKit

typealias Country = CountryPickerViewController.Country

final class CountryPickerViewModel {

    let phoneNumberKit: PhoneNumberKit = PhoneNumberKit(metadataCallback: PhoneNumberKit.customMetadataCallback)

    lazy var allCountries = phoneNumberKit
        .allCountries()
        .compactMap({ Country(for: $0, with: self.phoneNumberKit) })
        .sorted(by: { $0.name.caseInsensitiveCompare($1.name) == .orderedAscending })

    lazy var countries: [[Country]] = {
        let countries = allCountries
            .reduce([[Country]]()) { collection, country in
                var collection = collection
                guard var lastGroup = collection.last else { return [[country]] }
                let lhs = lastGroup.first?.name.folding(options: .diacriticInsensitive, locale: nil)
                let rhs = country.name.folding(options: .diacriticInsensitive, locale: nil)
                if lhs?.first == rhs.first {
                    lastGroup.append(country)
                    collection[collection.count - 1] = lastGroup
                } else {
                    collection.append([country])
                }
                return collection
            }
        return countries
    }()

    func country(for indexPath: IndexPath) -> Country {
        countries[indexPath.section][indexPath.row]
    }

}
