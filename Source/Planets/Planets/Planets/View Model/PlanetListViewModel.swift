//
//  PlanetListViewModel.swift
//  Planets
//
//  Created by Sandesh on 24/02/21.
//

import UIKit

/**
 View model for the planet list view controller
 */
class PlanetListViewModel: NSObject {

    // MARK: - Properties
    
    /// Title of the screen
    var screenTitle = "Planets"
    
    /// List of model objects for the plannets
    var planets: [Planet]?
    
    // MARK: Closures
    
    /// Closure for loading table view
    var loadTableView: (() -> ())?
    
    /// Closure for showing an error alert
    var showErrorAlert: (() -> ())?
    
    /// Closure for showing/hiding activity indicator
    var handleLoadingIndicator: ((_ shouldShowIndicator: Bool) -> ())?
    
    // MARK: - Initializer
    
    override init() {
        super.init()
        self.prepareData()
    }
    
    init(dataManager: PlanetDataManager.Type = PlanetDataManager.self, serviceManager: PlanetServiceManager.Type = PlanetServiceManager.self) {
        super.init()
        self.prepareData(dataManager: dataManager, serviceManager: serviceManager)
    }
    
    // MARK: - Data preparation
    
    /**
     Prepares the data required for planet screen screen
     - parameter dataManager: The instance of data manager (used only for unit testing)
     - parameter serviceManager: The instance of service manager (used for unit testing only)
     - note if the data is cached in core data, does not make a call. Else, makes a fresh call to the get the data
     */
    func prepareData(dataManager: PlanetDataManager.Type = PlanetDataManager.self, serviceManager: PlanetServiceManager.Type = PlanetServiceManager.self) {
        self.planets = dataManager.fetchAllPlanets() ?? [Planet]()
        if self.planets?.isEmpty == false {
            NSLog("No need to make the service call, we have the data stored")
            DispatchQueue.main.async { [weak self] in
                self?.loadTableView?()
            }
        } else {
            self.refreshData()
        }
    }
    
    /**
     Makes a call to the service manager to get the data
     - parameter serviceManager: The instance of service manager (used for unit testing only)
     */
    func refreshData(serviceManager: PlanetServiceManager.Type = PlanetServiceManager.self) {
        DispatchQueue.main.async { [weak self] in
            self?.handleLoadingIndicator?(true)
        }
        NSLog("Starting the call to get all the planets")
        DispatchQueue.global(qos: .background).async {
            serviceManager.fetchPlanets { (response, success) in
                DispatchQueue.main.async { [weak self] in
                    self?.handleLoadingIndicator?(false)
                    if success {
                        NSLog("Response received successfully")
                        self?.planets = PlanetDataManager.fetchAllPlanets() ?? [Planet]()
                        self?.loadTableView?()
                    } else {
                        NSLog("Response failed")
                        self?.showErrorAlert?()
                    }
                }
            }
        }
    }
}

// MARK: - Tableview data source

/**
 Extension for the table view data source methods of planet list view controller
 */
extension PlanetListViewModel {
    
    func numberOfRows() -> Int {
        return self.planets?.count ?? 0
    }
    
    func planetForIndexPath(indexpath: IndexPath) -> PlanetTableViewCellViewModel {
        let planet = planets?[indexpath.row]
        return PlanetTableViewCellViewModel(planetName: planet?.name, planetClimate: planet?.climate, planetTerrain: planet?.terrain, planetPopulation: planet?.population, planetDiameter: planet?.diameter)
    }
}

// MARK: - Tablview cell view model

/**
 View model for the planet table view cell
 */
struct PlanetTableViewCellViewModel: Equatable {
    var planetName: String
    var planetClimate: String
    var planetTerrain: String
    var planetPopulation: String
    var planetDiameter: String
    
    init(planetName: String?, planetClimate: String?, planetTerrain: String?, planetPopulation: String?, planetDiameter: String?) {
        self.planetName = planetName ?? ""
        self.planetClimate = planetClimate ?? ""
        self.planetTerrain = planetTerrain ?? ""
        self.planetPopulation = planetPopulation ?? ""
        self.planetDiameter = planetDiameter ?? ""
    }
}
