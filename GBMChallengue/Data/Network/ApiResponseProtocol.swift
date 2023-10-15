//
//  ApiResponseProtocol.swift
//  GBMChallengue
//
//  Created by javier pineda on 10/10/23.
//

import Foundation

protocol GenericApi {
    var session: URLSession { get }
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T
}

extension GenericApi {
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        
        print("JSON String: \(String(data: data, encoding: .utf8))")
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.requestFailed(description: .Localized.invalidResponse)
        }
        
        guard httpResponse.statusCode == HttpCodes.ok else {
            throw ApiError.responseUnsuccessful(description: .Localized.statusCode + String(httpResponse.statusCode))
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(type, from: data)
        } catch let error {
            print(error.localizedDescription)
            throw ApiError.jsonConversionFailure(description: error.localizedDescription)
        }
    }
}
