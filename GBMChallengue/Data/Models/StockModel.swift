//
//  StockModel.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

import RealmSwift

class StockModel: Object {
    @Persisted(primaryKey: true) var acronym: String  = .empty
    @Persisted var country: String  = .empty
    
    convenience init(with stock: StockDTO) {
        self.init()
        acronym = stock.acronym
        country = stock.country
    }
}
