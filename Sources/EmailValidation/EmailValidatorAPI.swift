//
//  EmailValidator.swift
//  
//
//  Created by Jimmy McDermott on 3/7/21.
//

import Foundation
import AsyncHTTPClient
import Logging
import NIOCore

/// An object that can validate an email using the `validation.app` service
public struct EmailValidatorAPI: EmailValidator {

    /// The URL to send the request to
    private let url = "https://api.validation.app/validate"

    /// The client to make the requests with
    public let httpClient: HTTPClient

    /// The API Key for the `validation.app` service
    public let apiKey: String
    
    /// Logger for HTTPClient
    public let logger: Logger?
    
    /// Request timeout amount
    public let timeout: TimeAmount?

    /// Initialize a new `EmailValidator`
    public init(
        httpClient: HTTPClient,
        apiKey: String,
        logger: Logger? = nil,
        timeout: TimeAmount = .seconds(30)
    ) {
        self.httpClient = httpClient
        self.apiKey = apiKey
        self.logger = logger
        self.timeout = timeout
    }

    /// Validate an email against the `validation.app` service
    /// - Parameter email: The email address to validate
    /// - Returns: An `EmailValidationResponse` object with the results of the API call
    public func validate(email: String) async throws -> EmailValidationResponse {
        // Format the content and create the `Data` object from it
        let content = EmailValidationRequest(email: email)
        guard let requestData = try? Self.jsonEncoder.encode(content) else {
            throw EmailValidationError.cannotEncodeData
        }

        // Formulate the HTTPClient Request
        var request = HTTPClientRequest(url: url)
        request.method = .POST
        request.body = .bytes(ByteBuffer(data: requestData))
        request.headers = [
            "Authorization" : "Bearer \(apiKey)",
            "Content-Type": "application/json"
        ]

        let response = try await httpClient.execute(request, timeout: timeout, logger: logger)
        guard let body = try? await response.body.collect(upTo: 1024 * 1024) else { // 1 MB
            throw EmailValidationError.responseBodyMissing
        }

        return try Self.jsonDecoder.decode(EmailValidationResponse.self, from: body)
    }
    
    // Setup a date formatter to handle the custom date format from `validation.app`
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df
    }()
    
    // Create JSONEncoder to handle the custom json data
    static let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }()
    
    // Create JSONDecoder to handle the custom json data
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
