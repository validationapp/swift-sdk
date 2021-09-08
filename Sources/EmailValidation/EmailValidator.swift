//
//  EmailValidator.swift
//  
//
//  Created by Jimmy McDermott on 3/7/21.
//

import Foundation
import NIO

/// A protocol that defines an object that can validate an email
@available(macOS 12.0.0, *)
public protocol EmailValidator {

    /// Validates the email
    func validate(email: String) async throws -> EmailValidationResponse
}
