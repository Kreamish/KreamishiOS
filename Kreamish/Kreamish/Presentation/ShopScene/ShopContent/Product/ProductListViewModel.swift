//
//  ProductListViewModel.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/08/06.
//
import Combine
import Foundation

class ProductListViewModel {
    private let getProductsUseCase: GetProductsUseCase
    private var productsLoadTask: Cancellable?
    @Published var productsPage: ProductsPage? = nil
    
    var currentPage = 0
    var totalPage = 0
    var hasMorePages: Bool { currentPage < totalPage }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }

    init(getProductsUseCase: GetProductsUseCase) {
        self.getProductsUseCase = getProductsUseCase
    }
    
    func getProductsPage() {
        load()
    }
    
    private func load() {
        productsLoadTask = getProductsUseCase.execute { result in
            switch result {
            case .success(let productsPage):
                self.productsPage = productsPage
            case .failure(let error):
                print(error)
            }
        }
    }
}
