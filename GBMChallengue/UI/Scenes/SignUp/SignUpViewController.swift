//
//  SignUpViewController.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

import UIKit

class SignUpViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var nameTextField: GBMTextField!
    @IBOutlet weak var lastNameTextField: GBMTextField!
    @IBOutlet weak var emailTextField: GBMTextField!
    @IBOutlet weak var passwordTextField: GBMTextField!
    @IBOutlet weak var signUpButton: GBMButton!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    private let configurator = SignUpConfiguratorImplementation()
    var presenter: SignUpPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
        setupView()
    }
    
    private func setupView() {
        
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        presenter.dismissView()
    }
}

extension SignUpViewController: SignUpView {
    func showFailure(message: String) {
        showErrorAlert(message: message)
    }
    
    func showSuccess(message: String) {
        showSuccessAlert(message: message)
    }
}
