
import XCTest
@testable import UnitTestingProject

final class UnitTestingProjectTests: XCTestCase {

    var nextAndPreviousButtonView: NextAndPreviousButton?

    override func setUpWithError() throws {
        try super.setUpWithError()
        nextAndPreviousButtonView = NextAndPreviousButton(currentPage: .constant(0))
    }

    override func tearDownWithError() throws {
        nextAndPreviousButtonView = nil
        try super.tearDownWithError()
    }

    func testNextButton_2To0() {
        let isNext = true
        var currentPage = 2
        currentPage = nextAndPreviousButtonView!.updateCurrentPage(isNext: isNext, currentPage: currentPage)
        XCTAssertEqual(0, currentPage)
    }
    func testNextButton_0To1() {
        let isNext = true
        var currentPage = 0
        currentPage = nextAndPreviousButtonView!.updateCurrentPage(isNext: isNext, currentPage: currentPage)
        XCTAssertEqual(1, currentPage)
    }
    
    func testPriviousButton_2To1() {
        let isNext = false
        var currentPage = 2
        currentPage = nextAndPreviousButtonView!.updateCurrentPage(isNext: isNext, currentPage: currentPage)
        XCTAssertEqual(1, currentPage)
    }
    
    func testPriviousButton_0To2() {
        let isNext = false
        var currentPage = 0
        currentPage = nextAndPreviousButtonView!.updateCurrentPage(isNext: isNext, currentPage: currentPage)
        XCTAssertEqual(2, currentPage)
    }

    func testPerformanceExample() throws {
        measure {
            testNextButton_2To0()
            testNextButton_0To1()
            testPriviousButton_2To1()
            testPriviousButton_0To2()
        }
    }
}
