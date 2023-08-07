//
//  CategoriesReponseDTO.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/16.
//

import Foundation

struct CategoriesResponseDTO: Decodable {
    let response: CategoriesResponse
    let error: String? // Assuming error is of type String, modify it as needed
}

struct CategoriesResponse: Decodable {
    let empty: Bool
    let categories: [CategoryDTO]
    
    func toDomain() -> [Category] {
        return categories.map{ $0.toDomain() }
    }
}

struct CategoryDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case categoryId
        case name
    }
    let categoryId: Int
    let name: String
    func toDomain() -> Category {
        return .init(categoryId: categoryId, name: name)
    }
}
