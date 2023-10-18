//
//  RestorePasswordViewController.swift
//  GBMChallengue
//
//  Created by javier pineda on 18/10/23.
//

import UIKit

class RestorePasswordViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var restoreButton: GBMButton!
    
    @IBOutlet weak var emailTextField: GBMTextField!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    private let configurator = RestorePasswordConfiguratorImplementation()
    var presenter: RestorePasswordPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
        setupView()
    }
    
    private func setupView() {
        emailTextField.delegate = self
    }
    
    @IBAction func sendRestoreRequest(_ sender: GBMButton) {
        presenter.requestRestorePassword()
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        presenter.dismissView()
    }
    
    private func validateData() {
        restoreButton.isActive = presenter.validateData()
    }
}

extension RestorePasswordViewController: RestorePasswordView {
    func showSuccess(message: String) {
        showSuccessAlert(message: message)
    }
    
    func showFailure(message: String) {
        showErrorAlert(message: message)
    }
}

extension RestorePasswordViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if !text.isValidEmail() || text.isEmpty {
            textField.setState(isError: true)
            showErrorAlert(message: .Localized.invalidEmail)
        } else {
            textField.setState(isError: false)
        }
        presenter.email = text
        validateData()
    }
}
