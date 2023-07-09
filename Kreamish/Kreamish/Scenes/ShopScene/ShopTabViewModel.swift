//
//  ShopTabViewModel.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/09.
//

import Combine
import Foundation

class ShopTabViewModel: ObservableObject {
    @Published var categoryList: [Category] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchCategoryList() {
        guard let url = URL(string: "http://49.167.148.185:31234/categories") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                // Handle completion or error
            }, receiveValue: { [weak self] apiResponse in
                self?.categoryList = apiResponse.response.categories
            })
            .store(in: &cancellables)
    }
}

struct APIResponse: Decodable {
    let response: Response
}

struct Response: Decodable {
    let categories: [Category]
}
