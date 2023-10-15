//
//  TickerIntradayDTO.swift
//  GBMChallengue
//
//  Created by javier pineda on 14/10/23.
//

struct TickerIntradayDTO {
    let limit: Int
    let offSet: Int
    let tickerDetail: TickerIntradayDetailDTO
    
    init(with response: TickerIntraday) {
        limit = response.pagination.limit
        offSet = response.pagination.offset
        tickerDetail = TickerIntradayDetailDTO(with: response.data)
    }
}
