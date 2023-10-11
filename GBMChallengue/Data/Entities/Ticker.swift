//
//  Ticker.swift
//  GBMChallengue
//
//  Created by javier pineda on 10/10/23.
//

//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Tickers: Codable {
    let pagination: Pagination
    let data: [Ticker]
}

// MARK: - Datum
struct Ticker: Codable {
    let name, symbol: String
    let hasIntraday, hasEOD: Bool
    let country: JSONNull?
    let stockExchange: StockExchange

    enum CodingKeys: String, CodingKey {
        case name, symbol
        case hasIntraday = "has_intraday"
        case hasEOD = "has_eod"
        case country
        case stockExchange = "stock_exchange"
    }
}

// MARK: - StockExchange
struct StockExchange: Codable {
    let name, acronym, mic, country: String
    let countryCode, city, website: String

    enum CodingKeys: String, CodingKey {
        case name, acronym, mic, country
        case countryCode = "country_code"
        case city, website
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let limit, offset, count, total: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
        return
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

