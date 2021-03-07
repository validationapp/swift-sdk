//
//  MockEmailValidator.swift
//  
//
//  Created by Jimmy McDermott on 3/7/21.
//

import Foundation
import NIO

/// A mock email validator
public struct MockEmailValidator: EmailValidator {

    /// The event loop to run the mock validator on
    public let eventLoop: EventLoop

    /// Initalizes a mock object
    public init(eventLoop: EventLoop) {
        self.eventLoop = eventLoop
    }

    /// "Validates" the email
    public func validate(email: String) -> EventLoopFuture<EmailValidationResponse> {
        let mockResponse = EmailValidationResponse(
            data: .init(uuid: "",
                        request_email: "",
                        ip_address: nil,
                        is_spam: false,
                        is_deliverable: true,
                        is_blacklisted: false,
                        passes_rfc: true,
                        passes_domain_check: true,
                        passes_mx_check: true,
                        passes_spoof_check: true,
                        spam_score: 0,
                        domain_risk: 0,
                        network_type: nil,
                        created_at: Date(),
                        updated_at: Date(),
                        email: .init(uuid: "",
                                     address: "",
                                     is_disposable: false,
                                     is_free_provider: false,
                                     is_role_address: false,
                                     is_catchall_address: false,
                                     last_checked_at: Date()
                        )
            )
        )

        return eventLoop.makeSucceededFuture(mockResponse)
    }
}
