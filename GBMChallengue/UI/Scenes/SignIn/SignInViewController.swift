//
//  SignUpViewController.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit
import LocalAuthentication

class SignInViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var emailTextField: GBMTextField!
    @IBOutlet weak var passwordTextField: GBMTextField!
    @IBOutlet weak var signInButton: GBMButton!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    private let configurator = SignInConfiguratorImplementation()
    var presenter: SignInPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(controller: self)
        presenter.requestBiometricLogin()
        setupView()
    }
    
    private func setupView() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.text = presenter.getLastSignUser()
    }

    @IBAction func requestSignIn(_ sender: GBMButton) {
        presenter.doSignIn()
    }
    
    @IBAction func presentSignUP(_ sender: GBMDashedButton) {
        presenter.presentSignUp()
    }
    
    @IBAction func backToWelcome(_ sender: UIButton) {
        presenter.dismissScreen()
    }
    
    @IBAction func activateBiometric(_ sender: GBMCheckButton) {
        presenter.isLocalAuthOn = !sender.isChecked
    }
    
    private func validateFields() {
        signInButton.isActive = presenter.validateData()
    }
}

extension SignInViewController: SignInView {
    func showFailure(message: String) {
        showErrorAlert(message: message)
    }
    
    func showSuccess(message: String) {
        showSuccessAlert(message: message)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if textField == emailTextField {
            if !text.isValidEmail() || text.isEmpty {
                textField.setState(isError: true)
                showErrorAlert(message: .Localized.invalidEmail)
            } else {
                textField.setState(isError: false)
            }
            presenter.email = text
        } else {
            if !text.isPasswordValid() || text.isEmpty {
                textField.setState(isError: true)
                showErrorAlert(message: .Localized.invalidPassword)
            } else {
                textField.setState(isError: false)
            }
            presenter.password = text
        }
        validateFields()
    }
}
