//
//  CountryModelTests.swift
//  POCTests
//
//  Created by Ankush on 3/10/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import XCTest
@testable import POC
class CountryModelTests: XCTestCase {
    var model:CountryModel! = nil
    override func setUp() {
        let modelArray = [CountryDetailModel]()
        model = CountryModel(title: "test1", rows: modelArray)
    }
    override func tearDown() {
        model = nil
    }
    func testModelHasATitle() {
   
    XCTAssertEqual(model.title, "test1",
                   "CountryModel Title should be set in initializer")
    
    }
    
    func testCountryRowsIsNotNilByDefault() {
        XCTAssertNotNil(model.rows,
                       "model rows not be nil")
    }
    
   

}
