# Swift EmailValidation

This package is a client for the https://validation.app API. It allows you to submit an email for validation and receive the response from the API in a typed fashion. 

**Note**: You must first have an API key and tokens available from the https://validation.app platform.

## Installation:

To start using EmailValidation, in your Package.swift add the following

```swift
.package(url: "https://github.com/validationapp/swift-sdk.git", from: "0.0.1")
```

## Usage:

Initialize the `EmailValidator`:

```swift
let httpClient = HTTPClient(..)
let validator = EmailValidator(httpClient: httpClient, apiKey: "ADD_YOUR_API_KEY_HERE", eventLoop: eventLoop)
```

If you are in a Vapor app, you can do something like this:

```swift 
extension Request {
    var emailValidator: EmailValidator {
        .init(
            httpClient: self.application.http.client.shared,
            apiKey: "ADD_YOUR_API_KEY_HERE",
            eventLoop: self.eventLoop
        )
    }
}
```

Once you have an `EmailValidator` object, you can call `.validate(email: "email-goes-here")` on it to get back a `EmailValidationResponse` object:

```swift
let response = try validator.validate(email: "email@email.com").wait()
XCTAssertEqual(response.data.request_email, "email@email.com") // True
```

If you have the `EmailValidator` installed as an extension in your Vapor app, you can use it in routes:

```swift 
func myRoute(req: Request) throws -> EventLoopFuture<EmailValidationResponse> {
    req.emailValidator.validate(email: "email@email.com")
}
```