//
//  APIClient.swift
//  MYWE
//
//  Created by AmrFawaz on 29/09/2021.
//  Copyright © 2021 Segmatek. All rights reserved.
//

import Alamofire

class APIClient {
    private static var session: Session!
    private static var headers: [String:String] = [:]

//    internal static func sessionManagerForDisabledSSL() -> Session {
//        let man = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: [:])
//
//        return Session(serverTrustManager: man)
//    }

    static private var sessionManagerForDisabledSSL: Session = {
        let man = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: [:])
        return Session(serverTrustManager: man)

    }()

    @discardableResult
    internal static func performRequest<T:Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        
        session = sessionManagerForDisabledSSL
        session.session.configuration.timeoutIntervalForRequest = 60
//        session.session.configuration.requestCachePolicy = .reloadIgnoringCacheData

        return session.request(route).responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
            completion(response.result)
        }
    }
        
}
