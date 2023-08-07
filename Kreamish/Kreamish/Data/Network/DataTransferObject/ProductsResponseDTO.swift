// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct ProductsResponseDTO: Codable {
    let success: Bool
    let response: ProductsResponse
    let error: String?
}

struct ProductsResponse: Codable {
    let productsPage: ProductsPageDTO

    enum CodingKeys: String, CodingKey {
        case productsPage = "item_pages"
    }
}

struct ProductsPageDTO: Codable {
    let content: [ProductDTO]
    let pageable: Pageable
    let totalElements, totalPages: Int
    let last: Bool
    let size, number: Int
    let sort: Sort
    let numberOfElements: Int
    let first, empty: Bool
    
    func toDomain() -> ProductsPage {
        return .init(products: content.map({$0.toDomain()}), totalElements: totalElements, totalPages: totalPages, page: number)
    }
}

struct ProductDTO: Codable {
    let productId: Int
    let brandName: String
    let name, subName: String
    let recentPrice, likeCount, commentCount: Int?
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case productId = "itemId"
        case brandName, name, subName, recentPrice, likeCount, commentCount
        case imageURL = "imageUrl"
    }
    
    func toDomain() -> Product {
        return Product(productId: productId, brandName: brandName, name: name, subName: subName, recentPrice: recentPrice ?? 0, likeCount: likeCount ?? 0, commentCount: commentCount ?? 0, imageUrl: imageURL)
    }
}

struct Pageable: Codable {
    let sort: Sort
    let offset, pageNumber, pageSize: Int
    let unpaged, paged: Bool
}

struct Sort: Codable {
    let empty, sorted, unsorted: Bool
}
