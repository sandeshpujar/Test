//
//  PlanetTableViewCell.swift
//  Planets
//
//  Created by Sandesh on 24/02/21.
//

import UIKit

/**
 Custom cell for displaying the planet details in the list
 */
class PlanetTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    /// The label for name
    @IBOutlet weak var planetNameLabel: UILabel!
    
    /// The label for climate info
    @IBOutlet weak var planetClimateLabel: UILabel!
    
    /// The label for terrain info
    @IBOutlet weak var planetTerrainLabel: UILabel!
    
    /// The label for population info
    @IBOutlet weak var planetPopulationLabel: UILabel!
    
    /// The label for diameter info
    @IBOutlet weak var planetDiameterLabel: UILabel!
    
    /// The view model for this class
    var viewModel: PlanetTableViewCellViewModel? {
        didSet {
            self.configureUI()
        }
    }
    
    // MARK: - Methods
    
    /**
     Configures the data requied to be shown in the cell
     */
    func configureUI() {
        self.planetNameLabel.text = self.viewModel?.planetName
        self.planetClimateLabel.text = "Climate is \(self.viewModel?.planetClimate ?? "")"
        self.planetTerrainLabel.text = "Terrain is \(self.viewModel?.planetTerrain ?? "")"
        self.planetPopulationLabel.text = "Population is \(self.viewModel?.planetPopulation ?? "")"
        self.planetDiameterLabel.text = "Diameter is \(self.viewModel?.planetDiameter ?? "")"
    }
}
