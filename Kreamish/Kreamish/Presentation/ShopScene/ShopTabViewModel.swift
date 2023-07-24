//
//  ShopTabViewModel.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/09.
//

import Combine
import Foundation

class ShopTabViewModel {
    private let getCategoriesUseCase: GetCategoriesUseCase
    private var categoriesLoadTask: AnyCancellable?
    @Published var categoryList: [Category] = []
    
    init(){
        self.getCategoriesUseCase = DefaultGetCategoriesUseCase()
    }
    
    func getCategoryList() {
        update()
//        URLSession.shared.dataTaskPublisher(for: URL("카테고리 api url"))
//            .map(\.data)
//            .decode(type: APIResponse.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { _ in
//                // Handle completion or error
//            }, receiveValue: { [weak self] apiResponse in
//                self?.categoryList = apiResponse.response.categories
//            })
//            .store(in: &cancellables)
    }
    private func update() {
        load()
    }
    private func load() {
        categoriesLoadTask = getCategoriesUseCase.execute { result in
            switch result {
            case .success(let categoryList):
                self.categoryList = categoryList
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct APIResponse: Decodable {
    let response: Response
}

struct Response: Decodable {
    let categories: [Category]
}
