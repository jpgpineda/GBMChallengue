//
//  SignUpRequest.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

struct SignUpRequest {
    let name: String
    let lastName: String
    let email: String
    let password: String
    
    func dataForFirebaseDB() -> [String: Any] {
        let data: [String: Any] = [
            FirebaseKeys.nameKey: name,
            FirebaseKeys.lastNamesKey: lastName
        ]
        return data
    }
}
