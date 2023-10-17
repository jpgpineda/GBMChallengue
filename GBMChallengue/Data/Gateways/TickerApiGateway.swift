//
//  TickerApiGateway.swift
//  GBMChallengue
//
//  Created by javier pineda on 10/10/23.
//

import Foundation

protocol TickerApiGateway {
    var apiClient: ApiClient { get set }
    var storageContext: StorageContext { get set }
    func fetchTickers(parameters: TickerRequest) async -> ApiResult<Tickers>
    func fetchTickerIntradayData(parameters: TickerIntradayRequest) async -> ApiResult<TickerIntraday>
    func fetchTickerLatestIntradayData(parameters: TickerIntradayLatestRequest) async -> ApiResult<Intraday>
    func saveTickerToFavorites(ticker: TickerDetailDTO, completion: @escaping ModelOperationCompletionHandler)
    func getFavoriteTickers() -> [TickerModel]?
    func deleteTicker(ticker: TickerDetailDTO, completion: @escaping ModelOperationCompletionHandler)
}

class TickerApiGatewayImplementation: TickerApiGateway {
    internal var apiClient: ApiClient
    internal var storageContext: StorageContext
    
    init(apiClient: ApiClient,
         storageContext: StorageContext) {
        self.apiClient = apiClient
        self.storageContext = storageContext
    }
    
    func fetchTickers(parameters: TickerRequest) async -> ApiResult<Tickers> {
        guard let urlRequest = parameters.apiRequest else { return .failure(ApiError.unknown) }
        do {
            let response = try await apiClient.fetch(type: Tickers.self, with: urlRequest)
            return .success(response)
        } catch {
            return .failure(ApiError.requestFailed(description: error.localizedDescription))
        }
    }
    
    func fetchTickerIntradayData(parameters: TickerIntradayRequest) async -> ApiResult<TickerIntraday> {
        guard let apiRequest = parameters.apiRequest else { return .failure(.unknown) }
        do {
            let response = try await apiClient.fetch(type: TickerIntraday.self, with: apiRequest)
            return .success(response)
        } catch {
            return .failure(ApiError.requestFailed(description: error.localizedDescription))
        }
    }
    
    func fetchTickerLatestIntradayData(parameters: TickerIntradayLatestRequest) async -> ApiResult<Intraday> {
        guard let apiRequest = parameters.apiRequest else { return .failure(ApiError.unknown) }
        do {
            let response = try await apiClient.fetch(type: Intraday.self, with: apiRequest)
            return .success(response)
        } catch {
            return .failure(ApiError.requestFailed(description: error.localizedDescription))
        }
    }
    
    func saveTickerToFavorites(ticker: TickerDetailDTO, completion: @escaping ModelOperationCompletionHandler) {
        storageContext.saveModel(model: TickerModel(with: ticker), completion: completion)
    }
    
    func getFavoriteTickers() -> [TickerModel]? {
        return storageContext.getModel(model: TickerModel.self, predicate: nil) as? [TickerModel]
    }
    
    func deleteTicker(ticker: TickerDetailDTO, completion: @escaping ModelOperationCompletionHandler) {
        storageContext.deleteModel(model: TickerModel(with: ticker), completion: completion)
    }
}
