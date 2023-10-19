//
//  Regex.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

struct Regex {
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let passwordRegex = "(?=.*[0-9])(?=.*[a-z]).{8,}"
}
