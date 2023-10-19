//
//  StockDTO.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

struct StockDTO {
    let name: String
    let acronym: String
    let country: String
    
    init(with response: StockExchange) {
        name = response.name
        acronym = response.acronym
        country = response.countryCode
    }
    
    init(with model: StockModel) {
        name = model.name
        acronym = model.acronym
        country = model.country
    }
    
    init() {
        name = .empty
        acronym = .empty
        country = .empty
    }
}
