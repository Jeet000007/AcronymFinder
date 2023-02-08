//
//  AcronymFinderViewModel.swift
//  AcronymFinder
//
//  Created by Jeet Jayakar on 06/02/23.
//

import UIKit

protocol AcronymFinderDelegate : AnyObject {
    func reloadTableView()
    func showErrorAlert(message : String)
}

class AcronymFinderViewModel: NSObject {

    
    var acronymData : [AcronymModelElement]?
    weak var delegate : AcronymFinderDelegate?
    
    ///  Method to make request to search the given acronym
    /// - Parameter searchText: text string from viewcontroller
    func performAcronymSearch(searchText : String)  {
        cancelPreviousRequest()
        RequestHelper.shared.performGetRequest(url: Constants.acronymURL, paramters: [Parameters(key: Constants.sf, value: searchText)]) { [unowned self] data, success, errorMessage  in
            if success{
                self.parseAcronymData(data: data!)
            }else{
                if !(errorMessage == ErrorMessage.errorCancelled.rawValue){
                    delegate?.showErrorAlert(message: errorMessage)
                }
                
            }
        }
    }
    
    /// Method to parse server data to model structure
    /// - Parameter data: server response data
    func parseAcronymData(data : Data){
        do{
            acronymData = try JSONDecoder().decode([AcronymModelElement].self, from: data)
        }catch{
            delegate?.showErrorAlert(message: ErrorMessage.invalidResponse.rawValue)
        }
        delegate?.reloadTableView()
    }
    
    /// Method to clear data for no search string
    func clearData(){
        cancelPreviousRequest()
        acronymData?.removeAll()
        delegate?.reloadTableView()
    }
    
    /// Cancel all previous server request
    private func cancelPreviousRequest(){
        RequestHelper.shared.cancelDataTask()
    }
    
    /// Returns acronym array data count
    /// - Returns: acronym data count
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
