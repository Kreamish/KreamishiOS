
import Combine
import Foundation

final class DefaultSubFiltersRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultSubFiltersRepository: SubFiltersRepository {
    func fetchSubFilters(filterId: Int, completion: @escaping (Result<[SubFilter], Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        
        switch filterId {
        case Constants.FILTER_CATEGORIES_ID:
            let endpoint = APIEndpoints.getSubFiltersCategories()
            task.networkTask = self.dataTransferService.request(
                with: endpoint
            ) { result in
                switch result {
                case .success(let responseDTO):
                    print(responseDTO)
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        case Constants.FILTER_BRANDS_ID:
            let endpoint = APIEndpoints.getSubFiltersBrands()
            task.networkTask = self.dataTransferService.request(
                with: endpoint
            ) { result in
                switch result {
                case .success(let responseDTO):
                    print(responseDTO)
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        default:
            print("error")
        }
        
        return task
    }
}
