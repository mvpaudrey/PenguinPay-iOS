//
//  RatesPayload.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 23/06/2021.
//

import Foundation

struct RatesPayload: Decodable {

    let currencies: [Currency]

    // Define DynamicCodingKeys type needed for creating
    // decoding container from JSONDecoder
    private struct DynamicCodingKeys: CodingKey {

        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        // Create a decoding container using DynamicCodingKeys
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var decodedCurrencies = [Currency]()
        for key in container.allKeys {
            guard let dynamicCodingKey = DynamicCodingKeys(stringValue: key.stringValue) else {
                throw DecodingError.dynamicCodingKeyNotFound
            }
            let decodedValue = try container.decode(Double.self, forKey: dynamicCodingKey)
            decodedCurrencies.append(Currency(name: key.stringValue, rate: decodedValue))
        }

        currencies = decodedCurrencies

    }

}
