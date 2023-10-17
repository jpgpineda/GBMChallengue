//
//  TickerDetailViewController.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

import UIKit
import DGCharts
import TinyConstraints

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
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    private let configurator = TickerDetailConfiguratorImplementation()
    var presenter: TickerDetailPresenter!
    var ticker: TickerDetailDTO?
    var intraday: [IntradayDataDTO] = [IntradayDataDTO]()
    var isFilterShowing: Bool = false
    var selectedTime: TimeIntervalType = .today
    var selectedValue: ValueForChartType = .openPrice
    var isFavorite: Bool = false
    lazy var lineChart: LineChartView = {
        let chartView = LineChartView()
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .topInside
        chartView.animate(xAxisDuration: 2.5)
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
        setupView()
    }
    
    private func setupView() {
        guard let ticker = ticker else { return }
        presenter.checkIfTickerIsFavorite(ticker: ticker)
        presenter.getTickerDetail(ticker: ticker)
        tickerNameLabel.text = ticker.name
        tickerSymbolLabel.text = ticker.symbol
        stockAcronymLabel.text = ticker.stock.acronym
        stockCountry.text = ticker.stock.country
        chartView.addSubview(lineChart)
        lineChart.centerInSuperview()
        lineChart.width(to: chartView)
        lineChart.height(to: chartView)
    }
    
    @IBAction func applyFiilter(_ sender: GBMFilterButton) {
        filterView.isHidden = true
        isFilterShowing = false
        selectedValue = ValueForChartType(rawValue: sender.tag) ?? .openPrice
        presenter.setupCharData(timeInterval: selectedTime,
                                valueForChart: selectedValue,
                                intraday: intraday)
    }
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        guard let ticker = ticker else { return }
        if isFavorite {
            presenter.removeTickerFromFavorites(ticker: ticker)
        } else {
            presenter.saveTickerToFavorites(ticker: ticker)
        }
    }
    
    @IBAction func presentFilterView(_ sender: UIButton) {
        filterView.isHidden = isFilterShowing
        isFilterShowing = !isFilterShowing
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        presenter.dismissView()
    }
    
    @IBAction func filterByDate(_ sender: GBMFilterButton) {
        sender.isSelected = !sender.isSelected
        selectedTime = TimeIntervalType(rawValue: sender.tag) ?? .today
        presenter.setupCharData(timeInterval: selectedTime,
                                valueForChart: selectedValue,
                                intraday: intraday)
    }
}

extension TickerDetailViewController: TickerDetailView {
    func updateFavoriteButtonState(isFavorite: Bool) {
        self.isFavorite = isFavorite
        favoriteButton.isFavorite = isFavorite
    }
    
    func showSuccess(message: String) {
        favoriteButton.isFavorite = true
        showSuccessAlert(message: message)
    }
    
    func updateChart(with dataSet: [ChartDataEntry]) {
        let set = LineChartDataSet(entries: dataSet, label: .Localized.prices)
        set.drawCirclesEnabled = false
        set.fillColor = .label
        set.mode = .cubicBezier
        set.setColor(.label)
        set.fill = ColorFill(color: .label)
        set.fillAlpha = 0.8
        set.highlightColor = .systemBlue
        let data = LineChartData(dataSet: set)
        lineChart.data = data
    }
    
    func updateIntradayInfo(intraday: IntradayDataDTO) {
        openPriceLabel.text = intraday.open.toString()
        closePriceLabel.text = intraday.close?.toString()
        highPriceLabel.text = intraday.high.toString()
        lowPriceLabel.text = intraday.low.toString()
        volumeLabel.text = intraday.volume?.toString()
        dateLabel.text = CVDateFormatter.shortDate(intraday.date)
    }
    
    func updateInfo(intraday: TickerIntradayDTO) {
        self.intraday = intraday.tickerDetail.intraday
        presenter.setupCharData(timeInterval: selectedTime,
                                valueForChart: selectedValue,
                                intraday: self.intraday)
    }
    
    func showFailure(message: String) {
        showErrorAlert(message: message)
    }
}
