//
//  Countries.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import Foundation

enum Countries: String, CaseIterable {

    case nigeria = "NG"
    case kenya = "KE"
    case tanzania = "TZ"
    case uganda = "UG"

    var currency: String {
        switch self {
        case .nigeria:
            return "NGN"
        case .kenya:
            return "KES"
        case .tanzania:
            return "TZS"
        case .uganda:
            return "UGX"
        }
    }

    var name: String {
        switch self {
        case .nigeria:
            return "Nigeria"
        case .kenya:
            return "Kenya"
        case .uganda:
            return"Uganda"
        case .tanzania:
            return "Tanzania"
        }
    }
}

extension Countries {

    static func findCountryArea(with rawValue: String) -> Countries? {
        Countries.allCases.first { $0.rawValue == rawValue }
    }

}
