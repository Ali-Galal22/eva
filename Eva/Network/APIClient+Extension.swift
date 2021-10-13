//
//  AuthenticationAPI.swift
//  MYWE
//
//  Created by AmrFawaz on 30/09/2021.
//  Copyright © 2021 Segmatek. All rights reserved.
//

import Alamofire

extension APIClient {
    static func getProjectsList(completion: @escaping (Result<BaseResponse<ProjectsResponse>, AFError>) -> Void) {
        performRequest(route: APIRouter.listProjects(queryParameters: ["action": "projects", "pg":"1"]), completion: completion)
    }
    
    static func getHomeList(parameters: [String: String], completion: @escaping (Result<BaseResponse<HomeListResponse>, AFError>) -> Void) {
        performRequest(route: APIRouter.listProjects(queryParameters: parameters), completion: completion)
    }

}
class AuthenticationAPI: APIClient {
//    static func generateToken(completion: @escaping (Result<BaseResponse<TokenInfo>, AFError>) -> Void) {
//        performRequest(route: APIRouter.generateToken, completion: completion)
//    }
//    
//    static func login(loginModel: BaseRequest<LoginRequest>, completion: @escaping (Result<BaseResponse<TokenInfo>, AFError>) -> Void) {
//        performRequest(route: APIRouter.login(userLogin: loginModel), completion: completion)
//    }
}

