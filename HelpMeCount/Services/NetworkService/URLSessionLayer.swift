//
//  URLSessionLayer.swift
//  TrainingSessions
//
//  Created by Nikolai Baklanov on 24.10.2025.
//

import Foundation

struct URLSessionLayer {

    func makeRequest(urlRequest: URLRequest) async -> Result<Data, Error> {
        guard let result = try? await URLSession.shared.data(for: urlRequest)
        else { return .failure(NetworkErrors.networkError) }

        return .success(result.0)
    }
}
