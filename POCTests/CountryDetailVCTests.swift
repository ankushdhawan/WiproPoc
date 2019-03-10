//
//  CountryDetailVCTests.swift
//  POCTests
//
//  Created by Ankush on 3/9/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
import UIKit
@testable import POC
import XCTest

class CountryVCTests: XCTestCase {
    
    var controller: CountryVC!
    var tableView: UITableView!
    var dataSource: CountryDataSource!
    var delegate: UITableViewDelegate!
    
    override func setUp() {
        super.setUp()
        let vc = CountryVC()
        controller = vc
        tableView = controller.countryDescTable
        // Check the Table data source is CountryDataSource
        guard let ds = tableView.dataSource as? CountryDataSource else {
            return XCTFail("Controller's table view should have a country data source")
        }
        
        dataSource = ds
        delegate = tableView.delegate
    }
    //Check Table Has cells
    func testTableViewHasCells() {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Indentifier.kCountryCell)
        
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'Cell'")
    }
    //Check Table view delegate is view controller
    func testTableViewDelegateIsViewController() {
        XCTAssertTrue(tableView.delegate === controller,
                      "Controller should be delegate for the table view")
    }
}


