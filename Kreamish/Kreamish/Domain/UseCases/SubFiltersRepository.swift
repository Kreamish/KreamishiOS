//
//  SubFiltersRepository.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/09/07.
//

import Combine
import Foundation

protocol SubFiltersRepository {
    func fetchSubFilters(parentFilterId: Int, completion: @escaping (Result<[SubFilter], Error>) -> Void) -> Cancellable?
}

