import XCTest
@testable import GameManager

final class GameManagerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GameManager().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
