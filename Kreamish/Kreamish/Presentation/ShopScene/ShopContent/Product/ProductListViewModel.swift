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
    @Published var productsPage: ProductsPage?
    
    private let categoryIds: String?
    private let brandIds: String?
    private let collectionIds: String?
    var currentPage = 0
    var totalPage = 0
    var hasMorePages: Bool { currentPage < totalPage }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }
    
    init(getProductsUseCase: GetProductsUseCase, categoryIds: String?, brandIds: String?, collectionIds: String?) {
        self.getProductsUseCase = getProductsUseCase
        self.categoryIds = categoryIds
        self.brandIds = brandIds
        self.collectionIds = collectionIds
    }
    
    func getProductsPage() {
        load()
    }
    
    private func load() {
        productsLoadTask = getProductsUseCase.execute(categoryIds: categoryIds, brandIds: brandIds, collectionIds: collectionIds, page: currentPage, size: 20) { result in
            switch result {
            case .success(let productsPage):
                self.productsPage = productsPage
            case .failure(let error):
                print(error)
            }
        }
    }
}
