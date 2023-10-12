//
//  SignUpViewController.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit

class SignInViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var emailTextField: GBMTextField!
    @IBOutlet weak var passwordTextField: GBMTextField!
    @IBOutlet weak var signInButton: GBMContainer!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    private let configurator = SignInConfiguratorImplementation()
    var presenter: SignInPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(controller: self)
    }

    @IBAction func presentSignUP(_ sender: GBMDashedButton) {
        presenter.presentSignUp()
    }
    
    @IBAction func backToWelcome(_ sender: UIButton) {
        presenter.dismissScreen()
    }
}

extension SignInViewController: SignInView {
    
}
