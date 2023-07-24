//
//  DefaultCategoriesRepository.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/16.
//
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
                            completion(.success(responseDTO.toDomain()))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
        return task
    }
}
