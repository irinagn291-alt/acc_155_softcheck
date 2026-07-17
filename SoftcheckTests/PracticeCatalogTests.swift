import XCTest
@testable import Softcheck

final class PracticeCatalogTests: XCTestCase {
    func testPracticeLookupByKnownID() {
        let practice = PracticeCatalog.practice(id: "breathing.478")
        XCTAssertEqual(practice?.name, "4-7-8 breathing")
        XCTAssertEqual(practice?.category, .breathing)
    }

    func testUnknownIDReturnsNilUnlessFallback() {
        XCTAssertNil(PracticeCatalog.practice(id: "does.not.exist"))
        XCTAssertEqual(PracticeCatalog.practice(id: PracticeCatalog.fallback.id)?.id, PracticeCatalog.fallback.id)
    }

    func testCatalogIsNonEmpty() {
        XCTAssertGreaterThan(PracticeCatalog.all.count, 10)
    }
}
