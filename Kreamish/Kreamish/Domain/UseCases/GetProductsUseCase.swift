//
//  GetProductsUseCase.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/08/06.
//
import Combine
import Foundation

protocol GetProductsUseCase {
    func execute(completion: @escaping (Result<ProductsPage, Error>) -> Void) -> Cancellable?
}

final class DefaultGetProductsUseCase: GetProductsUseCase {
    private let productsRepository: ProductsRepository
    init(productsRepository: ProductsRepository){   // 의존성 주입
        self.productsRepository = productsRepository
    }
    func execute(completion: @escaping (Result<ProductsPage, Error>) -> Void) -> Cancellable? {
        return productsRepository.fetchProductsPage(completion: { result in
            completion(result)
        })
    }
}
