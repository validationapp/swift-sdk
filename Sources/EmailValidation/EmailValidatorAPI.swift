//
//  EmailValidator.swift
//  
//
//  Created by Jimmy McDermott on 3/7/21.
//

import Foundation
import AsyncHTTPClient
import NIO

/// An object that can validate an email using the `validation.app` service
@available(macOS 12.0.0, *)
public struct EmailValidatorAPI: EmailValidator {

    /// The URL to send the request to
    private let url = "https://api.validation.app/validate"

    /// The client to make the requests with
    public let httpClient: HTTPClient

    /// The API Key for the `validation.app` service
    public let apiKey: String

    /// Initialize a new `EmailValidator`
    public init(httpClient: HTTPClient, apiKey: String) {
        self.httpClient = httpClient
        self.apiKey = apiKey
    }

    /// Validate an email against the `validation.app` service
    /// - Parameter email: The email address to validate
    /// - Returns: An `EmailValidationResponse` object with the results of the API call
    public func validate(email: String) async throws -> EmailValidationResponse {
        // Setup a date formatter to handle the custom date format from `validation.app`
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        // Create the JSONEncoder and JSONDecoder to handle the custom json data
        let jsonEncoder = JSONEncoder()
        let jsonDecoder = JSONDecoder()
        jsonEncoder.dateEncodingStrategy = .formatted(dateFormatter)
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)

        // Format the content and create the `Data` object from it
        let content = EmailValidationRequest(email: email)
        guard let requestData = try? jsonEncoder.encode(content) else {
            throw EmailValidationError.cannotEncodeData
        }

        // Formulate the HTTPClient Request
        guard let request = try? HTTPClient.Request(url: url,
                                                    method: .POST,
                                                    headers: [
                                                        "Authorization" : "Bearer \(apiKey)",
                                                        "Content-Type": "application/json"
                                                    ],
                                                    body: .data(requestData)) else {
            throw EmailValidationError.cannotEncodeData
        }

        return try await withCheckedThrowingContinuation { continuation in
            _ = httpClient.execute(request: request).flatMapThrowing { response in
                guard let byteBuffer = response.body else {
                    continuation.resume(throwing: EmailValidationError.responseBodyMissing)
                    return
                }

                let responseData = Data(byteBuffer.readableBytesView)
                let data = try jsonDecoder.decode(EmailValidationResponse.self, from: responseData)
                continuation.resume(returning: data)
            }.flatMapErrorThrowing { err in
                continuation.resume(throwing: err)
                return
            }
        }
    }
}
