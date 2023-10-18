//
//  GBMBaseTest.swift
//  GBMChallengueTests
//
//  Created by javier pineda on 18/10/23.
//

import XCTest
import RealmSwift
@testable import GBMChallengue

class GBMBaseTest: XCTest {
    let apiClient = ApiClient()
    let storageContext = StorageContextImplementation(realmDB: try! Realm())
}
