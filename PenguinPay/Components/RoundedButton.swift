//
//  RoundedButton.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 21/06/2021.
//

import UIKit

public class RoundedButton: UIButton {

    /// The corner radius value to have a button with rounded corners.
    open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {

        cornerRadius = 5.0
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        setTitleColor(.white, for: .normal)
        setTitle(titleLabel?.text, for: .normal)
        setTitle(titleLabel?.text, for: .disabled)
        setTitleColor(.white, for: .disabled)
        layer.masksToBounds = true
    }

}
