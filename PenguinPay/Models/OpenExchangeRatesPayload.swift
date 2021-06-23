//
//  OpenExchangeRatesPayload.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import Foundation

/// Codable Entities retrieved from
/// - Important: Not used in views
struct OpenExchangeRatesPayload: Decodable {

    let timestamp: TimeInterval
    let base: String
    let rates: RatesPayload
    let date: Date

    enum CodingKeys: String, CodingKey {
        case timestamp
        case base
        case rates
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        timestamp = try container.decode(Double.self, forKey: .timestamp)
        base = try container.decode(String.self, forKey: .base)
        rates = try container.decode(RatesPayload.self, forKey: .rates)
        date = Date(timeIntervalSince1970: timestamp)
    }
}
