//
//  APIService.swift
//  My13Week
//
//  Created by bro on 2022/06/05.
//

import Foundation

enum APIError: String, Error {
    case unknownError = "alert_error_unknown"
    case serverError = "alert_error_server"
}

extension APIError: LocalizedError {
    
    var errorDescription: String? {
        return NSLocalizedString(self.rawValue, comment: "")
//        switch self {
//        case .unknownError: return NSLocalizedString(self.rawValue, comment: "")
//        case .serverError: return NSLocalizedString(self.rawValue, comment: "")
//        }
    }
    
}

class APIService {
    
    let sourceURL = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleList.json?key=f5eef3421c602c6cb7ea224104795888")!
    
    func requestCast() {
        URLSession.shared.dataTask(with: sourceURL) { data, response, error in
//            print(data)
//            print(response)
//            print(error)
            
            if let error = error {
                print("error 발생!", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Error")
                return
            }
            
            //let decoder = JSONDecoder()
        
            
            if let data = data, let castData = try? JSONDecoder().decode(Cast.self, from: data) {
                print("Succeed", castData)
                return
            }
            
            print("end")
            
        }.resume()
    }
    
    func requestCastCloser(completion: @escaping (Cast?) -> Void) {
        URLSession.shared.dataTask(with: sourceURL) { data, response, error in
//            print(data)
//            print(response)
//            print(error)
            
            if let error = error {
                self.showAlert(.unknownError)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                self.showAlert(.serverError)
                return
            }
                  
            if let data = data, let castData = try? JSONDecoder().decode(Cast.self, from: data) {
                completion(castData)
                return
            }
            completion(nil)
            print("end")
            
        }.resume()
    }
    
    func showAlert(_ msg: APIError) {
        
    }
    
}
