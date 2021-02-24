//
//  Planet+CoreDataClass.swift
//  Planets
//
//  Created by Sandesh on 24/02/21.
//
//

import Foundation
import CoreData
import UIKit

/**
 Part of the core data model object class which creates the Planet object
 */
@objc(Planet)
public class Planet: NSManagedObject {

    /**
     Creates the Planet managed object
     - parameter planetDetails: The dictionary using which the planet object is created
     - returns: The created planet object
     */
    class func newPlanet(_ planetDetails: [String: Any?]) -> Planet? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let planet = Planet.newObject(WithContext: appDelegate.persistentContainer.viewContext, andEntityName: "Planet") as? Planet
        planet?.climate = planetDetails["climate"] as? String
        planet?.dateCreated = planetDetails["created"] as? String
        planet?.dateEdited = planetDetails["edited"] as? String
        planet?.diameter = planetDetails["diameter"] as? String
        planet?.gravity = planetDetails["gravity"] as? String
        planet?.name = planetDetails["name"] as? String
        planet?.orbitalPeriod = planetDetails["orbital_period"] as? String
        planet?.population = planetDetails["population"] as? String
        planet?.rotationPeriod = planetDetails["rotation_period"] as? String
        planet?.surfaceWater = planetDetails["surface_Water"] as? String
        planet?.terrain = planetDetails["terrain"] as? String
        planet?.url = planetDetails["url"] as? String
        planet?.films = planetDetails["films"] as? [String]
        planet?.residents = planetDetails["residents"] as? [String]
        
        return planet
    }
    
    class func newObject(WithContext context: NSManagedObjectContext, andEntityName entityName: String) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        return NSManagedObject(entity: entity, insertInto: context)
    }
}
