//
//  UIViewController+Reactive .swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 12.06.2022.
//

import UIKit
import RxSwift

extension Reactive where Base: UIViewController {
    
    var showAlert: Binder<String> {
        return Binder(self.base) { viewController, textError in
            let alert = UIAlertController(title: "Something went wrong",
                                          message: textError,
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
}
