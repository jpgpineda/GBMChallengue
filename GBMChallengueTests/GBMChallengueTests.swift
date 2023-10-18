//
//  GBMChallengueTests.swift
//  GBMChallengueTests
//
//  Created by javier pineda on 10/10/23.
//

import XCTest
@testable import GBMChallengue

final class GBMChallengueTests: GBMBaseTest {
    func testTickerResponseNotEmpty() async {
        // Arrange
        let apiGateway = TickerApiGatewayImplementation(apiClient: apiClient,
                                                        storageContext: storageContext)
        let useCase = TickerUseCaseImplementation(apiGateway: apiGateway)
        
        // Act
        let result = await useCase.requestTicker(parameters: TickerRequest(isUnitTest: true))
        
        // Assert
        switch result {
        case .success(let tickers):
            XCTAssertFalse(tickers.tickers.isEmpty)
        case .failure(let apiError):
            XCTFail("The test has failed: \(apiError.customDescription)")
        }
    }
    
    func testTickerHasIntraday() async {
        // Arrange
        let apiGateway = TickerApiGatewayImplementation(apiClient: apiClient,
                                                        storageContext: storageContext)
        let useCase = TickerUseCaseImplementation(apiGateway: apiGateway)
        
        // Act
        let result = await useCase.requesTickerIntraday(parameters: TickerIntradayRequest(isUnitTest: true))
        
        // Assert
        switch result {
        case .success(let ticker):
            XCTAssertTrue(ticker.tickerDetail.hasIntraday)
        case .failure(let apiError):
            XCTFail("The test has failed: \(apiError.customDescription)")
        }
    }
    
    func testTickerIntradayDataNotEmpty() async {
        // Arrange
        let apiGateway = TickerApiGatewayImplementation(apiClient: apiClient,
                                                        storageContext: storageContext)
        let useCase = TickerUseCaseImplementation(apiGateway: apiGateway)
        
        // Act
        let result = await useCase.requesTickerIntraday(parameters: TickerIntradayRequest(isUnitTest: true))
        
        // Assert
        switch result {
        case .success(let ticker):
            XCTAssertFalse(ticker.tickerDetail.intraday.isEmpty)
        case .failure(let apiError):
            XCTFail("The test has failed: \(apiError.customDescription)")
        }
    }
    
    func testTickerIntradayVolumeNotNil() async {
        // Arrange
        let apiGateway = TickerApiGatewayImplementation(apiClient: apiClient,
                                                        storageContext: storageContext)
        let useCase = TickerUseCaseImplementation(apiGateway: apiGateway)
        
        // Act
        let result = await useCase.requestLatestIntradayData(parameters: TickerIntradayLatestRequest(isUnitTest: true))
        
        // Assert
        switch result {
        case .success(let ticker):
            XCTAssertNotNil(ticker.volume)
        case .failure(let apiError):
            XCTFail("The test has failed: \(apiError.customDescription)")
        }
    }
}
