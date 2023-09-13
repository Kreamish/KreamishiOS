
import Combine
import Foundation

final class DefaultCategoriesRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultCategoriesRepository: CategoriesRepository {
    func fetchCategoryList(completion: @escaping (Result<[Category], Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        let endpoint = APIEndpoints.getCategories()
        task.networkTask = self.dataTransferService.request(
                        with: endpoint
                    ) { result in
                        switch result {
                        case .success(let responseDTO):
                            print(responseDTO)
                            completion(.success(responseDTO.response.toDomain()))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
        return task
    }
}
