//
//  AcronymFinderViewModel.swift
//  AcronymFinder
//
//  Created by Jeet Jayakar on 06/02/23.
//

import UIKit

protocol AcronymFinderDelegate : AnyObject {
    func reloadView()
}

class AcronymFinderViewModel: NSObject {

    
    var acronymData : [AcronymModelElement]?
    weak var delegate : AcronymFinderDelegate?
    
    func performAcronymSearch(searchText : String)  {
        RequestHelper.shared.performGetRequest(url: Constants.acronymURL, paramters: [Parameters(key: Constants.sf, value: searchText)]) { [unowned self] data, success in
            if success{
                self.ParseAcronymData(data: data!)
            }
        }
    }
    
    func ParseAcronymData(data : Data){
        do{
            acronymData = try JSONDecoder().decode([AcronymModelElement].self, from: data)
        }catch{
            print("\(#function) - \(error)")
        }
        delegate?.reloadView()
    }
    
    func clearData(){
        acronymData?.removeAll()
        delegate?.reloadView()
    }
    
    func getDataCount() -> Int {
        return acronymData?.first?.lfs.count ?? 0
    }
    
    func getAcronym(index : Int) -> String {
        return acronymData?.first?.lfs[index].lf ?? ""
    }
}
