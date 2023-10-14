//
//  TickerDetailDTO.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

struct TickerDetailDTO {
    let name: String
    let symbol: String
    let stock: StockDTO
    
    init(with response: Ticker) {
        name = response.name
        symbol = response.symbol
        stock = StockDTO(with: response.stockExchange)
    }
}
