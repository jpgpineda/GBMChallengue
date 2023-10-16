//
//  AccessApiGateway.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

import FirebaseAuth
import FirebaseFirestore

protocol AccessApiGateway {
    var auth: Auth { get set }
    var firebaseDB: Firestore { get set }
    func requestSignIn(parameters: SignInRequest) async -> ApiResult<Bool>
    func createUser(parameters: SignUpRequest) async -> ApiResult<Bool>
    func requestSignOut() async -> ApiResult<Bool>
    func saveLocalAuthPref(isEnabled: Bool)
    func getLocalAuthPref() -> Bool
}

class AccessApiGatewayImplementation: AccessApiGateway {
    internal var auth: Auth
    internal var firebaseDB: Firestore
    
    init(auth: Auth,
         firebaseDB: Firestore) {
        self.auth = auth
        self.firebaseDB = firebaseDB
    }
    
    func requestSignIn(parameters: SignInRequest) async -> ApiResult<Bool> {
        do {
            try await auth.signIn(withEmail: parameters.email, password: parameters.password)
            return .success(true)
        } catch {
            return .failure(ApiError.requestFailed(description: error.localizedDescription))
        }
    }
    
    func createUser(parameters: SignUpRequest) async -> ApiResult<Bool> {
        do {
            try await auth.createUser(withEmail: parameters.email, password: parameters.password)
            return await saveUserInfo(parameters: parameters)
        } catch {
            return .failure(ApiError.requestFailed(description: error.localizedDescription))
        }
    }
    
    func requestSignOut() async -> ApiResult<Bool> {
        do {
            try auth.signOut()
            return .success(true)
        } catch {
            return .failure(ApiError.requestFailed(description: error.localizedDescription))
        }
    }
    
    private func saveUserInfo(parameters: SignUpRequest) async -> ApiResult<Bool> {
        guard let userUid = auth.currentUser?.uid else { return .failure(ApiError.sessionNotActive) }
        do {
            try await firebaseDB.collection(FirebaseCollections.userCollection).document(userUid).setData(parameters.dataForFirebaseDB())
            return .success(true)
        } catch {
            return .failure(ApiError.requestFailed(description: error.localizedDescription))
        }
    }
    
    func saveLocalAuthPref(isEnabled: Bool) {
        UserPrefs.shared.saveIsLocalAuthEnabled(isEnabled: isEnabled)
    }
    
    func getLocalAuthPref() -> Bool {
        return UserPrefs.shared.getIsLocalAuthEnabled()
    }
}
