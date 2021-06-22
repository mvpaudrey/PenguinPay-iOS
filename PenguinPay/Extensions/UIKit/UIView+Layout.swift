//
//  UIView+Layout.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import UIKit

extension UIView {

    func setupRoundedLayout() {
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 0.4

        layer.masksToBounds = true
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5.0

        clipsToBounds = true

        backgroundColor = UIColor.white
    }

}
