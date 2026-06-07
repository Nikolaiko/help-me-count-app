//
//  TransportLayer.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.01.2026.
//

import Foundation

struct TransportLayer {

    private let urlSession = URLSession.shared

    func makeRequest(request: URLRequest) async -> Result<Data, NetworkError> {
        do {
            let result = try await urlSession.data(for: request)

            if let errorStatus = validate(response: result.1) {
                return .failure(errorStatus)
            }

            return .success(result.0)

        } catch {
            return .failure(NetworkError.genericNetworkError)
        }
    }

    private func validate(response: URLResponse) -> NetworkError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .genericNetworkError
        }
        
        switch httpResponse.statusCode {
        case 100..<200, 300..<400:
            return .wrongStatus
        case 400..<500:
            return .client
        case 500..<600:
            return .server
        default:
            break
        }
        return nil
    }
}
