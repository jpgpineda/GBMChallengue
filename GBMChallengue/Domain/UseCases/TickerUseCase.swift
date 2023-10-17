//
//  TickerUseCase.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

protocol TickerUseCase {
    var apiGateway: TickerApiGateway { get set }
    func requestTicker(parameters: TickerRequest) async -> ApiResult<TickersDTO>
    func requesTickerIntraday(parameters: TickerIntradayRequest) async -> ApiResult<TickerIntradayDTO>
    func requestLatestIntradayData(parameters: TickerIntradayLatestRequest) async -> ApiResult<IntradayDataDTO>
    func saveTickerToFavorites(ticker: TickerDetailDTO, completion: @escaping ModelOperationCompletionHandler)
    func getFavoriteTickers() -> [TickerDetailDTO]?
    func deleteTicker(ticker: TickerDetailDTO, completion: @escaping ModelOperationCompletionHandler)
}

class TickerUseCaseImplementation: TickerUseCase {
    internal var apiGateway: TickerApiGateway
    
    init(apiGateway: TickerApiGateway) {
        self.apiGateway = apiGateway
    }
    
    func requestTicker(parameters: TickerRequest) async -> ApiResult<TickersDTO> {
        let response = await apiGateway.fetchTickers(parameters: parameters)
        switch response {
        case .success(let tickers):
            return .success(TickersDTO(with: tickers))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func requesTickerIntraday(parameters: TickerIntradayRequest) async -> ApiResult<TickerIntradayDTO> {
        let response = await apiGateway.fetchTickerIntradayData(parameters: parameters)
        switch response {
        case .success(let ticker):
            return .success(TickerIntradayDTO(with: ticker))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func requestLatestIntradayData(parameters: TickerIntradayLatestRequest) async -> ApiResult<IntradayDataDTO> {
        let response = await apiGateway.fetchTickerLatestIntradayData(parameters: parameters)
        switch response {
        case .success(let intraday):
            return .success(IntradayDataDTO(with: intraday))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func saveTickerToFavorites(ticker: TickerDetailDTO, completion: @escaping ModelOperationCompletionHandler) {
        apiGateway.saveTickerToFavorites(ticker: ticker, completion: completion)
    }
    
    func getFavoriteTickers() -> [TickerDetailDTO]? {
        guard let tickers = apiGateway.getFavoriteTickers(),
              !tickers.isEmpty else { return nil }
        return tickers.compactMap {
            TickerDetailDTO(with: $0)
        }
    }
    
    func deleteTicker(ticker: TickerDetailDTO, completion: @escaping ModelOperationCompletionHandler) {
        apiGateway.deleteTicker(ticker: ticker, completion: completion)
    }
}
