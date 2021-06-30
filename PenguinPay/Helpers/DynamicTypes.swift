//
//  DynamicTypes.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 23/06/2021.
//

import Foundation

/// Establish Dynamic Value for binding between ViewModel and ViewController properties
class Dynamic<T> {

    var bind: (T) -> Void = { _ in }

    var value: T? {
        didSet {
            guard let bindedValue = value else { return }
            bind(bindedValue)
        }
    }

    init(_ v: T) {
        value = v
    }

}
