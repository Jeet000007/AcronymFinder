//
//  AcronymFinderTests.swift
//  AcronymFinderTests
//
//  Created by Jeet Jayakar on 06/02/23.
//

import XCTest
@testable import AcronymFinder

final class AcronymFinderTests: XCTestCase {
    
    var viewModel : AcronymFinderViewModel!

    override func setUpWithError() throws {
        viewModel = AcronymFinderViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAcronymFinderService() throws {
//        viewModel.performAcronymSearch(searchText: "NASA")
//
//        let expectation = expectation(description: "Completion handler invoked")
//        wait(for: [expectation], timeout: 5) // it helps to wait in thread.
//
//        //expectation.fulfill()
//
//        XCTAssertNil(viewModel.acronymData)
//        XCTAssertNotNil(viewModel.acronymData)
        
    }

}
