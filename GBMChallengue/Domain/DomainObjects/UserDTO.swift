//
//  UserDTO.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

import FirebaseFirestore

struct UserDTO {
    let name: String
    let lastNames: String
    
    init(with document: DocumentSnapshot) {
        let data = document.data()
        name = data?[FirebaseKeys.nameKey] as? String ?? .empty
        lastNames = data?[FirebaseKeys.lastNamesKey] as? String ?? .empty
    }
}
