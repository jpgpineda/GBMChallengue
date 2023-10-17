//
//  TickerModel.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

import RealmSwift

class TickerModel: Object {
    @Persisted var name: String         = .empty
    @Persisted(primaryKey: true) var symbol: String       = .empty
    @Persisted var hasIntraday: Bool    = false
    @Persisted var stock: StockModel?
    
    convenience init(with ticker: TickerDetailDTO) {
        self.init()
        name = ticker.name
        symbol = ticker.symbol
        stock = StockModel(with: ticker.stock)
    }
}
