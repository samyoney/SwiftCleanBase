import Foundation

enum RestfulError: Error {
    case forbidden
    case notFound
    case conflict
    case internalServerError
    case unKnown
    case connectionFail
    case requestFail(code: Int)
    case requestFail(error: Error)
    case dataError
}

