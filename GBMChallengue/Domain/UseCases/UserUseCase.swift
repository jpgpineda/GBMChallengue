//
//  UserUseCase.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

protocol UserUseCase {
    var apiGateway: UserApiGateway { get set }
    func fetchUserInfo() async -> ApiResult<UserDTO>
    func canEncryptCredentials(email: String, password: String) -> Bool
    func canRetrieveEncryptedCrendentials(email: String) -> CredentialDTO?
    func saveLastSignedUser(email: String)
    func getLastSignedUser() -> String
}

class UserUseCaseImplementation: UserUseCase {
    internal var apiGateway: UserApiGateway
    
    init(apiGateway: UserApiGateway) {
        self.apiGateway = apiGateway
    }
    
    func fetchUserInfo() async -> ApiResult<UserDTO> {
        let response = await apiGateway.fetchUserInfo()
        switch response {
        case .success(let document):
            return .success(UserDTO(with: document))
        case .failure(let apiError):
            return .failure(apiError)
        }
    }
    
    func canEncryptCredentials(email: String, password: String) -> Bool {
        return apiGateway.canEncryptCredentials(email: email, password: password)
    }
    
    func canRetrieveEncryptedCrendentials(email: String) -> CredentialDTO? {
        return apiGateway.canRetrieveEncryptedCrendentials(email: email)
    }
    
    func saveLastSignedUser(email: String) {
        apiGateway.saveLastSignedUser(email: email)
    }
    
    func getLastSignedUser() -> String {
        return apiGateway.getLastSignedUser()
    }
}
