//
//  EmailValidationError.swift
//  
//
//  Created by Jimmy McDermott on 3/7/21.
//

import Foundation

/// Errors that can occur while networking with `validation.app`
public enum EmailValidationError: Error {

    /// Occurs when the `EmailValidator` object cannot encode the request data
    case cannotEncodeData

    /// The response from `validation.app` is missing
    case responseBodyMissing
}
