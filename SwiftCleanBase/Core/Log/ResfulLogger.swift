//
//  NetworkLoggerManager.swift
//  SwiftCleanBase
//
//  Created by HS-Macbook on 2024/06/01.
//

import Alamofire
import Foundation

public enum ResfulLoggerLevel {
    /// リクエストおよびレスポンスをログに記録しない
    /// リクエストやレスポンスのログを一切残さない設定です
    case off
    ///　リクエストに対してHTTPメソッド、URL、ヘッダーフィールド、リクエストボディをログに記録し
    ///　レスポンスに対してステータスコード、URL、ヘッダーフィールド、レスポンス文字列、経過時間をログに記録します。
    ///　非常に詳細な情報をログに残す設定です。開発やデバッグ時に役立ちます。
    case debug
    
    /// リクエストに対してHTTPメソッドとURLをログに記録し
    /// レスポンスに対してステータスコード、URL、経過時間をログに記録します。
    /// 基本的な情報をログに残す設定です。通常の運用時に適しています。
    case info
    /// リクエストに対してHTTPメソッドとURLをログに記録し、
    /// レスポンスに対してステータスコード、URL、経過時間をログに記録しますが、失敗したリクエストのみログに記録します。
    /// 問題が発生した場合にのみログを記録する設定です。パフォーマンスに影響を与えずに、エラーを追跡するのに役立ちます。
    case warn
    /// エラーログを記録する設定です。失敗したリクエストに対してログを残します。
    case error
    /// 致命的なエラーに対してログを記録しません
    case fatal
}

public class ResfulLogger {
    
    public static let shared = ResfulLogger()
    
    public var level: ResfulLoggerLevel
    
    public var filterPredicate: NSPredicate?
    
    private let queue = DispatchQueue(label: "\(ResfulLogger.self) Queue")
    
    
    init() {
        level = .info
    }
    
    deinit {
        stopLogging()
    }
        
    public func startLogging() {
        stopLogging()
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(ResfulLogger.requestDidStart(notification:)),
            name: Request.didResumeNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(ResfulLogger.requestDidFinish(notification:)),
            name: Request.didFinishNotification,
            object: nil
        )
    }
    
    public func stopLogging() {
        NotificationCenter.default.removeObserver(self)
    }
        
    @objc private func requestDidStart(notification: Notification) {
        queue.async {
            guard let dataRequest = notification.request as? DataRequest,
                let task = dataRequest.task,
                let request = task.originalRequest,
                let httpMethod = request.httpMethod,
                let requestURL = request.url
                else {
                    return
            }
            
            if let filterPredicate = self.filterPredicate, filterPredicate.evaluate(with: request) {
                return
            }
            
            switch self.level {
            case .debug:
                let cURL = dataRequest.cURLDescription()
                
                self.logDivider()
                
                print("\(httpMethod) '\(requestURL.absoluteString)':")
                
                print("cURL:\n\(cURL)")
            case .info:
                self.logDivider()
                
                print("\(httpMethod) '\(requestURL.absoluteString)'")
            default:
                break
            }
        }
    }
    
    @objc private func requestDidFinish(notification: Notification) {
        queue.async {
            guard let dataRequest = notification.request as? DataRequest,
                let task = dataRequest.task,
                let metrics = dataRequest.metrics,
                let request = task.originalRequest,
                let httpMethod = request.httpMethod,
                let requestURL = request.url
                else {
                    return
            }
            
            if let filterPredicate = self.filterPredicate, filterPredicate.evaluate(with: request) {
                return
            }
            
            let elapsedTime = metrics.taskInterval.duration
            
            if let error = task.error {
                switch self.level {
                case .debug, .info, .warn, .error:
                    self.logDivider()
                    
                    print("[Error] \(httpMethod) '\(requestURL.absoluteString)' [\(String(format: "%.04f", elapsedTime)) s]:")
                    print(error)
                default:
                    break
                }
            } else {
                guard let response = task.response as? HTTPURLResponse else {
                    return
                }
                
                switch self.level {
                case .debug:
                    self.logDivider()
                    
                    print("\(String(response.statusCode)) '\(requestURL.absoluteString)' [\(String(format: "%.04f", elapsedTime)) s]:")
                    
                    self.logHeaders(headers: response.allHeaderFields)
                    
                    guard let data = dataRequest.data else { break }
                    
                    print("Body:")
                    
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                        
                        if let prettyString = String(data: prettyData, encoding: .utf8) {
                            print(prettyString)
                        }
                    } catch {
                        if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                            print(string)
                        }
                    }
                case .info:
                    self.logDivider()
                    
                    print("\(String(response.statusCode)) '\(requestURL.absoluteString)' [\(String(format: "%.04f", elapsedTime)) s]")
                default:
                    break
                }
            }
        }
        
    }
}

private extension ResfulLogger {
    func logDivider() {
        print("---------------------")
    }
    
    func logHeaders(headers: [AnyHashable : Any]) {
        print("Headers: [")
        for (key, value) in headers {
            print("  \(key): \(value)")
        }
        print("]")
    }
}
