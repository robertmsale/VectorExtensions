import XCTest
@testable import VectorExtensions

final class VectorExtensionsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(VectorExtensions().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
