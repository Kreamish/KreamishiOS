//
//  DataTransferService.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/24.
//

import Foundation

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

protocol DataTransferDispatchQueue {
    func asyncExecute(work: @escaping () -> Void)
}

extension DispatchQueue: DataTransferDispatchQueue {
    func asyncExecute(work: @escaping () -> Void) {
        async(group: nil, execute: work)
    }
}

protocol DataTransferService {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void
    
    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E,
        on queue: DataTransferDispatchQueue,
        completion: @escaping CompletionHandler<T>
    ) -> NetworkCancellable? where E.Response == T
    
    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<T>
    ) -> NetworkCancellable? where E.Response == T

    @discardableResult
    func request<E: ResponseRequestable>(
        with endpoint: E,
        on queue: DataTransferDispatchQueue,
        completion: @escaping CompletionHandler<Void>
    ) -> NetworkCancellable? where E.Response == Void
    
    @discardableResult
    func request<E: ResponseRequestable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<Void>
    ) -> NetworkCancellable? where E.Response == Void
}

protocol DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error
}

protocol DataTransferErrorLogger {
    func log(error: Error)
}

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
    
}

final class DefaultDataTransferService {
    
    private let networkService: NetworkService
    private let errorResolver: DataTransferErrorResolver
    private let errorLogger: DataTransferErrorLogger
    
    init(
        with networkService: NetworkService,
        errorResolver: DataTransferErrorResolver = DefaultDataTransferErrorResolver(),
        errorLogger: DataTransferErrorLogger = DefaultDataTransferErrorLogger()
    ) {
        self.networkService = networkService
        self.errorResolver = errorResolver
        self.errorLogger = errorLogger
    }
}

extension DefaultDataTransferService: DataTransferService {
    
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E,
        on queue: DataTransferDispatchQueue,
        completion: @escaping CompletionHandler<T>
    ) -> NetworkCancellable? where E.Response == T {

        networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(
                    data: data,
                    decoder: endpoint.responseDecoder
                )
                queue.asyncExecute { completion(result) }
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                queue.asyncExecute { completion(.failure(error)) }
            }
        }
    }
    
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<T>
    ) -> NetworkCancellable? where E.Response == T {
        request(with: endpoint, on: DispatchQueue.main, completion: completion)
    }

    func request<E>(
        with endpoint: E,
        on queue: DataTransferDispatchQueue,
        completion: @escaping CompletionHandler<Void>
    ) -> NetworkCancellable? where E : ResponseRequestable, E.Response == Void {
        networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success:
                queue.asyncExecute { completion(.success(())) }
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                queue.asyncExecute { completion(.failure(error)) }
            }
        }
    }

    func request<E>(
        with endpoint: E,
        completion: @escaping CompletionHandler<Void>
    ) -> NetworkCancellable? where E : ResponseRequestable, E.Response == Void {
        request(with: endpoint, on: DispatchQueue.main, completion: completion)
    }

    // MARK: - Private
    private func decode<T: Decodable>(
        data: Data?,
        decoder: ResponseDecoder
    ) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            self.errorLogger.log(error: error)
            return .failure(.parsing(error))
        }
    }
    
    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError
        ? .networkFailure(error)
        : .resolvedNetworkFailure(resolvedError)
    }
}

// MARK: - Logger
final class DefaultDataTransferErrorLogger: DataTransferErrorLogger {
    init() { }
    
    func log(error: Error) {
        print("-------------")
        print("\(error)")
    }
}

// MARK: - Error Resolver
class DefaultDataTransferErrorResolver: DataTransferErrorResolver {
    init() { }
    func resolve(error: NetworkError) -> Error {
        return error
    }
}

class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    init() { }
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
