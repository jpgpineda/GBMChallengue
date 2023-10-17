//
//  DrawerMenuViewController.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

import UIKit
import RxSwift
import RxCocoa

class DrawerMenuViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var userNameLabel: UILabel!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    private let configurator = DrawerMenuConfiguratorImplementation()
    var presenter: DrawerMenuPresenter!
    var transitionManager: DrawerTransitionManager?
    private let signOutBehaviour: BehaviorRelay = BehaviorRelay(value: false)
    var signOutObservable: Observable<Bool> {
        return signOutBehaviour.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
        presenter.fetchUserInfo()
    }
    
    @IBAction func openAppSettings(_ sender: UIButton) {
        presenter.openAppSettings()
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        presenter.showSignOutConfirmation()
    }
}

extension DrawerMenuViewController: DrawerMenuView {
    func notifySignOutRequested() {
        signOutBehaviour.accept(true)
    }
    
    func updateUserInfo(data: UserDTO) {
        userNameLabel.text = data.name + .whiteSpace + data.lastNames
    }
    
    func showFailure(message: String) {
        showErrorAlert(message: message)
    }
}
