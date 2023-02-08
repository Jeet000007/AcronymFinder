//
//  AcronymFinderViewController.swift
//  AcronymFinder
//
//  Created by Jeet Jayakar on 06/02/23.
//

import UIKit

class AcronymFinderViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var acronymSearchBar: UISearchBar!
    @IBOutlet weak var acronymTableView: UITableView!
    
    // MARK: Variables
    let viewModel = AcronymFinderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
       
    }
}

// MARK: ViewModelDelegate
extension AcronymFinderViewController : AcronymFinderDelegate{
    
    /// Reload table View for new data
    func reloadTableView() {
        DispatchQueue.main.async {
            self.acronymTableView.reloadData()
        }
    }
    
    /// Method to display alert prompt
    /// - Parameter message: message to be shown
    func showErrorAlert(message : String)  {
        CommonHelper.shared.commonDismissableAlert(message: message, viewController: self)
    }
}

// MARK: SearchBarDelegate
extension AcronymFinderViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty{
            viewModel.clearData()
        }else{
            viewModel.performAcronymSearch(searchText: searchText)
            
        }
    }
}

// MARK: TableViewDelegate
extension AcronymFinderViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

// MARK: TableViewDatasource
extension AcronymFinderViewController :UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if viewModel.getDataCount() > 0{
            tableView.backgroundView = nil
            return 1
        }else{
            
            if !(acronymSearchBar.text?.isEmpty ?? false){
                tableView.backgroundView = CommonHelper.shared.noTableRecordsLabel(tableView: tableView)
                tableView.separatorStyle = .none
            }else{
                tableView.backgroundView = nil
            }
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: Constants.cellIdentifier)
        }
        cell.textLabel?.text = viewModel.getAcronym(index: indexPath.row)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        return cell
    }
    
}
