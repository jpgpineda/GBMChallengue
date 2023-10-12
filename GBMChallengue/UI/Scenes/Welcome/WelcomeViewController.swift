//
//  ViewController.swift
//  GBMChallengue
//
//  Created by javier pineda on 10/10/23.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func showSignIn(_ sender: GBMButton) {
        guard let viewController = ModuleManager.accessDependency.makeSignInViewController() else { return }
        show(viewController, sender: nil)
    }
}

