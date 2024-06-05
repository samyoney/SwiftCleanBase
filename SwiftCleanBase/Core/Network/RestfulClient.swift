import Foundation
import Combine
import Reachability

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>
extension HTTPCodes {
    static let success = 200 ..< 300
}

class RestfulClient  {

    func fetch<R>(_ endpoint: Endpoint, using requestBody: R)
    -> AnyPublisher<RestfulResponse, RestfulError> where R: Encodable
    {
        startRequest(for: endpoint, requestBody: requestBody)
            .mapError { error -> RestfulError in
                error as? RestfulError ?? RestfulError.unKnown
            }
            .eraseToAnyPublisher()
    }
    
    private lazy var session = {
        URLSession(configuration: URLSessionConfiguration.default)
    }()
    
    private lazy var reachability = {
        try! Reachability()
    }()
    
    
    private func startRequest<R: Encodable>(for endpoint: Endpoint, requestBody: R? = nil)
    -> AnyPublisher<RestfulResponse, Error> {
        var request: URLRequest
        do {
            request = try buildRequest(endpoint: endpoint, requestBody: requestBody)
        } catch {
            print("❌ Configuration Request Failed")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: request)
            .handleEvents(receiveSubscription: { _ in
                print("Starting network request")
            }, receiveOutput: { _ in
            }, receiveCompletion: { _ in
            }, receiveCancel: {
                print("Request cancelled")
            })
            .tryMap { (data: Data, response: URLResponse) in
                assert(!Thread.isMainThread)
                if self.reachability.connection == .unavailable {
                    throw RestfulError.connectionFail
                } else {
                    if let response = response as? HTTPURLResponse {
                        if HTTPCodes.success.contains(response.statusCode) {
                            return RestfulResponse(data: data, response: response)
                        } else {
                            let error = self.filterError(response.statusCode)
                            throw error
                        }
                    } else {
                        throw RestfulError.dataError
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func buildRequest<R: Encodable>(endpoint: Endpoint,
                                            requestBody: R?) throws -> URLRequest {
        var request = URLRequest(url: endpoint.url, timeoutInterval: 10)
        print("🚀 \(endpoint.method) API: \(request)")
        request.httpMethod = endpoint.method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if !(requestBody is Empty) {
            if let body = requestBody {
                do {
                    print("📥 HTTP Request:")
                    printPretty(body)
                    request.httpBody = try JSONEncoder().encode(body)
                } catch {
                    throw RestfulError.dataError
                }
            }
        } else {
            print("📥 Request is empty")
        }
        return request
    }

    struct RestfulResponse {
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
