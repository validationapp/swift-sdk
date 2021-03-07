import XCTest
@testable import EmailValidation
import NIO
import AsyncHTTPClient

final class EmailValidationTests: XCTestCase {
    func testWorks() throws {
        let eventLoop = EmbeddedEventLoop()
        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
        let validator = EmailValidator(httpClient: httpClient, apiKey: "ADD_YOUR_API_KEY_HERE", eventLoop: eventLoop)
        defer { try! httpClient.syncShutdown() }

        let response = try validator.validate(email: "email@email.com").wait()
        XCTAssertEqual(response.data.request_email, "email@email.com")
        XCTAssertEqual(response.data.is_deliverable, true)
    }

    static var allTests = [
        ("testWorks", testWorks),
    ]
}
