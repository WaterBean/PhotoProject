//
//  AlertManager.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/23/25.
//

import UIKit

final class AlertManager {
   static func showErrorAlert(vc: UIViewController,
                               title: String = "오류 발생",
                               message: String,
                               buttonTitle: String = "확인",
                               handler: (() -> Void)? = nil) {
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
       let action = UIAlertAction(title: buttonTitle, style: .cancel) { _ in handler?() }
       
       alert.addAction(action)
       vc.present(alert, animated: true)
   }
}
