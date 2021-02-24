//
//  Planet+CoreDataProperties.swift
//  Planets
//
//  Created by Sandesh on 24/02/21.
//
//

import Foundation
import CoreData

/**
 Part of the core data model object class which contains the properties of the planet class
 */
extension Planet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Planet> {
        return NSFetchRequest<Planet>(entityName: "Planet")
    }

    /// The name of the planet
    @NSManaged public var name: String?
    
    /// The rotation period of the planet
    @NSManaged public var rotationPeriod: String?
    
    /// The orbital period of the planet
    @NSManaged public var orbitalPeriod: String?
    
    /// The diameter of the planet
    @NSManaged public var diameter: String?
    
    /// The climate of the planet
    @NSManaged public var climate: String?
    
    /// The gravity of the planet
    @NSManaged public var gravity: String?
    
    /// The terrain of the planet
    @NSManaged public var terrain: String?
    
    /// The surface water of the planet
    @NSManaged public var surfaceWater: String?
    
    ///The population of the planet
    @NSManaged public var population: String?
    
    /// The created date of the planet
    @NSManaged public var dateCreated: String?
    
    /// The edited date of the planet
    @NSManaged public var dateEdited: String?
    
    /// The url of the planet
    @NSManaged public var url: String?
    
    /// The list of residents of the planet
    @NSManaged public var residents: [String]?
    
    /// The list of films of the planet
    @NSManaged public var films: [String]?

}

extension Planet : Identifiable {

}
