//
//  NetworkManager.swift
//  Login
//
//  Created by ting on 2020/5/26.
//  Copyright © 2020 ameyo. All rights reserved.
//

import Foundation
import Alamofire

enum VError: String, Error {
    case invalidData = "the data received from the server was invlaid. Please try again."
    case invalidRequest = "The endpoint request to get venues is invalid."
    case invalidJSON = "JSON is invalid."
}

struct Login: Codable {
    let user_login: String
    let user_pass: String
    let service: String = "Login.UserLogin"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let session: Session = Session()
    
    let baseURL = "http://live.thunderstruck.tw/api/public"
    
    func requestFetch(userInfo: Login, completion: @escaping ((Result<Base, VError>) -> Void)) {
        
        let url = baseURL

        do {
            AF.request(url,
                       method: .get,
                       parameters: userInfo)
                .responseData { (response) in
                    if let statusCode = response.response?.statusCode, (200..<400) ~= statusCode {
                        
                        if let data = response.data {
                            
                            guard let model = try? JSONDecoder().decode(Base.self, from: data) else {
                                completion(.failure(VError.invalidJSON))
                                return
                            }
                            completion(.success(model))
                        } else {
                            completion(.failure(VError.invalidRequest))
                        }
                    } else {
                        completion(.failure(VError.invalidRequest))
                    }
            }
        } catch {
            completion(.failure(VError.invalidRequest))
        }
    }
    
//    func fetchGenericJSONData<T: Codable>(urlString: String, completion: @escaping (Result<T?, VError>) -> Void) {
//
//        guard let url = URL(string: urlString) else { return }
//
//        let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
//            if let err = err {
//                print("Failed to fetch apps:", err)
//                completion(.failure(.invalidData))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(.invalidData))
//                return
//            }
//
//            print("==DATA==",data)
//
//            do {
//                let object = try JSONDecoder().decode(T.self, from: data)
//                completion(.success(object))
//                print("==object==",object)
//            } catch {
//                completion(.failure(.invalidData))
//            }
//
//        }
//        task.resume()
//    }
}
