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
    func canEncryptCredentials(email: String, password: String) -> Bool
    func canRetrieveEncryptedCrendentials(email: String) -> CredentialDTO?
    func saveLastSignedUser(email: String)
    func getLastSignedUser() -> String
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
    
    func canEncryptCredentials(email: String, password: String) -> Bool {
        guard let parsedPassword = password.data(using: .utf8) else { return false }
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecValueData as String: parsedPassword
        ]
        return SecItemAdd(attributes as CFDictionary, nil) != noErr
    }
    
    func canRetrieveEncryptedCrendentials(email: String) -> CredentialDTO? {
        var item: CFTypeRef?
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            if let existingItem = item as? [String: Any],
               let userEmail = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8) {
                return CredentialDTO(email: userEmail, password: password)
            } else {
                print("Something go wrong parsing the keychain data")
                return nil
            }
        } else {
            print("Something go wrong accessing keychain")
            return nil
        }
    }
    
    func saveLastSignedUser(email: String) {
        UserPrefs.shared.saveLastSignedUser(email: email)
    }
    
    func getLastSignedUser() -> String {
        return UserPrefs.shared.getLastSignedUser()
    }
}
