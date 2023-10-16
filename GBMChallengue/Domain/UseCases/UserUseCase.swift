//
//  UserUseCase.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

protocol UserUseCase {
    var apiGateway: UserApiGateway { get set }
    func fetchUserInfo() async -> ApiResult<UserDTO>
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
}
