//
//  AcronymFinderViewModel.swift
//  AcronymFinder
//
//  Created by Jeet Jayakar on 06/02/23.
//

import UIKit

protocol AcronymFinderDelegate : AnyObject {
    func reloadView()
    func errorAlert(message : String)
}

class AcronymFinderViewModel: NSObject {

    
    var acronymData : [AcronymModelElement]?
    weak var delegate : AcronymFinderDelegate?
    
    ///  Method to make request to search the given acronym
    /// - Parameter searchText: text string from viewcontroller
    func performAcronymSearch(searchText : String)  {
        CancelPreviousRequest()
        RequestHelper.shared.performGetRequest(url: Constants.acronymURL, paramters: [Parameters(key: Constants.sf, value: searchText)]) { [unowned self] data, success, errorMessage  in
            if success{
                self.ParseAcronymData(data: data!)
            }else{
                if !(errorMessage == ErrorMessage.errorCancelled.rawValue){
                    delegate?.errorAlert(message: errorMessage)
                }
                
            }
        }
    }
    
    /// Parse server data to model structure
    /// - Parameter data: server response
    func ParseAcronymData(data : Data){
        do{
            acronymData = try JSONDecoder().decode([AcronymModelElement].self, from: data)
        }catch{
            delegate?.errorAlert(message: ErrorMessage.invalidResponse.rawValue)
        }
        delegate?.reloadView()
    }
    
    /// Methid to clear data for no search string
    func clearData(){
        CancelPreviousRequest()
        acronymData?.removeAll()
        delegate?.reloadView()
    }
    
    /// Cancel all previous server request
    private func CancelPreviousRequest(){
        RequestHelper.shared.cancelDataTask()
    }
    
    /// Returns acronym array data count
    /// - Returns: data count
    func getDataCount() -> Int {
        return acronymData?.first?.lfs.count ?? 0
    }
    
    /// Returns the acronym for respective index path
    /// - Parameter index: index path of table cell
    /// - Returns: Acronym String value
    func getAcronym(index : Int) -> String {
        return acronymData?.first?.lfs[index].lf ?? ""
    }
}
