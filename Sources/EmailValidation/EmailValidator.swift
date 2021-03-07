//
//  EmailValidator.swift
//  
//
//  Created by Jimmy McDermott on 3/7/21.
//

import Foundation
import NIO

/// A protocol that defines an object that can validate an email
public protocol EmailValidator {

    /// Validates the email
    func validate(email: String) -> EventLoopFuture<EmailValidationResponse>
}
