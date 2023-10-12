//
//  AccessUseCase.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

protocol AccessUseCase {
    var apiGateway: AccessApiGateway { get set }
    func requestSignIn(parameters: SignInRequest) async -> ApiResult<Bool>
    func createUser(parameters: SignUpRequest) async -> ApiResult<Bool>
}

class AccessUseCaseImplementation: AccessUseCase {
    internal var apiGateway: AccessApiGateway
    
    init(apiGateway: AccessApiGateway) {
        self.apiGateway = apiGateway
    }
    
    func requestSignIn(parameters: SignInRequest) async -> ApiResult<Bool> {
        return await apiGateway.requestSignIn(parameters: parameters)
    }
    
    func createUser(parameters: SignUpRequest) async -> ApiResult<Bool> {
        return await apiGateway.createUser(parameters: parameters)
    }
}
