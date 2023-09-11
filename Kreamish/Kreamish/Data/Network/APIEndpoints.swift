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
    static func getProducts(with productsRequestDTO: ProductsRequestDTO) -> Endpoint<ProductsResponseDTO> {
        return Endpoint(
            path: "items",
            method: .get,
            queryParametersEncodable: productsRequestDTO
        )
    }
    static func getSubFiltersCategories() -> Endpoint<SubFiltersCategoriesResponseDTO> {
        return Endpoint(
            path: "filter/categories",
            method: .get
        )
    }
    static func getSubFiltersBrands() -> Endpoint<SubFiltersBrandsResponseDTO> {
        return Endpoint(
            path: "filter/brand",
            method: .get
        )
    }
    
}
