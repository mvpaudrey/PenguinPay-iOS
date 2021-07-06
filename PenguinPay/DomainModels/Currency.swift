//
//  Currency.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 23/06/2021.
//

import Foundation

struct Currency {

    let name: String

    let rate: Double

}

extension Array where Element == Currency {

    func findCurrency(with name: String) -> Currency? {
        first {  $0.name == name }
    }

}
