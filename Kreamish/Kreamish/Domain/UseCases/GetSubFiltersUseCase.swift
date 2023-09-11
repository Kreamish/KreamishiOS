//
//  GetSubFiltersUseCase.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/09/06.
//

import Combine
import Foundation

protocol GetSubFiltersUseCase {
    // parentFilterId: 1(카테고리) / 2(브랜드) / 3(컬렉션) / 4(사이즈)
    func execute(parentFilterId: Int, completion: @escaping (Result<[SubFilter], Error>) -> Void) -> Cancellable?
}

final class DefaultGetSubFiltersUseCase {
    private let subFiltersRepository: SubFiltersRepository
    init(subFiltersRepository: SubFiltersRepository) {
        self.subFiltersRepository = subFiltersRepository
    }
    func execute(parentFilterId: Int, completion: @escaping (Result<[SubFilter], Error>) -> Void) -> Cancellable? {
        return subFiltersRepository.fetchSubFilters(parentFilterId: parentFilterId, completion: { result in
                completion(result)
        })
    }
}
