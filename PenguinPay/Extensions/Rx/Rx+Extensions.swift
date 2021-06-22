//
//  Rx+Extensions.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIButton {

    public var valid: Binder<Bool> {
        return Binder(base) { button, valid in
            button.isEnabled = valid
            button.backgroundColor = valid ? UIColor.blue : UIColor.gray
        }
    }

}

extension UIButton {

    func rxButtonValidator() -> Observable<Bool> {
        return self.rx.tap.map { [weak self] _ in
            guard let self = self else {return false}
            return !self.isSelected
        }.share(replay: 1, scope: .forever).asObservable()
    }
}
