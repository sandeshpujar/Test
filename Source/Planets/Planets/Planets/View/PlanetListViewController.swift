//
//  PlanetListViewController.swift
//  Planets
//
//  Created by Sandesh on 24/02/21.
//

import UIKit

class PlanetListViewController: UIViewController, UITableViewDataSource {
    
    // MARK: - Properties
    
    /// The instance of the table view
    @IBOutlet weak var planetTableView: UITableView!
    
    /// The loading indicator
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    /// The identifier for re-using of the cell
    let cellIdentifier = "PlanetTableViewCell"
    
    /// The view model instance for this view controller
    var viewModel: PlanetListViewModel = PlanetListViewModel()
    
    // MARK: - View life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel.screenTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonAction))
        
        self.planetTableView.isHidden = true
        self.initializeViewModelClosures()
    }
    
    // MARK: - View model closure Initialze and handling
    
    /**
     Initializes the closures of the view model
     */
    func initializeViewModelClosures() {
        self.viewModel.loadTableView = { [weak self] in
            self?.handleLoadingTableview()
        }
        
        self.viewModel.handleLoadingIndicator = { [weak self] (shouldShowIndicator) in
            self?.handleLoadingIndicator(shouldShowIndicator)
        }
        
        self.viewModel.showErrorAlert = { [weak self] in
            self?.handleErrorAlert()
        }
    }
    
    /**
     Shows or hides the activity indicator
     - parameter shouldShowIndicator: the bool to indicate if the activity indicator should be shown or hidden
     */
    func handleLoadingIndicator(_ shouldShowIndicator: Bool) {
        if shouldShowIndicator {
            self.loadingIndicator.isHidden = false
            self.planetTableView.isHidden = true
            self.loadingIndicator.startAnimating()
        } else {
            self.planetTableView.isHidden = false
            self.loadingIndicator.stopAnimating()
        }
    }
    
    /**
     Reloads the tableview and makes it visible
     */
    func handleLoadingTableview() {
        self.planetTableView.isHidden = false
        self.planetTableView.reloadData()
    }
    
    /**
     Shows the alert for an error
     */
    func handleErrorAlert() {
        let alert = UIAlertController(title: "Alert", message: "Unable to refresh data. Please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Button actions
    
    /**
     Handles refresh button tap
     */
    @objc
    func refreshButtonAction() {
        self.viewModel.refreshData()
    }
    
    // MARK: - Tableview data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let planet = self.viewModel.planetForIndexPath(indexpath: indexPath)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlanetTableViewCell else {
            return PlanetTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        cell.viewModel = planet
        return cell
    }
}
