//
//  TickerDetailPresenter.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

import Foundation
import DGCharts

protocol TickerDetailView {
    func showFailure(message: String)
    func updateInfo(intraday: TickerIntradayDTO)
    func updateIntradayInfo(intraday: IntradayDataDTO)
    func updateChart(with info: [ChartDataEntry])
    func showSuccess(message: String)
}

protocol TickerDetailPresenter {
    var view: TickerDetailView { get set }
    var router: TickerDetailRouter { get set }
    var useCase: TickerUseCase { get set }
    func getTickerDetail(ticker: TickerDetailDTO)
    func setupCharData(timeInterval: TimeIntervalType,
                       valueForChart: ValueForChartType,
                       intraday: [IntradayDataDTO])
    func saveTickerToFavorites(ticker: TickerDetailDTO)
    func dismissView()
}

class TickerDetailPresenterImplementation: TickerDetailPresenter {
    internal var view: TickerDetailView
    internal var router: TickerDetailRouter
    internal var useCase: TickerUseCase
    var chartData: [ChartDataEntry] = [ChartDataEntry]()
    
    init(view: TickerDetailView,
         router: TickerDetailRouter,
         useCase: TickerUseCase) {
        self.view = view
        self.router = router
        self.useCase = useCase
    }
    
    func getTickerDetail(ticker: TickerDetailDTO) {
        let parameters = TickerIntradayRequest(symbol: ticker.symbol)
        router.showLoader()
        Task {
            let response = await useCase.requesTickerIntraday(parameters: parameters)
            switch response {
            case .success(let tickerIntraday):
                DispatchQueue.main.async {
                    self.view.updateInfo(intraday: tickerIntraday)
                }
                requestLatestIntradayData(ticker: ticker)
            case .failure(let error):
                router.dismissLoader()
                view.showFailure(message: error.localizedDescription)
            }
        }
    }
    
    private func requestLatestIntradayData(ticker: TickerDetailDTO) {
        let parameters = TickerIntradayLatestRequest(symbol: ticker.symbol)
        Task {
            let response = await useCase.requestLatestIntradayData(parameters: parameters)
            router.dismissLoader()
            switch response {
            case .success(let intraday):
                DispatchQueue.main.async {
                    self.view.updateIntradayInfo(intraday: intraday)
                }
            case .failure(let error):
                view.showFailure(message: error.localizedDescription)
            }
        }
    }
    
    func setupCharData(timeInterval: TimeIntervalType,
                       valueForChart: ValueForChartType,
                       intraday: [IntradayDataDTO]) {
        chartData.removeAll()
        switch timeInterval {
        case .today:
            let filterItems: [Double] = intraday.filter {
                $0.date <= Date()
            }.compactMap {
                $0.date.timeIntervalSince1970
            }
            for (x,y) in zip(filterItems, intraday) {
                chartData.append(ChartDataEntry(x: x, y: y.getValueByType(type: valueForChart)))
            }
        case .week:
            let filterItems: [Double] = intraday.filter {
                $0.date <= Date().oneWeekAfter()
            }.compactMap {
                $0.date.timeIntervalSince1970
            }
            for (x,y) in zip(filterItems, intraday) {
                chartData.append(ChartDataEntry(x: x, y: y.getValueByType(type: valueForChart)))
            }
        case .month:
            let filterItems: [Double] = intraday.filter {
                $0.date <= Date().oneMonthAfter()
            }.compactMap {
                $0.date.timeIntervalSince1970
            }
            for (x,y) in zip(filterItems, intraday) {
                chartData.append(ChartDataEntry(x: x, y: y.getValueByType(type: valueForChart)))
            }
        case .year:
            let filterItems: [Double] = intraday.filter {
                $0.date <= Date().oneYearAfter()
            }.compactMap {
                $0.date.timeIntervalSince1970
            }
            for (x,y) in zip(filterItems, intraday) {
                chartData.append(ChartDataEntry(x: x, y: y.getValueByType(type: valueForChart)))
            }
        }
        view.updateChart(with: chartData)
    }
    
    func saveTickerToFavorites(ticker: TickerDetailDTO) {
        router.showLoader()
        useCase.saveTickerToFavorites(ticker: ticker) { [weak self] result in
            self?.router.dismissLoader()
            switch result {
            case .success(_):
                self?.view.showSuccess(message: .Localized.tickerSaved)
            case .failure(let error):
                self?.view.showFailure(message: error.customDescription)
            }
        }
    }
    
    func dismissView() {
        router.dismissView()
    }
}
