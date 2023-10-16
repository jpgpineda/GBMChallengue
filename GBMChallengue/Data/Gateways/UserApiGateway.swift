//
//  UserApiGateway.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

import FirebaseAuth
import FirebaseFirestore

protocol UserApiGateway {
    var auth: Auth { get set }
    var firebaseDB: Firestore { get set }
    func fetchUserInfo() async -> ApiResult<DocumentSnapshot>
}

class UserApiGatewayImplementation: UserApiGateway {
    internal var auth: Auth
    internal var firebaseDB: Firestore
    
    init(auth: Auth,
         firebaseFB: Firestore) {
        self.auth = auth
        self.firebaseDB = firebaseFB
    }
    
    func fetchUserInfo() async -> ApiResult<DocumentSnapshot> {
        guard let userUid = auth.currentUser?.uid else { return .failure(ApiError.sessionNotActive) }
        let documentRef = firebaseDB.collection(FirebaseCollections.userCollection).document(userUid)
        do {
            let response = try await documentRef.getDocument()
            return(.success(response))
        } catch {
            return .failure(ApiError.requestFailed(description: error.localizedDescription))
        }
    }
}
