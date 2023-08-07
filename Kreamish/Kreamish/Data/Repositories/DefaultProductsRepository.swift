//
//  DefaultProductsRepository.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/08/06.
//
import Combine
import Foundation

final class DefaultProductsRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultProductsRepository: ProductsRepository {
    func fetchProductsPage(completion: @escaping (Result<ProductsPage, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        let endpoint = APIEndpoints.getProducts()
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
