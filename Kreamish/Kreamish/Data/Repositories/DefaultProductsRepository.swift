
import Combine
import Foundation

final class DefaultProductsRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultProductsRepository: ProductsRepository {
    func fetchProductsPage(categoryIds: String?, brandIds: String?, collectionIds: String?, page: Int?, size: Int?, completion: @escaping (Result<ProductsPage, Error>) -> Void) -> Cancellable? {
        let requestDTO = ProductsRequestDTO(categoryIds: categoryIds, brandIds: brandIds, collectionIds: collectionIds, page: page, size: size)
        let task = RepositoryTask()
        let endpoint = APIEndpoints.getProducts(with: requestDTO)
        task.networkTask = self.dataTransferService.request(
                        with: endpoint
                    ) { result in
                        switch result {
                        case .success(let responseDTO):
                            print(responseDTO)
                            completion(.success(responseDTO.response.productsPage.toDomain()))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
        return task
    }
}
