import XCTest
@testable import Board

final class BoardTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Board().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
