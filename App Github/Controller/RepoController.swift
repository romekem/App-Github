//
//  RepoController.swift
//  App Github
//
//  Created by Roman Matusewicz on 19/07/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RepoCell"

class RepoController: UITableViewController {
    // MARK: - Propierties
    
    private var repositories = [Repository](){
        didSet{
            tableView.reloadData()
        }
    }
    var filteredUsers = [User](){
        didSet{
            tableView.reloadData()
        }
    }
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    private var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - API
    func fetchUserRepos(){
        AuthService.shared.fetchRepositories { (repositories) in
            self.repositories = repositories
        }
    }
    
    func searchUserRepo(searchText: String){
        AuthService.shared.searchUserRepositories(searchText: searchText) { (repositories) in
            self.repositories = repositories
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        configureSearchController()
    }
    
    // MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }
    
    func configureTableView(){
        tableView.register(RepoCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Find a repository..."
        navigationItem.searchController = searchController
        definesPresentationContext = false
        
    }
}
    // MARK: - UITableViewDataSource/Delegate
extension RepoController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RepoCell
        cell.repo = repositories[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        let controller = DetailController()
        controller.repository = repository
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
    // MARK: - UISearchResultUpdating
extension RepoController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        searchUserRepo(searchText: searchText)
    }
}
