import Foundation

enum RestfulError: Error {
    
    case forbidden
    case notFound
    case conflict
    case internalServerError
    case unKnown
    case connectionFail
    case dataError(_ error: Error)
    
    // 応用する可能性がある
//    case badRequest = 400
//    case unauthorized = 401
//    case forbidden = 403
//    case notFound = 404
//    case methodNotAllowed = 405
//
//    case internalServerError = 500
//    case notImplemented = 501
//    case badGateway = 502
//    case serviceUnavailable = 503
//    case gatewayTimeout = 504

    
    var code: String {
        switch self {
        case .unKnown:
            return "U"
        case .connectionFail:
            return "C"
        default:
            return "O"
        }
    }

    var message: String {
        switch self {
        case .unKnown:
            return "Unknown error"
        case .connectionFail:
            return "Internet is interrupted"
        default:
            return "Occurred Error"
        }
    }
}
