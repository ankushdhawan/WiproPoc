//
//  CountryDataSourceTests.swift
//  POCTests
//
//  Created by Ankush on 3/9/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
import XCTest
@testable import POC

class CountryDataSourceTests: XCTestCase {
    var dataSource: CountryDataSource!
    let tableView = UITableView()
    
    override func setUp() {
        super.setUp()
        
        dataSource = CountryDataSource()
        
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: Constants.Indentifier.kCountryCell)
        tableView.estimatedRowHeight = 44
        
        for number in 0..<20 {
            let model = CountryDetailModel(title: "Tile:\(number)", description:"description:\(number)" , imageHref: "url:\(number)")
            dataSource.countryDtailModels.append(model)
        }
    }
    
    func testDataSourceHasCountries() {
        XCTAssertEqual(dataSource.countryDtailModels.count, 20,
                       "DataSource should have correct number of CountryModelArray")
    }
    
    func testHasZeroSectionsWhenZeroCountry() {
        dataSource.countryDtailModels = []
        
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 0,
                       "TableView should have zero sections when no CountryModelArray are present")
    }
    
    func testHasOneSectionWhenCountryArePresent() {
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1,
                       "TableView should have one section when CountryModelArray are present")
    }
    
    func testNumberOfRows() {
        let numberOfRows = dataSource.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 20,
                       "Number of rows in table should match number of CountryModelArray")
    }
    func testCellForCustomClass()
    {
        let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        guard cell is CountryTableViewCell  else {
            return XCTFail("Controller's table view Cell should have a country tableView cell")
        }
    }
    
    func testCellForRow() {
        testCellForCustomClass()
        let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! CountryTableViewCell
        XCTAssertEqual(cell.titleLable.text, "Tile:0",
                       "The first cell should display name of first kitten")
    }
   
    
}
