import Foundation

enum ErrorType {
    case forbidden
    case notFound
    case conflict
    case internalServerError
    case unKnown
    case connectionFail
    case requestFail
    case dataError
}

class RestfulError: Error {
    let status: ErrorType
    let message: String?
    
    init(status: ErrorType, message: String?) {
        self.status = status
        self.message = message
    }
}

