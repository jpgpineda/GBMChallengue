//
//  TickerListViewController.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

import UIKit

class TickerListViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var tickersTableView: UITableView!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    private let configurator = TickerListConfiguratorImplementation()
    var presenter: TickerListPresenter!
    var tickers: [TickerDetailDTO] = [TickerDetailDTO]()
    var currentOffset: Int = .zero
    var currentLimit: Int = .zero
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupView()
    }
    
    private func setupView() {
        presenter.requestTickers(offSet: nil)
        tickersTableView.registerCell(TickerTableViewCell.identifier)
        tickersTableView.dataSource = self
        tickersTableView.delegate = self
        refreshControl.addTarget(self, action: #selector(loadMoreTickers), for: .valueChanged)
        tickersTableView.refreshControl = refreshControl
    }
    
    @objc private func loadMoreTickers() {
        presenter.requestTickers(offSet: currentOffset)
    }
    
    @IBAction func openDrawerMenu(_ sender: UIButton) {
        presenter.presentDrawerMenu()
    }
}

extension TickerListViewController: TickerListView {
    func showFailure(message: String) {
        showErrorAlert(message: message)
    }
    
    func updateTickerList(tickers: [TickerDetailDTO]) {
        self.tickers = tickers
        refreshControl.endRefreshing()
        tickersTableView.reloadData()
    }
}

extension TickerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TickerTableViewCell.identifier, for: indexPath) as? TickerTableViewCell else { return UITableViewCell() }
        cell.setupView(ticker: tickers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tickers.count - 1 {
            loadMoreTickers()
        }
    }
}

extension TickerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.presentTickerDetail(ticker: tickers[indexPath.row])
    }
}
