
import Combine
import Foundation

protocol GetSubFiltersUseCase {
    // filterId: 1(카테고리) / 2(브랜드) / 3(컬렉션) / 4(사이즈)
    func execute(filterId: Int, completion: @escaping (Result<[SubFilter], Error>) -> Void) -> Cancellable?
}

final class DefaultGetSubFiltersUseCase: GetSubFiltersUseCase {
    private let subFiltersRepository: SubFiltersRepository
    init(subFiltersRepository: SubFiltersRepository) {
        self.subFiltersRepository = subFiltersRepository
    }
    func execute(filterId: Int, completion: @escaping (Result<[SubFilter], Error>) -> Void) -> Cancellable? {
        return subFiltersRepository.fetchSubFilters(filterId: filterId, completion: { result in
            completion(result)
        })
    }
}
