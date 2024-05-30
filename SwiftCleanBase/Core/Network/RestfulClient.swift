import RxSwift
import Alamofire
import Foundation


protocol RestfulClient {
    func fetch<T: Codable>(executeApi: @escaping (_ completion: @escaping ((_ data: T?, _ error: Error?) -> Void)) -> Void) -> Single<T>
    
    func filterError(_ response: Any?,_ error: Error?) -> RestfulError
}


class RestfulClientImpl: RestfulClient {
    func fetch<T: Codable>(executeApi: @escaping (_ completion: @escaping ((_ data: T?, _ error: Error?) -> Void)) -> Void) -> Single<T> {
        return Single<T>.create { (observer) -> Disposable in
            executeApi { response, error in
                if let reachabilityManager = NetworkReachabilityManager(), !reachabilityManager.isReachable {
                    
                    observer(.failure(RestfulError.init(status: .connectionFail, message: R.string.textFile.errorApiMessage())))
                } else {
                    if error != nil  {
                        observer(.failure(self.filterError(response, error)))
                    } else {
                        if let response = response {
                            observer(.success(response))
                        } else {
                            observer(.failure(self.filterError(response, error)))
                        }
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func filterError(_ response: Any?,_ error: Error?) -> RestfulError {
        var errorType: ErrorType
        let messageError = R.string.textFile.errorApiMessage()
                
        if error != nil {
            if let error = error as? RestfulError {
                return error
            } else if let err = error as? AFError, let code = err.responseCode {
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
            } else if error is DecodingError {
                errorType = .dataError
            } else {
                errorType = .unKnown
            }
        } else {
            errorType = .unKnown
        }
        return RestfulError.init(status: errorType, message: messageError)
    }
}
