//
// EmailValidationResponse.swift
//  
//
//  Created by Jimmy McDermott on 3/7/21.
//

import Foundation

/// The response received from the validation.app API
public struct EmailValidationResponse: Codable {

    /// The data for the response
    public let data: Data

    /// The data that is returned
    public struct Data: Codable {
        /// The UUID for the request
        public let uuid: String

        /// The email requested to check
        public let request_email: String

        /// The IP of the address, if applicable
        public let ip_address: String?

        /// Whether or not the email is spam
        public let is_spam: Bool

        /// Whether or not the email is deliverable
        public let is_deliverable: Bool

        /// Whether or not the email is blacklisted
        public let is_blacklisted: Bool

        /// Whether or not the email passes RFC validation
        public let passes_rfc: Bool

        /// Whether or not the email passes a domain check
        public let passes_domain_check: Bool

        /// Whether or not the domain has valid MX records
        public let passes_mx_check: Bool

        /// Whether or not the email passes the spoof check
        public let passes_spoof_check: Bool

        /// The spam score for the email
        public let spam_score: Int

        /// The domain risk for the email
        public let domain_risk: Int

        /// The network type for the email
        public let network_type: String?

        /// The date this request was created (i.e. `2021-03-07 06:03:17`)
        public let created_at: Date

        /// The date this request was last updated (i.e. `2021-03-07 06:03:17`)
        public let updated_at: Date

        /// The email object
        public let email: Email

        /// The email object
        public struct Email: Codable {

            /// The UUID of this specific email
            public let uuid: String

            /// The address of the email
            public let address: String

            /// Whether or not the email is disposable
            public let is_disposable: Bool

            /// Whether or not the email comes from a free provider
            public let is_free_provider: Bool

            /// Whether or not this is a role address
            public let is_role_address: Bool

            /// Whether or not this is a catch all address
            public let is_catchall_address: Bool

            /// The date this was last checked at (i.e. `2021-03-07 06:03:17`)
            public let last_checked_at: Date
        }
    }
}
