//  NumberTesting.swift
//  VectorMathTests
//  Created by Robert Sale on 11/22/20.

import XCTest
import SceneKit
@testable import VectorExtensions
import VectorProtocol

final class VectorMathTests: XCTestCase {
    let v2 = CGPoint(x: 2, y: 5)
    #if canImport(SceneKit)
    let v3 = SCNVector3(2, 5, 2)
    let v4 = SCNQuaternion(2, 5, 2, 1)
    #endif
    
    func testAddScalar() throws {
        XCTAssertEqual(v2.addedScalar(2), CGPoint(x: 4, y: 7))
        XCTAssertEqual(v2 + 3, CGPoint(x: 5, y: 8))
        #if canImport(SceneKit)
        XCTAssertEqual(v3.addedScalar(2), SCNVector3(4, 7, 4))
        XCTAssertEqual(v4.addedScalar(2), SCNQuaternion(4, 7, 4, 3))
        XCTAssertEqual(v3 + 4, SCNVector3(6, 9, 6))
        XCTAssertEqual(v4 + 5, SCNQuaternion(7, 10, 7, 6))
        #endif
    }
    func testSubScalar() throws {
        XCTAssertEqual(v2.subbedScalar(2), CGPoint(x: 0, y: 3))
        XCTAssertEqual(v2 - 3, CGPoint(x: -1, y: 2))
        #if canImport(SceneKit)
        XCTAssertEqual(v3.subbedScalar(2), SCNVector3(0, 3, 0))
        XCTAssertEqual(v4.subbedScalar(2), SCNQuaternion(0, 3, 0, -1))
        XCTAssertEqual(v3 - 4, SCNVector3(-2, 1, -2))
        XCTAssertEqual(v4 - 5, SCNQuaternion(-3, 0, -3, -4))
        #endif
    }
    func testMultScalar() throws {
        XCTAssertEqual(v2.multipliedScalar(2), CGPoint(x: 4, y: 10))
        XCTAssertEqual(v2 * 3, CGPoint(x: 6, y: 15))
        #if canImport(SceneKit)
        XCTAssertEqual(v3.multipliedScalar(2), SCNVector3(4, 10, 4))
        XCTAssertEqual(v4.multipliedScalar(2), SCNQuaternion(4, 10, 4, 2))
        XCTAssertEqual(v3 * 4, SCNVector3(8, 20, 8))
        XCTAssertEqual(v4 * 5, SCNQuaternion(10, 25, 10, 5))
        #endif
    }
    func testDivScalar() throws {
        XCTAssertEqual(v2.dividedScalar(2), CGPoint(x: 1, y: 2.5))
        XCTAssertEqual(v2 / 3, CGPoint(x: 2.0 / 3, y: 5.0 / 3))
        #if canImport(SceneKit)
        XCTAssertEqual(v3.dividedScalar(2), SCNVector3(1, 2.5, 1))
        XCTAssertEqual(v4.dividedScalar(2), SCNQuaternion(1, 2.5, 1, 0.5))
        XCTAssertEqual(v3 / 4, SCNVector3(2.0 / 4, 5.0 / 4, 2.0 / 4))
        XCTAssertEqual(v4 / 5, SCNQuaternion(2.0 / 5, 5.0 / 5, 2.0 / 5, 1.0 / 5))
        #endif
    }
    func testTranslate() throws {
        XCTAssertEqual(v2.translated(CGPoint(x: 1, y: -1)), CGPoint(x: 3, y: 4))
        XCTAssertEqual(v2 + CGPoint(x: 1, y: -1), CGPoint(x: 3, y: 4))
        #if canImport(SceneKit)
        XCTAssertEqual(v3.translated(SCNVector3(1, -1, 1)), SCNVector3(3, 4, 3))
        XCTAssertEqual(v4.translated(SCNQuaternion(1, -1, 1, -1)), SCNQuaternion(3, 4, 3, 0))
        XCTAssertEqual(v3 + SCNVector3(1, -1, 1), SCNVector3(3, 4, 3))
        XCTAssertEqual(v4 + SCNQuaternion(1, -1, 1, -1), SCNQuaternion(3, 4, 3, 0))
        #endif
    }
    func testFlip() throws {
        XCTAssertEqual(v2.flipped(.x), CGPoint(x: -2, y: 5))
        #if canImport(SceneKit)
        XCTAssertEqual(v3.flipped(.x, .z), SCNVector3(-2, 5, -2))
        XCTAssertEqual(v4.flipped(.y, .w), SCNQuaternion(2, -5, 2, -1))
        #endif
    }
    func testZero() throws {
        XCTAssertEqual(v2.zeroed(.x), CGPoint(x: 0, y: 5))
        #if canImport(SceneKit)
        XCTAssertEqual(v3.zeroed(.x, .z), SCNVector3(0, 5, 0))
        XCTAssertEqual(v4.zeroed(.y, .w), SCNQuaternion(2, 0, 2, 0))
        #endif
    }
    func testRound() throws {
        XCTAssertEqual(v2.dividedScalar(scale: 3).rounded(), CGPoint(x: 1, y: 2))
        #if canImport(SceneKit)
        XCTAssertEqual(v3.dividedScalar(scale: 3).rounded(), SCNVector3(1, 2, 1))
        XCTAssertEqual(v4.dividedScalar(scale: 3).rounded(), SCNQuaternion(1, 2, 1, 0))
        #endif
    }
    func testDistance() throws {
        XCTAssertEqual(v2.distance(CGPoint.zero), v2.length)
        #if canImport(SceneKit)
        XCTAssertEqual(v3.distance(SCNVector3()), v3.length)
        XCTAssertEqual(v4.distance(SCNQuaternion()), v4.length)
        #endif
    }
    
}
