//
//  OpenExchangeRatesServiceError.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import Foundation

enum OpenExchangeRatesServiceError: Error {
    case invalidEndpoint
    case apiError
    case invalidResponse

    /// Error when decoding with a successful request
    case decodingError

    /// No data was returned
    case noData
}
