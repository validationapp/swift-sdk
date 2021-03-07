import XCTest

import validationTests

var tests = [XCTestCaseEntry]()
tests += validationTests.allTests()
XCTMain(tests)
