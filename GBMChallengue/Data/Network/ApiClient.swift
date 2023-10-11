//
//  ApiClient.swift
//  GBMChallengue
//
//  Created by javier pineda on 10/10/23.
//

import Foundation

final class ApiClient: GenericApi {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
}
