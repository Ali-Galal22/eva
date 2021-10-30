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
    
    static func getFilterValues(parameters: [String: String], completion: @escaping (Result<BaseResponse<FilterValue>, AFError>) -> Void) {
        performRequest(route: APIRouter.getFilterValues(queryParameters: parameters), completion: completion)
    }
    
    static func filter(parameters: [String: String], completion: @escaping (Result<BaseResponse<HomeListResponse>, AFError>) -> Void) {
        performRequest(route: APIRouter.filter(queryParameters: parameters), completion: completion)
    }
    
    static func getServices(parameters: [String: String], completion: @escaping (Result<BaseResponse<HomeListResponse>, AFError>) -> Void) {
        performRequest(route: APIRouter.filter(queryParameters: parameters), completion: completion)
    }

    static func sendRequest(parameters: SendRequestRequest, completion: @escaping (Result<BaseResponse<SendRequestResponse>, AFError>) -> Void) {
        performRequest(route: APIRouter.sendRequest(queryParameters: parameters), completion: completion)
    }
    
    
    static func getProjectDetails(parameters: [String: String], completion: @escaping (Result<BaseResponse<ProjectDetails>, AFError>) -> Void) {
        performRequest(route: APIRouter.getProjectDetails(queryParameters: parameters), completion: completion)
    }

    static func getGetOurPartners(parameters: [String: String], completion: @escaping (Result<BaseResponse<OurPartnersResponse>, AFError>) -> Void) {
        performRequest(route: APIRouter.getOurPartners(queryParameters: parameters), completion: completion)
    }

    
}
