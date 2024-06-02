import Foundation
import Combine

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}

protocol RestfulClient {
    func get<T: Decodable, E: Endpoint>(_ endpoint: E) -> AnyPublisher<T, Error>
    
    func post<S: Encodable, E: Endpoint>(_ endpoint: E, using body: S)
    -> AnyPublisher<Void, Error>
    
}


class RestfulClientImpl {
    private lazy var session: URLSession = {
        URLSession(configuration: URLSessionConfiguration.default)
    }()
    
    
    func post<S, E>(_ endpoint: E, using body: S)
    -> AnyPublisher<Void, Error> where S: Encodable, E: Endpoint
    {
        startRequest(for: endpoint, method: RestfulMethod.post.rawValue, jsonBody: body)
            .map { _ in () }
            .catch { error -> AnyPublisher<Void, Error> in
                switch error {
                case RestfulError.dataError:
                    return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
                default:
                    return Fail<Void, Error>(error: error).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    
    private func startRequest<T: Encodable, S: Endpoint>(for endpoint: S, method: String, jsonBody: T? = nil)
    -> AnyPublisher<RestfulResponse, Error> {
        var request: URLRequest
        
        do {
            request = try buildRequest(endpoint: endpoint, method: method, jsonBody: jsonBody)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: request)
            .mapError { (error: Error) -> Error in
                return RestfulError.unKnown
            }
            .tryMap { (data: Data, response: URLResponse) in
                assert(!Thread.isMainThread)
                if let response = response as? HTTPURLResponse {
                    if HTTPCodes.success.contains(response.statusCode)  {
                        return RestfulResponse(data: data, response: response)
                    } else {
                        throw self.filterError(response.statusCode)
                    }
                } else {
                    throw RestfulError.unKnown
                }
            }
            .extractUnderlyingError()
            .eraseToAnyPublisher()
    }
    
    private func buildRequest<T: Encodable, S: Endpoint>(endpoint: S,
                                                         method: String,
                                                         jsonBody: T?) throws -> URLRequest {
        var request = URLRequest(url: endpoint.url, timeoutInterval: 10)
        request.httpMethod = method
        if let body = jsonBody {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                throw RestfulError.dataError
            }
        }
        return request
    }
    
    private struct RestfulResponse {
        let data: Data
        let response: HTTPURLResponse
        
        func parseJson<T: Decodable>() throws -> T {
            if data.isEmpty {
                throw RestfulError.notFound
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                return result
            } catch {
                throw RestfulError.dataError
            }
        }
    }
    
    private func filterError(_ errorCode: Int?) -> RestfulError {
        var errorType: RestfulError = .unKnown
        if let code = errorCode {
            switch code {
            case 403:
                errorType = .forbidden
            case 404:
                errorType = .notFound
            case 409:
                errorType = .conflict
            case 500:
                errorType = .internalServerError
            default:
                errorType = .unKnown
            }
        } else {
            errorType = .unKnown
        }
        return errorType
    }
}
