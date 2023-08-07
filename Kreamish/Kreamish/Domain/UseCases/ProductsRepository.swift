//
//  ProductsRepository.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/08/06.
//
import Combine
import Foundation

protocol ProductsRepository {
    func fetchProductsPage(completion: @escaping (Result<ProductsPage, Error>) -> Void) -> Cancellable?
}
