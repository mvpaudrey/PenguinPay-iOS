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
        trim().count == 0
    }

    var isNumeric: Bool {
        return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
    }

    func isValidName() -> Bool {

        let nameRegEx = "^[A-Za-z]+(?:\\s[A-Za-z]+)"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return trim().count > 0 && nameTest.evaluate(with: self)
    }

}

extension Optional where Wrapped == String {

    var orEmpty: String {
        self ?? .empty
    }
}

public extension Optional where Wrapped == String {

    var isNilOrEmpty: Bool {
        return self == nil || ((self?.isEmpty) == nil)
    }

}
