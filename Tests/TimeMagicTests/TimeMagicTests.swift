import XCTest
@testable import TimeMagic

final class TimeMagicTests: XCTestCase {
    func testGetTimeString() {
        XCTAssertEqual(TimeMagic.getTimeString(0.0), "0.0 ns")
        XCTAssertEqual(TimeMagic.getTimeString(1e3), "1.0 µs")
        XCTAssertEqual(TimeMagic.getTimeString(1e6), "1.0 ms")
        XCTAssertEqual(TimeMagic.getTimeString(1e9), "1.0 seconds")
    }

    func testTimer() {
        let t = TimeMagic.Timer()
        t.stop()
        XCTAssertTrue(t.getTime() > 0)
        let timeStringOne = TimeMagic.getTimeString(Double(t.getTime()))
        XCTAssertEqual(t.getTimeAsString(), timeStringOne)
    }

    static var allTests = [
        ("testGetTimeString", testGetTimeString),
        ("testTimer", testTimer),
    ]
}
