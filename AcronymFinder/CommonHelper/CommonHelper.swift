//
//  CommonHelper.swift
//  AcronymFinder
//
//  Created by Jeet Jayakar on 08/02/23.
//

import UIKit

class CommonHelper: NSObject {
    
    static let shared = CommonHelper()
    
    private override init() {
        
    }
    
    /// Common method to show a quick alert and  dismiss the same
    /// - Parameters:
    ///   - message: alert message string
    ///   - viewController: Parent View Controller
    func commonDismissableAlert(message : String , viewController : UIViewController)  {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
        let when = DispatchTime.now() + 0.8
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    /// Method that returns a label for table view with no data
    /// - Parameter tableView: respective table view
    /// - Returns: no data label
    func noTableRecordsLabel(tableView : UITableView) -> UILabel {
        let rect = CGRect(x: 0,
                          y: 0,
                          width: tableView.bounds.size.width,
                          height: tableView.bounds.size.height)
        let noDataLabel: UILabel = UILabel(frame: rect)
        
        noDataLabel.text = Constants.noDataFound
        noDataLabel.textColor = UIColor.black
        noDataLabel.textAlignment = NSTextAlignment.center
        return noDataLabel
    }

}
