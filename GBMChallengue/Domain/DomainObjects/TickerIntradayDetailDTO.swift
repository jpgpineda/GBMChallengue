//
//  TickerIntradayDetailDTO.swift
//  GBMChallengue
//
//  Created by javier pineda on 14/10/23.
//

struct TickerIntradayDetailDTO {
    let name: String
    let symbol: String
    let intraday: [IntradayDataDTO]
    
    init(with response: TickerDetail) {
        name = response.name
        symbol = response.symbol
        intraday = response.intraday.compactMap({
            IntradayDataDTO(with: $0)
        })
    }
}
