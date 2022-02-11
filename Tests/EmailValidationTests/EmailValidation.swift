import XCTest
import AsyncHTTPClient
@testable import EmailValidation

final class EmailValidationTests: XCTestCase {
    // This test hits network, need valid API key
//    func testWorks() async throws {
//        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
//        let validator = EmailValidatorAPI(httpClient: httpClient, apiKey: "ADD_YOUR_API_KEY_HERE")
//        defer { try! httpClient.syncShutdown() }
//
//        let response = try await validator.validate(email: "email@email.com")
//        XCTAssertEqual(response.data.request_email, "email@email.com")
//        XCTAssertEqual(response.data.is_deliverable, true)
//    }

    func testMock() async throws {
        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
        let validator = MockEmailValidator()
        defer { try! httpClient.syncShutdown() }
        
        let response = try await validator.validate(email: "email@email.com")
        XCTAssertEqual(response.data.request_email, "email@email.com")
        XCTAssertEqual(response.data.is_deliverable, true)
    }
}
