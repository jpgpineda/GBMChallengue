//
//  TickerListViewController.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

import UIKit
import RxSwift

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
    var currentOffset: Int = 100
    var currentLimit: Int = .zero
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupView()
    }
    
    private func setupView() {
        presenter.requestTickers(pagination: false, offSet: nil)
        tickersTableView.registerCell(TickerTableViewCell.identifier)
        tickersTableView.dataSource = self
        tickersTableView.delegate = self
    }
    
    private func loadMoreTickers() {
        presenter.requestTickers(pagination: true, offSet: currentOffset)
    }
    
    @IBAction func presentFavorites(_ sender: UIButton) {
        presenter.presentFavoriteTickers()
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
        self.tickers.append(contentsOf: tickers)
        currentOffset += 100
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
}

extension TickerListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tickersTableView.contentSize.height-100-scrollView.frame.size.height) {
            guard !presenter.isPaginating else { return }
            tickersTableView.alwaysBounceVertical = false
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
