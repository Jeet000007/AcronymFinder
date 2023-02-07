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
    
    func noDataView(tableView : UITableView) -> UILabel {
        let rect = CGRect(x: 0,
                          y: 0,
                          width: tableView.bounds.size.width,
                          height: tableView.bounds.size.height)
        let noDataLabel: UILabel = UILabel(frame: rect)
        
        noDataLabel.text = "No Records Found"
        noDataLabel.textColor = UIColor.black
        noDataLabel.textAlignment = NSTextAlignment.center
        return noDataLabel
    }
}

// MARK: ViewModelDelegate
extension AcronymFinderViewController : AcronymFinderDelegate{
    func reloadView() {
        DispatchQueue.main.async {
            self.acronymTableView.reloadData()
        }
    }
    
    /// Method to display alert prompt
    /// - Parameter message: message to be shown
    func errorAlert(message : String)  {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        let when = DispatchTime.now() + 0.8
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
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
                tableView.backgroundView = noDataView(tableView: tableView)
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
