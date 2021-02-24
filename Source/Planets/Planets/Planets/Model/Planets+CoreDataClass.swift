//
//  Planets+CoreDataClass.swift
//  Planets
//
//  Created by Sandesh on 24/02/21.
//
//

import Foundation
import CoreData
import UIKit

/**
 Part of the core data model object class which creates the Planets object
 */
@objc(Planets)
public class Planets: NSManagedObject {

    /**
     Creates the Planets managed object
     - parameter planetsDetails: The dictionary using which the planet object is created
     - returns: The created planets object
     */
    class func newPlanets(_ planetsDetails: [String: Any?]) -> Planets? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let planets = Planets.newObject(WithContext: appDelegate.persistentContainer.viewContext, andEntityName: "Planets") as? Planets
        planets?.count = planetsDetails["count"] as? Int32 ?? 0
        planets?.previous = planetsDetails["previous"] as? String
        planets?.previous = planetsDetails["next"] as? String
        
        if let planetList = planetsDetails["results"] as? [[String: Any?]] {
            let planetSet = planets?.mutableSetValue(forKeyPath: "allPlanets")
            for planetItem in planetList {
                let planet = Planet.newPlanet(planetItem)
                planetSet?.add(planet as Any)
            }
        }
        
        return planets
    }
    
    class func newObject(WithContext context: NSManagedObjectContext, andEntityName entityName: String) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        return NSManagedObject(entity: entity, insertInto: context)
    }
}
