//
//  RequestHelper.swift
//  AcronymFinder
//
//  Created by Jeet Jayakar on 06/02/23.
//

import UIKit

struct Parameters{
    let key : String
    let value : String
}

class RequestHelper: NSObject {
    
    static let shared = RequestHelper()
    typealias CompletionHandler = (_ data : Data?, _ success : Bool) -> Void
    
    private override init() {
        
    }
    
    func performGetRequest(url : String , paramters : [Parameters] , completionHandler: @escaping CompletionHandler)  {
        URLSession.shared.dataTask(with: createUrlRequest(url: url, paramters: paramters)) { data, response, error in
            
            if error != nil{
                completionHandler(nil,false)
            }
            guard let data = data else { return }
            completionHandler(data,true)
        }.resume()
        
        
    }
    
    private func createUrlRequest(url : String , paramters : [Parameters]) -> URLRequest {
        var paramtersString = "?"
        paramters.forEach { param in
            paramtersString.append("\(param.key)=\(param.value)")
        }
        let UrlString = "\(url)\(paramtersString)"
        let request = URLRequest(url: URL(string: UrlString)!)
        return request
    }
    
}
