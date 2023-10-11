//
//  TickerApiGateway.swift
//  GBMChallengue
//
//  Created by javier pineda on 10/10/23.
//

import Foundation

protocol TickerApiGateway {
    func fetchTickers(parameters: TickerRequest) async -> ApiResult<Tickers?>
}

class TickerApiGatewayImplementation: TickerApiGateway {
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchTickers(parameters: TickerRequest) async -> ApiResult<Tickers?> {
        guard let urlRequest = parameters.apiRequest else { return .failure(ApiError.unknown) }
        do {
            let response = try await apiClient.fetch(type: Tickers.self, with: urlRequest)
            return .success(response)
        } catch {
            return .failure(ApiError.requestFailed(description: error.localizedDescription))
        }
    }
}
