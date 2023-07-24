//
//  CategoriesRepository.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/16.
//
import Combine
import Foundation

protocol CategoriesRepository {
    func fetchCategoryList(completion: @escaping (Result<[Category], Error>) -> Void) -> Cancellable?
}
