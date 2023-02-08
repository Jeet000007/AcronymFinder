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
    
    func testAcronymFinderServiceForValidData() throws {
        let expectation = expectation(description: "RequestSuccess")
        RequestHelper.shared.performGetRequest(url: Constants.acronymURL, paramters: [Parameters(key: Constants.sf, value: "NASA")]) { data, success, message  in
            XCTAssertTrue(success)
            if success{
                do{
                    
                    guard let data = data else { return }
                    let acronymData = try JSONDecoder().decode([AcronymModelElement].self, from: data)
                    //print("acronymData\(acronymData)")
                    XCTAssertNotNil(acronymData)
                }catch{
                    XCTFail("invalid response")
                }
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testAcronymFinderServiceForInValidData() throws {
        let expectation = expectation(description: "RequestSuccess")
        RequestHelper.shared.performGetRequest(url: Constants.acronymURL, paramters: [Parameters(key: Constants.sf, value: "")]) { data, success, message  in
            XCTAssertTrue(success)
            if success{
                do{
                    guard let data = data else { return }
                    let acronymData = try JSONDecoder().decode([AcronymModelElement].self, from: data)
                    //print("acronymData\(acronymData)")
                    XCTAssertNil(acronymData)
                    XCTAssertEqual(acronymData.isEmpty, true)
                }catch{
                    XCTFail("invalid response")
                }
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
}
