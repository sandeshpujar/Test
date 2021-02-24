//
//  PlanetDataManager.swift
//  Planets
//
//  Created by Sandesh on 24/02/21.
//

import UIKit
import CoreData

/**
 Data manager for managing all operations on the core data and data parsing
 */
class PlanetDataManager: NSObject {
    
    /**
     Fetches the list of planets
     - parameter data: The data that needs to be parsed
     - parameter completion: The completion block after the response has been received
     - parameter response: The object returned once reso=ponse is received
     - parameter success: The bool which indicates if the process was a success or failure
     */
    class func processPlanetData(data: Data, completion: @escaping(_ response: Any?, _ success: Bool) -> ()) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                  let planetsInfo = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                completion(nil, false)
                return
            }
            PlanetDataManager.saveAllPlanets(planetsInfo, appDelegate: appDelegate, completion: completion)
        }
    }
    
    // MARK: - Core date save method
    
    /**
te     Saves the list of planets into core data
     - parameter planetInfo: The parsed data that needs to be stored into core data
     - parameter appDelegate: The instance of the app delegate
     - parameter completion: The completion block after the response has been received
     - parameter response: The object returned once reso=ponse is received
     - parameter success: The bool which indicates if the process was a success or failure
     */
    class func saveAllPlanets(_ planetsInfo: [String: Any], appDelegate: AppDelegate, completion: @escaping(_ response: Any?, _ success: Bool) -> ()) {
        PlanetDataManager.deleteAllPlanets()
        let planets = Planets.newPlanets(planetsInfo)
        appDelegate.saveContext()
        
        completion(planets, true)
    }
    
    // MARK: - Core data fetch method
    
    /**
     Fetches the list of planets from core data
     - returns: The array of planets
     */
    class func fetchAllPlanets() -> [Planet]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Planet")
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let allPlanets = try managedContext.fetch(fetchRequest) as? [Planet]
            return allPlanets
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    // MARK: - Core data delete method
    
    /**
     Deletes all the planets in core data
     */
    class func deleteAllPlanets() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        guard let allPlanets = PlanetDataManager.fetchAllPlanets() else {
            return
        }
        for planet: Planet in allPlanets {
            appDelegate.persistentContainer.viewContext.delete(planet)
        }
        appDelegate.saveContext()
    }
}
