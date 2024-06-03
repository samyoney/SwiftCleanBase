import Foundation

enum RestfulError: Error {
    case forbidden
    case notFound
    case conflict
    case internalServerError
    case unKnown
    case connectionFail
    case dataError
    
    
    var message: String {
        switch self {
        case .unKnown:
            return "I dont know that error"
        default:
            return "Occurred Error"
        }
    }
    
}

struct Empty: Encodable {
    
}

