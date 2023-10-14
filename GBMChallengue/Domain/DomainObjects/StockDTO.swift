//
//  StockDTO.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

struct StockDTO {
    let acronym: String
    let country: String
    
    init(with response: StockExchange) {
        acronym = response.acronym
        country = response.countryCode
    }
}
