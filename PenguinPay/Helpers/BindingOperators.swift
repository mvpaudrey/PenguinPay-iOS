//
//  BindingOperators.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

public func ~><T> (source: Observable<T>, relay: BehaviorRelay<T>) -> Disposable {
    return source.bind(to: relay)
}

// MARK: - Two way binding

infix operator <~> : DefaultPrecedence

public func <~><T> (property: ControlProperty<T>, relay: BehaviorRelay<T>) -> Disposable {
    let bindToUIDisposable = relay.bind(to: property)
    let bindToRelay = property.bind(to: relay)

    return Disposables.create(bindToUIDisposable, bindToRelay)
}

/// BehaviorRelay
public func ~><T> (relay: BehaviorRelay<T>, observer: Binder<T>) -> Disposable {
    return relay.bind(to: observer)
}

func <~><T> (relay: BehaviorRelay<T>, property: ControlProperty<T>) -> Disposable {
    let bindToUIDisposable = relay.bind(to: property)
    let bindToRelay = property.bind(to: relay)

    return Disposables.create(bindToUIDisposable, bindToRelay)
}

// MARK: - Add to dispose bag shorthand

precedencegroup DisposablePrecedence {
    lowerThan: DefaultPrecedence
}

infix operator =>: DisposablePrecedence

public func => (disposable: Disposable?, bag: DisposeBag?) {
    if let d = disposable, let b = bag {
        d.disposed(by: b)
    }
}
