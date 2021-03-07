//
//  EmailValidationRequest.swift
//  
//
//  Created by Jimmy McDermott on 3/7/21.
//

import Foundation

/// The request object to validate an email
public struct EmailValidationRequest: Codable {

    /// The email to check
    public let email: String
}
