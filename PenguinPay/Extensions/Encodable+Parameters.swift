//
//  Encodable+Parameters.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import Foundation

extension Encodable {

    var parameters: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(
                    with: data, options: .allowFragments))
            .flatMap { $0 as? [String: Any] }
    }

}
