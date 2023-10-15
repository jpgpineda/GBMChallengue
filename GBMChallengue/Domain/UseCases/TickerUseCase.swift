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
}
