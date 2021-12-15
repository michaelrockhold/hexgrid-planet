import XCTest
@testable import HexGridPlanet

final class HexGridPlanetTests: XCTestCase {
    func testZero() throws {
        XCTAssertEqual(HexGridPlanet(0).size, 12)
    }

    func testTiny() throws {
        XCTAssertEqual(HexGridPlanet(1).size, 32)
    }

    func testSmall() throws {
        XCTAssertEqual(HexGridPlanet(4).size, 812)
    }

    func testBig() throws {
        XCTAssertEqual(HexGridPlanet(8).size, 65612)
    }
    
    func testQuiteBig() throws {
        XCTAssertEqual(HexGridPlanet(10).size, 590492)
    }

    func testVeryBig() throws {
        XCTAssertEqual(HexGridPlanet(12).size, 5314412)
    }

    func testSuper() throws {
        XCTAssertEqual(HexGridPlanet(24).size, 5314412)
    }

}
