//
//  UIViewController+Ext.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit
import NotificationBannerSwift

extension UIViewController {
    func showLoader() {
        guard let viewController = ModuleManager.toolsDependency.makeLoaderViewController() else { return }
        addChild(viewController)
        guard let loaderView = viewController.view else { return }
        loaderView.tag = 100
        view.addSubview(loaderView)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    func dismissLoader() {
        DispatchQueue.main.async {
            guard let loaderView = self.view.viewWithTag(100) else { return }
            loaderView.removeFromSuperview()
        }
    }
    
    func showErrorAlert(message: String) {
        let errorBanner = NotificationBanner(title: .Localized.ups,
                                             subtitle: message,
                                             style: .danger)
        DispatchQueue.main.async {
            errorBanner.show()
        }
    }
    
    func showSuccessAlert(message: String) {
        let successBanner = NotificationBanner(title: .Localized.congratsTitle,
                                               subtitle: message,
                                               style: .success)
        DispatchQueue.main.async {
            successBanner.show()
        }
    }
    
    func getDeleteActionConfiguration(deleteAction: @escaping() -> Void) -> UISwipeActionsConfiguration {
        let delete = UIContextualAction(style: .destructive, title: .Localized.delete) { _, _, completion in
            deleteAction()
            completion(true)
        }
        delete.image = UIImage(systemName: "trash.fill")
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
    
    func showConfimation(title: String,
                         message: String,
                         cancel: String?,
                         confirm: String,
                         confirmAction:  @escaping() -> Void) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .actionSheet)
        
        if let cancel = cancel {
            alert.addAction(UIAlertAction(title: cancel,
                                          style: .destructive,
                                          handler: nil))
        }
        
        alert.addAction(UIAlertAction(title: confirm,
                                      style: .default,
                                      handler: { (action) in
                                        
                                        confirmAction()
                                        
        }))
        
        present(alert, animated: true, completion: nil)
    } 
}
