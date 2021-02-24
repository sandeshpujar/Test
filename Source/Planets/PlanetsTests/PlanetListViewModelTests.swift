//
//  PlanetListViewModelTests.swift
//  PlanetsTests
//
//  Created by Sandesh on 24/02/21.
//

import XCTest
import UIKit

class PlanetListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialization() {
        let viewModel = MockPlanetListViewModel_Init()
        
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.screenTitle, "Planets")
        XCTAssertTrue(viewModel.isPrepareDataCalled)
    }
    
    func testPrepareData_NoCachedData() {
        let viewModel = MockPlanetListViewModel_RefreshDataOverride()
        
        XCTAssertTrue(viewModel.isRefreshDataCalled)
    }
    
    func testPrepareData_CachedData() {
        let mockDataManager = MockPlanetDataManager.self
        let viewModel = MockPlanetListViewModel_RefreshDataOverride(dataManager: mockDataManager)
        XCTAssertTrue(mockDataManager.fetchAllPlanetsCalled)
        XCTAssertFalse(viewModel.isRefreshDataCalled)
    }
    
    func testRefreshData_SuccessData() {
        let mockServiceManager = MockPlanetServiceManager.self
        let viewModel = MockPlanetListViewModel_Init()
        viewModel.refreshData(serviceManager: mockServiceManager)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertTrue(mockServiceManager.fetchPlanetsMethodCalled)
            XCTAssertEqual(viewModel.planets?.count, 2)
        }
    }
    
    func testTableDataSourceMethods() {
        let planet = Planet()
        
        let viewModel = MockPlanetListViewModel_Init()
        viewModel.planets = [planet]
        
        XCTAssertEqual(viewModel.numberOfRows(), 1)
    }
    
    func testPlanetTableViewCellViewModel_Init() {
        let viewModel = PlanetTableViewCellViewModel(planetName: "Chanandler Bong", planetClimate: "Too hot", planetTerrain: "Wheee!", planetPopulation: "Gotta control!", planetDiameter: "Thinny")
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.planetName, "Chanandler Bong")
        XCTAssertEqual(viewModel.planetClimate, "Too hot")
        XCTAssertEqual(viewModel.planetTerrain, "Wheee!")
        XCTAssertEqual(viewModel.planetPopulation, "Gotta control!")
        XCTAssertEqual(viewModel.planetDiameter, "Thinny")
    }
    
    // MARK: - Mock classes
    
    // MARK: Mock View model classes
    class MockPlanetListViewModel_Init: PlanetListViewModel {
        var isPrepareDataCalled = false
        override func prepareData(dataManager: PlanetDataManager.Type = PlanetDataManager.self, serviceManager: PlanetServiceManager.Type = PlanetServiceManager.self) {
            self.isPrepareDataCalled = true
        }
    }
    
    class MockPlanetListViewModel_RefreshDataOverride: PlanetListViewModel {
        var isRefreshDataCalled = false
        override func refreshData(serviceManager: PlanetServiceManager.Type = PlanetServiceManager.self) {
            self.isRefreshDataCalled = true
        }
    }
    
    // MARK: Mock data manager classes
    
    class MockPlanetDataManager: PlanetDataManager {
        static var fetchAllPlanetsCalled = false
        override class func fetchAllPlanets() -> [Planet]? {
            MockPlanetDataManager.fetchAllPlanetsCalled = true
            let planet: Planet = Planet()
            return [planet]
        }
    }
    
    class MockPlanetServiceManager: PlanetServiceManager {
        static var fetchPlanetsMethodCalled = false
        override class func fetchPlanets(_ completion: @escaping (Any?, Bool) -> ()) {
            MockPlanetServiceManager.fetchPlanetsMethodCalled = true
            
            let planet1: Planet = Planet()
            let planet2: Planet = Planet()
            
            completion([planet1, planet2], true)
        }
    }
    
    // MARK: Mock view controller classes
    
    class MockPlanetListViewController: PlanetListViewController {
        var handleLoadingTableViewMethodCalled = false
        var handleLoadingIndicatorMethodCalled = false
        var handleErrorAlertViewControllerMethodCalled = false
        
        override func handleLoadingTableview() {
            self.handleLoadingTableViewMethodCalled = true
        }
        
        override func handleLoadingIndicator(_ shouldShowIndicator: Bool) {
            self.handleLoadingIndicatorMethodCalled = true
        }
        
        override func handleErrorAlert() {
            self.handleErrorAlertViewControllerMethodCalled = true
        }
    }
}
