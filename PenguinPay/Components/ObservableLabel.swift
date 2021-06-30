//
//  ObservableLabel.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 24/06/2021.
//

import UIKit

class ObservableLabel: UILabel {

    var textDidChange: ((_ newText: String?) -> Void)?

    override var text: String? {
        didSet {
            if let textDidChange = textDidChange {
                textDidChange(self.text)
            }
        }
    }
}
