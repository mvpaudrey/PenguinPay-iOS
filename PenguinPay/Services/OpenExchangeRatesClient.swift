//
//  OpenExchangeRatesClient.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import Foundation

public class OpenExchangeRatesClient {

    private let session = URLSession(configuration: .default)

    private let baseURL = Constants.baseExchancheUrl

    let path: String = "/api/latest.json"

    func getRates<T: Decodable>(base: String, to: String,
                                completion: @escaping (Result<T, OpenExchangeRatesServiceError>) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(.failure(.invalidEndpoint))
            return
        }

        urlComponents.path = path

        let queryItems = [
            URLQueryItem(name: "app_id", value: Constants.openExchangeAPIKey),
            URLQueryItem(name: "base", value: base),
            URLQueryItem(name: "symbols", value: to)
        ]

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }

        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.apiError))
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
            }

        }

        task.resume()
    }

}
