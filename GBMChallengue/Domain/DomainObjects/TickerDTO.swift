//
//  TickerDTO.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

struct TickersDTO {
    let limit: Int
    let offSet: Int
    let tickers: [TickerDetailDTO]
    
    init(with response: Tickers) {
        limit = response.pagination.limit
        offSet = response.pagination.offset
        tickers = response.data.compactMap({
            TickerDetailDTO(with: $0)
        })
    }
}
