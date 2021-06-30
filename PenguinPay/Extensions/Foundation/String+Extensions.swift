//
//  String+Extensions.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import Foundation

extension String {

    static let empty = ""

    func trim() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func isEmpty() -> Bool {
        count == 0
    }

    var isNumeric: Bool {
        return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
    }

    var asBinaryInt: Int? {
        Int(self.trim(), radix: 2)
    }

}

extension Optional where Wrapped == String {

    var orEmpty: String {
        self ?? .empty
    }
}

public extension Optional where Wrapped == String {

    var isNilOrEmpty: Bool {
        guard let self = self else { return true }
        return self.isEmpty
    }

}
