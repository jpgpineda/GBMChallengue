//
//  ValueForChartType.swift
//  GBMChallengue
//
//  Created by javier pineda on 15/10/23.
//

enum ValueForChartType: Int {
    case openPrice  = 0
    case closePrice = 1
    case highPrice  = 2
    case lowPrice   = 3
    case volume     = 4
    
    func getCategoryById() -> String {
        switch self {
        case .openPrice:
            return .Localized.openPrice
        case .closePrice:
            return .Localized.closePrice
        case .highPrice:
            return .Localized.highPrice
        case .lowPrice:
            return .Localized.lowPrice
        case .volume:
            return .Localized.volume
        }
    }
}
