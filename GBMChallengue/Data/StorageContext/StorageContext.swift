//
//  StorageContext.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

import RealmSwift
import Foundation

typealias ModelOperationCompletionHandler = (_ result: ApiResult<Bool>) -> Void

protocol StorageContext {
    var realmDB: Realm { get set }
    func saveModel<T: Object>(model: T, completion: @escaping ModelOperationCompletionHandler)
    func getModel(model: Object.Type, predicate: NSPredicate?) -> [Object]?
    func deleteModel<T: Object>(model: T, completion: @escaping ModelOperationCompletionHandler)
    func removeAll()
}

class StorageContextImplementation: StorageContext {
    internal var realmDB: Realm
    
    init(realmDB: Realm) {
        self.realmDB = realmDB
    }
    
    func saveModel<T: Object>(model: T, completion: @escaping ModelOperationCompletionHandler) {
        do {
            try realmDB.write({
                realmDB.add(model, update: .all)
            })
            completion(.success(true))
        } catch {
            print(error.localizedDescription)
            completion(.failure(ApiError.responseUnsuccessful(description: error.localizedDescription)))
        }
    }
    
    func getModel(model: Object.Type, predicate: NSPredicate?) -> [Object]? {
        if let predicate = predicate {
            return Array(realmDB.objects(model).filter(predicate))
        }
        return Array(realmDB.objects(model))
    }
    
    func deleteModel<T: Object>(model: T, completion: @escaping ModelOperationCompletionHandler) {
        do {
            try realmDB.write {
                realmDB.delete(model)
                completion(.success(true))
            }
        } catch {
            completion(.failure(ApiError.responseUnsuccessful(description: error.localizedDescription)))
        }
    }
    
    func removeAll() {
        try? realmDB.write({
            realmDB.deleteAll()
        })
    }
}
