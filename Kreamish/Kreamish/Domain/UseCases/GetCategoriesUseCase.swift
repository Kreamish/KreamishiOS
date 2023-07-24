//
//  CategoryUseCase.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/16.
//
import Combine
import Foundation

protocol GetCategoriesUseCase {
    func execute(completion: @escaping (Result<[Category], Error>) -> Void) -> AnyCancellable?
}

final class DefaultGetCategoriesUseCase: GetCategoriesUseCase {
    private let categoriesRepository: CategoriesRepository
    init(){
        self.categoriesRepository = DefaultCategoriesRepository()
    }
    func execute(completion: @escaping (Result<[Category], Error>) -> Void) -> AnyCancellable? {
        return categoriesRepository.fetchCategoryList(completion: { result in
            completion(result)
        })
    }
}
