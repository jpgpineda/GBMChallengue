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
    @IBOutlet weak var tickerSymbolLabel: UILabel!
    @IBOutlet weak var tickerNameLabel: UILabel!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockAcronymLabel: UILabel!
    @IBOutlet weak var stockCountry: UILabel!
    @IBOutlet weak var openPriceLabel: UILabel!
    @IBOutlet weak var closePriceLabel: UILabel!
    @IBOutlet weak var highPriceLabel: UILabel!
    @IBOutlet weak var lowPriceLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    private let configurator = TickerDetailConfiguratorImplementation()
    var presenter: TickerDetailPresenter!
    var ticker: TickerDetailDTO?
    var isFilterShowing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
        setupView()
    }
    
    private func setupView() {
        guard let ticker = ticker else { return }
        presenter.getTickerDetail(ticker: ticker)
        tickerNameLabel.text = ticker.name
        tickerSymbolLabel.text = ticker.symbol
        stockAcronymLabel.text = ticker.stock.acronym
        stockCountry.text = ticker.stock.country
    }
    
    @IBAction func applyFiilter(_ sender: GBMFilterButton) {
        filterView.isHidden = true
        isFilterShowing = false
    }
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        
    }
    
    @IBAction func presentFilterView(_ sender: UIButton) {
        filterView.isHidden = isFilterShowing
        isFilterShowing = !isFilterShowing
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        presenter.dismissView()
    }
}

extension TickerDetailViewController: TickerDetailView {
    func updateInfo(intraday: TickerIntradayDTO) {
        print(intraday)
    }
    
    func showFailure(message: String) {
        showErrorAlert(message: message)
    }
}
