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

enum ErrorType : Int {
    case errorCancelled = -999
    case internetError = -1009
}

enum ErrorMessage : String{
    case errorCancelled = "Cancelled"
    case internetError = "Internet offline"
    case serverError  = "Somthing went wrong"
    case invalidResponse = "Invalid Response"
}

class RequestHelper: NSObject {
    
    static let shared = RequestHelper()
    typealias CompletionHandler = (_ data : Data?, _ success : Bool, _ message : String) -> Void
    var dataTask : URLSessionDataTask?
    
    private override init() {
        
    }
    
    /// Method to perform a GET request
    /// - Parameters:
    ///   - url: Url String
    ///   - paramters: Query parameters
    ///   - completionHandler: response handler
    func performGetRequest(url : String , paramters : [Parameters] , completionHandler: @escaping CompletionHandler)  {
        dataTask = URLSession.shared.dataTask(with: createUrlRequest(url: url, paramters: paramters)) { [weak self] data, response, error in
            
            if error != nil{
                let error = error as? NSError
                //print("error\(error?.localizedDescription ?? "") - \(error?.code ?? 0)")
                completionHandler(nil,false,self?.getErrorMessage(error: error!) ?? "")
            }else if let requestResponse = response as? HTTPURLResponse ,
                     requestResponse.statusCode == 200,
                     let data = data{
                completionHandler(data,true,"")
            }else{
                completionHandler(nil,false,ErrorMessage.invalidResponse.rawValue)
            }
            
        }
        dataTask?.resume()
    }
    
    /// Cancel ongoing datatask
    func cancelDataTask(){
        dataTask?.cancel()
    }
    
    /// Method to create request body
    /// - Parameters:
    ///   - url: Url String
    ///   - paramters: Query parameters
    /// - Returns: Request Object 
    private func createUrlRequest(url : String , paramters : [Parameters]) -> URLRequest {
        var paramtersString = "?"
        paramters.forEach { param in
            paramtersString.append("\(param.key)=\(param.value)")
        }
        let UrlString = "\(url)\(paramtersString)"
        let request = URLRequest(url: URL(string: UrlString)!)
        return request
    }
    
    func getErrorMessage(error : NSError) -> String {
        var messageString = ""
        switch error.code {
        case ErrorType.internetError.rawValue:
            messageString = ErrorMessage.internetError.rawValue
        case ErrorType.errorCancelled.rawValue:
            messageString = ErrorMessage.errorCancelled.rawValue
        default:
            messageString = ErrorMessage.serverError.rawValue
        }
        
        return messageString
    }
    
}
