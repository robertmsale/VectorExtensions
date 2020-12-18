//  NumberTesting.swift
//  VectorMathTests
//  Created by Robert Sale on 11/22/20.

import XCTest
@testable import VectorExtensions

class NumberTesting: XCTestCase {
    
    let x: CGFloat = 10 + 1 / 3

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRounding() throws { XCTAssertEqual(x.rounded(toNearest: 1.0), 10) }
    func testRoundingFraction() throws { XCTAssertEqual(x.rounded(toNearest: 0.25), 10.25) }
    func testFloor() throws { XCTAssertEqual(x.floor, 10) }
    func testCeil() throws { XCTAssertEqual(x.ceil, 11) }
    func testClampMax() throws { XCTAssertEqual(x.clamp(min: 0, max: 7), 7) }
    func testClampMin() throws { XCTAssertEqual(x.clamp(min: 11, max: 20), 11) }
    func testDistance() throws {
        let derp = -5.0
        let dist = derp.distance(4)
        XCTAssertEqual(dist, 9)
    }
}
