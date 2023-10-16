//
//  IntradayDataDTO.swift
//  GBMChallengue
//
//  Created by javier pineda on 14/10/23.
//

import Foundation

struct IntradayDataDTO {
    let date: Date
    let symbol: String
    let exchange: String
    let open: Double
    let high: Double
    let low: Double
    let close: Double?
    let last: Double?
    let volume: Int?
    
    init(with response: Intraday) {
        date = response.date
        symbol = response.symbol
        exchange = response.exchange
        open = response.intradayOpen
        high = response.high
        low = response.low
        close = response.close
        last = response.last
        volume = response.volume
    }
    
    func getValueByType(type: ValueForChartType) -> Double {
        switch type {
        case .openPrice:
            return open
        case .closePrice:
            return close ?? .zero
        case .highPrice:
            return high
        case .lowPrice:
            return low
        case .volume:
            return Double(volume ?? .zero)
        }
    }
}
