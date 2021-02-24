//
//  PlanetServiceManager.swift
//  Planets
//
//  Created by Sandesh on 24/02/21.
//

import UIKit

/**
 Service manager for fetching planets related data
 */
class PlanetServiceManager: NSObject {
    
    static let baseURL = "https://swapi.dev/api"
    static let planetsURL = "/planets/"
    
    /**
     Fetches the list of planets
     - parameter completion: The completion block after the response has been received
     - parameter response: The object returned once reso=ponse is received
     - parameter success: The bool which indicates if the process was a success or failure
     */
    class func fetchPlanets(_ completion: @escaping(_ response: Any?, _ success: Bool) -> ()) {
        let urlString = String(format: "%@%@", baseURL, planetsURL)
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { (data, response, error) in            
            guard error == nil, let data = data, let httpsResponse = response as? HTTPURLResponse, (200...209).contains(httpsResponse.statusCode) else {
                completion(nil, false)
                return
            }
            PlanetDataManager.processPlanetData(data: data, completion: completion)
        }
        task.resume()
    }
}
