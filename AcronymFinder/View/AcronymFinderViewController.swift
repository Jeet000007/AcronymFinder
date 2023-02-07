//
//  AcronymFinderViewController.swift
//  AcronymFinder
//
//  Created by Jeet Jayakar on 06/02/23.
//

import UIKit

class AcronymFinderViewController: UIViewController {

    @IBOutlet weak var acronymSearchBar: UISearchBar!
    @IBOutlet weak var acronymTableView: UITableView!
    
    let viewModel = AcronymFinderViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
       
    }
}

extension AcronymFinderViewController : AcronymFinderDelegate{
    func reloadView() {
        DispatchQueue.main.async {
            self.acronymTableView.reloadData()
        }
    }
}

extension AcronymFinderViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
//        if !(searchBar.text?.isEmpty ?? false){
//            viewModel.performAcronymSearch(searchText: searchBar.text!)
//        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.clearData()
        }else{
            viewModel.performAcronymSearch(searchText: searchText)
            
        }
    }
}

extension AcronymFinderViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

extension AcronymFinderViewController :UITableViewDataSource{
    
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
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        return cell
    }
    
    
    
    
}
