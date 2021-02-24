//
//  Planets+CoreDataProperties.swift
//  Planets
//
//  Created by Sandesh on 24/02/21.
//
//

import Foundation
import CoreData

/**
 Part of the core data model object class which contains the properties of the planets class
 */
extension Planets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Planets> {
        return NSFetchRequest<Planets>(entityName: "Planets")
    }

    /// The count of the planets
    @NSManaged public var count: Int32
    
    /// The url for fetching next set of planets
    @NSManaged public var next: String?
    
    /// The url for fetching previous set of planets
    @NSManaged public var previous: String?
    
    /// The list of all planets in current batch
    @NSManaged public var allPlanets: NSSet?

}

// MARK: Generated accessors for allPlanets
extension Planets {

    @objc(addAllPlanetsObject:)
    @NSManaged public func addToAllPlanets(_ value: Planet)

    @objc(removeAllPlanetsObject:)
    @NSManaged public func removeFromAllPlanets(_ value: Planet)

    @objc(addAllPlanets:)
    @NSManaged public func addToAllPlanets(_ values: NSSet)

    @objc(removeAllPlanets:)
    @NSManaged public func removeFromAllPlanets(_ values: NSSet)

}

extension Planets : Identifiable {

}
