//
//  ProductsRequestDTO.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/08/27.
//

import Foundation

struct ProductsRequestDTO: Encodable {
    let categoryIds: String?
    let brandIds: String?
    let collectionIds: String?
    let page: Int?
    let size: Int?
    
    enum CodingKeys: String, CodingKey {
        case categoryIds = "category-ids"
        case brandIds = "brand-ids"
        case collectionIds = "collection-ids"
    }
}
