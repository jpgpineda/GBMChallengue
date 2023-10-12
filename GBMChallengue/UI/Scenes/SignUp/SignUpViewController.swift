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
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        presenter.dismissView()
    }
    
    @IBAction func requestSignUp(_ sender: GBMButton) {
        presenter.requestSignUp()
    }
    
    private func validateData() {
        signUpButton.isActive = presenter.validateData()
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

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch textField {
        case nameTextField:
            textField.setState(isError: text.isEmpty)
            presenter.name = text
        case lastNameTextField:
            textField.setState(isError: text.isEmpty)
            presenter.lastName = text
        case emailTextField:
            if !text.isValidEmail() || text.isEmpty {
                textField.setState(isError: true)
                showErrorAlert(message: .Localized.invalidEmail)
                presenter.email = .empty
            } else {
                textField.setState(isError: false)
                presenter.email = text
            }
        case passwordTextField:
            if !text.isPasswordValid() || text.isEmpty {
                textField.setState(isError: true)
                showErrorAlert(message: .Localized.invalidPassword)
                presenter.password = .empty
            } else {
                textField.setState(isError: false)
                presenter.password = text
            }
        default:
            break
        }
        validateData()
    }
}
