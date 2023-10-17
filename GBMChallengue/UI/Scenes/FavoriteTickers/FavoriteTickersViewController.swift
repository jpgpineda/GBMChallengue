//
//  FavoriteTickersViewController.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

import UIKit

class FavoriteTickersViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var emptyTickersLabel: UILabel!
    @IBOutlet weak var tickerTable: UITableView!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    private let configurator = FavoriteTickersConfiguratorImplementation()
    var presenter: FavoriteTickerPresenter!
    var tickers: [TickerDetailDTO] = [TickerDetailDTO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
        presenter.getFavorites()
        setupView()
    }
    
    private func setupView() {
        tickerTable.registerCell(TickerTableViewCell.identifier)
        tickerTable.dataSource = self
        tickerTable.delegate = self
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        presenter.dismissView()
    }
}

extension FavoriteTickersViewController: FavoriteTickerView {
    func showSuccess(message: String) {
        showSuccessAlert(message: message)
    }
    
    func showFailure(message: String) {
        showErrorAlert(message: message)
    }
    
    func updateTickerList(data: [TickerDetailDTO]) {
        tickers = data
        emptyTickersLabel.isHidden = true
        tickerTable.reloadData()
    }
}

extension FavoriteTickersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TickerTableViewCell.identifier, for: indexPath) as? TickerTableViewCell else { return UITableViewCell() }
        cell.setupView(ticker: tickers[indexPath.row])
        return cell
    }
}

extension FavoriteTickersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.presentTickerDetail(ticker: tickers[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return getDeleteActionConfiguration {
            self.presenter.presentDeletionAlert(ticker: self.tickers[indexPath.row])
        }
    }
}
