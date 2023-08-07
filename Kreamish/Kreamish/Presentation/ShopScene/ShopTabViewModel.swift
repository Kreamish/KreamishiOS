//
//  ShopTabViewModel.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/09.
//

import Combine
import Foundation

class ShopTabViewModel {
    private let getCategoriesUseCase: GetCategoriesUseCase
    private var categoriesLoadTask: Cancellable?
    @Published var categoryList: [Category] = []
    
    init(getCategoriesUseCase: GetCategoriesUseCase){
        self.getCategoriesUseCase = getCategoriesUseCase
    }
    
    func getCategoryList() {
        load()
    }
    
    private func load() {
        categoriesLoadTask = getCategoriesUseCase.execute { result in
            switch result {
            case .success(let categoryList):
                self.categoryList = categoryList
            case .failure(let error):
                print(error)
            }
        }
    }
}
