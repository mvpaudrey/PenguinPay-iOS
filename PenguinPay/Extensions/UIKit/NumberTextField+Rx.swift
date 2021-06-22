//
//  NumberTextField+Rx.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

extension NumberTextField {

    func rxValidator() -> Observable<Bool> {
         rx.text
            .orEmpty
            .map({ [weak self] (text) -> Bool in
                guard let self = self else { return false }
                return (self.text?.count ?? 0) > 0 ? self.isValidNumber : true
            })
            .share(replay: 1, scope: .forever)
            .asObservable()
    }
}
