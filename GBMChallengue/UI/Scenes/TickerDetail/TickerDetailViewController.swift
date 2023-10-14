//
//  TickerDetailViewController.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

import UIKit

class TickerDetailViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    private let configurator = TickerDetailConfiguratorImplementation()
    var presenter: TickerDetailPresenter!
    var ticker: TickerDetailDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension TickerDetailViewController: TickerDetailView {
    func showFailure(message: String) {
        showErrorAlert(message: message)
    }
}
