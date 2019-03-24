import XCTest
@testable import TimeMagic

final class TimeMagicTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TimeMagic.getTimeString(0.0), "0.0 ns")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
