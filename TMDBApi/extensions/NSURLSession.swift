//
//  NSURLSession.swift
//  TMDBApi
//
//  Created by 鍾秉辰 on 2023/11/15.
//

import Foundation
import Combine

private func parseJSONData(_ data: Data) -> Any? {
    return (try? JSONSerialization.jsonObject(with: data, options: []))
}

internal extension URLSession {
    
    private static var shouldLogRequest: Bool {
#if DEBUG
        return true
#else
        return false
#endif
    }
    
    /// Wrap an URLSession concurrency with error envelope logic.
    func dataResponse(_ request: URLRequest) async throws -> Data {
        // smart compiler should be able to optimize this out
        let d: Date?

        if Self.shouldLogRequest {
            d = Date()
        }
        else {
           d = nil
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            dataTask(with: request) { data, response, error in
                if Self.shouldLogRequest {
                    let interval = Date().timeIntervalSince(d ?? Date())
                    print(convertURLRequestToCurlCommand(request))
                    print(convertResponseToString(response, error.map { $0 as NSError }, interval))
                }
                
                guard let response = response as? HTTPURLResponse, isValidResponse(response: response) else {
                    continuation.resume(throwing: ErrorEnvelope.couldNotParseJSON)
                    return
                }
                guard let data = data else {
                    continuation.resume(throwing: ErrorEnvelope.couldNotParseJSON)
                    return
                }
                
                continuation.resume(returning: data)
            }
            .resume()
        }
    }
}


private func escapeTerminalString(_ value: String) -> String {
    return value.replacingOccurrences(of: "\"", with: "\\\"", options:[], range: nil)
}

private func convertURLRequestToCurlCommand(_ request: URLRequest) -> String {
    let method = request.httpMethod ?? "GET"
    var returnValue = "curl -X \(method) "

    if let httpBody = request.httpBody {
        let maybeBody = String(data: httpBody, encoding: String.Encoding.utf8)
        if let body = maybeBody {
            returnValue += "-d \"\(escapeTerminalString(body))\" "
        }
    }

    for (key, value) in request.allHTTPHeaderFields ?? [:] {
        let escapedKey = escapeTerminalString(key as String)
        let escapedValue = escapeTerminalString(value as String)
        returnValue += "\n    -H \"\(escapedKey): \(escapedValue)\" "
    }

    let URLString = request.url?.absoluteString ?? "<unknown url>"

    returnValue += "\n\"\(escapeTerminalString(URLString))\""

    returnValue += " -i -v"

    return returnValue
}


private func convertResponseToString(_ response: URLResponse?, _ error: NSError?, _ interval: TimeInterval) -> String {
    let ms = Int(interval * 1000)

    if let response = response as? HTTPURLResponse {
        if 200 ..< 300 ~= response.statusCode {
            return "Success (\(ms)ms): Status \(response.statusCode)"
        }
        else {
            return "Failure (\(ms)ms): Status \(response.statusCode)"
        }
    }

    if let error = error {
        if error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
            return "Canceled (\(ms)ms)"
        }
        return "Failure (\(ms)ms): NSError > \(error)"
    }

    return "<Unhandled response from server>"
}


private func isValidResponse(response: HTTPURLResponse) -> Bool {
    guard (200..<300).contains(response.statusCode),
          let headers = response.allHeaderFields as? [String: String],
          let contentType = headers["Content-Type"], contentType.hasPrefix("application/json") else {
        return false
    }
    
    return true
}
