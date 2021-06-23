//
//  CountryId.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import Foundation

enum CountryId: String, CaseIterable {

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
}
