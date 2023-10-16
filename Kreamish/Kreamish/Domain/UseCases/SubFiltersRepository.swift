
import Combine
import Foundation

protocol SubFiltersRepository {
    func fetchSubFilters(filterId: Int, completion: @escaping (Result<[SubFilter], Error>) -> Void) -> Cancellable?
}

