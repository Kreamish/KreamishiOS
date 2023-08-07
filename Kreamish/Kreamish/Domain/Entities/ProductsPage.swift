//
//  ProductPage.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/08/06.
//

import Foundation

struct ProductsPage: Codable {
    let products: [Product]
    let totalElements: Int
    let totalPages: Int
    let page: Int
}
