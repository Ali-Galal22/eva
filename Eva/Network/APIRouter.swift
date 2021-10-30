//
//  APIRouter.swift
//  MYWE
//
//  Created by AmrFawaz on 28/09/2021.
//  Copyright © 2021 Segmatek. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    case homeList(queryParameters: [String: String])
    case listProjects(queryParameters: [String: String])
    case getFilterValues(queryParameters: [String: String] = [:])
    case filter(queryParameters: [String: String] = [:])
    case getServices(queryParameters: [String: String] = [:])
    case sendRequest(queryParameters: SendRequestRequest)
    case getProjectDetails(queryParameters: [String: String] = [:])
    case getOurPartners(queryParameters: [String: String] = [:])
    case getAboutUs(queryParameters: [String: String] = [:])
}

extension APIRouter {
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .listProjects, .homeList, .getFilterValues, .filter, .getServices, .getProjectDetails, .getOurPartners, .getAboutUs:
            return .get
        case .sendRequest:
            return .post
        }
    }
    
    // MARK: - Base URL
    private var baseUrl: URL {
        switch self {
        default:
            return Configurations.baseUrl
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .sendRequest:
            return "?action=send"
        default: return ""
        }
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .listProjects(let parameters), .homeList(let parameters), .getFilterValues(let parameters), .filter(let parameters), .getServices(let parameters), .getProjectDetails(let parameters), .getOurPartners(let parameters), .getAboutUs(let parameters):
            return parameters
        case.sendRequest(let parameters):
            return parameters.getParamsAsJson()
        }
    }
    
    // MARK: - headers
    private var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {

        var url = baseUrl

        if !path.isEmpty {
            let urlString = url.absoluteString + path
            url = URL(string: urlString)!
        }

        var urlRequest = try URLRequest(url: url, method: method)

        if headers != nil {
            for (key, value) in headers! {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        print("\(url.absoluteString)")

        switch method {
        case .get:
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}

