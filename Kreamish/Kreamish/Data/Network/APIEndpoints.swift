//
//  APIEndpoints.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/16.
//

import Foundation

struct APIEndpoints {
    static func getCategories() -> Endpoint<CategoriesResponseDTO> {
        return Endpoint(
            path: "categories",
            method: .get,
            queryParametersEncodable: nil
        )
    }
    static func getProducts() -> Endpoint<ProductsResponseDTO> {
        return Endpoint(
            path: "items",
            method: .get,
            queryParametersEncodable: nil   // 필터 구현시 넣어야함
        )
    }
}
