//
//  SubFilterBrandsResponseDTO.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/09/07.
//

import Foundation

struct SubFiltersBrandsResponseDTO: Codable {
    let success: Bool
    let response: [SubFilterOfBrand]
    let error: String?
    
    func toDomain() -> [SubFilter] {
        return response.map{ $0.toDomain() }
    }
    
    struct SubFilterOfBrand: Codable {
        let subFilterId: Int = 0
        let subFilterName: String
        let filterItems: [FilterItemOfBrand]
        
        enum CodingKeys: String, CodingKey {
            case subFilterName = "brandFirstLetter"
            case filterItems = "brandItems"
        }
        
        func toDomain() -> SubFilter {
            return .init(subFilterId: subFilterId, subFilterName: subFilterName, filterItems: filterItems.map{$0.toDomain()})
        }
        
        struct FilterItemOfBrand: Codable {
            let filterItemId: Int
            let filterItemName: String
            
            enum CodingKeys: String, CodingKey {
                case filterItemId = "id"
                case filterItemName = "name"
            }
            
            func toDomain() -> FilterItem {
                return .init(filterItemId: filterItemId, filterItemName: filterItemName)
            }
        }
    }
}
