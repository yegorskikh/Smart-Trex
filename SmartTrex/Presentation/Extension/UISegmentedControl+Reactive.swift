//
//  UISegmentedControl+Reactive.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 12.06.2022.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UISegmentedControl {

    var selectedTitle: ControlProperty<String> {
        return base.rx.controlProperty(
            editingEvents: .allEvents,
            getter: { base in
                let index = base.selectedSegmentIndex
                return base.titleForSegment(at: index) ?? ""
            },
            setter: { base, title in
                let index = base.selectedSegmentIndex
                base.setTitle(title, forSegmentAt: index)
            })
    }
    
}
