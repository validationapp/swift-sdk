import XCTest
@testable import EmailValidation
import NIO
import AsyncHTTPClient

@available(macOS 12.0.0, *)
final class EmailValidationTests: XCTestCase {
    func testWorks() async throws {
        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
        let validator = EmailValidatorAPI(httpClient: httpClient, apiKey: "ADD_YOUR_API_KEY_HERE")
        defer { try! httpClient.syncShutdown() }

        let response = try await validator.validate(email: "email@email.com")
        XCTAssertEqual(response.data.request_email, "email@email.com")
        XCTAssertEqual(response.data.is_deliverable, true)
    }

    static var allTests = [
        ("testWorks", testWorks),
    ]
}
