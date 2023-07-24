//
//  CategoriesReponseDTO.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/16.
//

import Foundation

struct CategoriesResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case categories = "categories"
    }
    let categories: [CategoryDTO]
}

extension CategoriesResponseDTO {
    struct CategoryDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case categoryId
            case name
        }
        let categoryId: Int
        let name: String
    }
}

// MARK: - Mappings to Domain
extension CategoriesResponseDTO {
    func toDomain() -> [Category] {
        return categories.map{ $0.toDomain() }
    }
}

extension CategoriesResponseDTO.CategoryDTO {
    func toDomain() -> Category {
        return .init(categoryId: categoryId, name: name)
    }
}
