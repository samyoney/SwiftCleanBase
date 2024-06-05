import Foundation

enum RestfulError: Error {
    
    case forbidden
    case notFound
    case conflict
    case internalServerError
    case unKnown
    case connectionFail
    case dataError
    
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

struct Empty: Encodable {
    
}

