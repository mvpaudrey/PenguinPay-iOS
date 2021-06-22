//
//  PhoneNumberKit+Extensions.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import Foundation
import PhoneNumberKit

extension PhoneNumberKit {

    /// Custom metadta callback, reads metadata from CustomPhoneNumberMetadata.json file in bundle
    ///
    /// - returns: an optional Data representation of the metadata.
    public static func customMetadataCallback() throws -> Data? {
        guard let jsonPath = Bundle.main.path(forResource: "CustomPhoneNumberMetadata", ofType: "json") else {
            throw PhoneNumberError.metadataNotFound
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: jsonPath))
        return data
    }

    public func allCountries() -> [String] {
        return ["NG", "TZ", "KE", "UG"]
    }

}
