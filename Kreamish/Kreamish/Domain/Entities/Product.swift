//
//  Product.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/09.
//

import Foundation

struct Product: Codable {
    let productId: Int
    let brandName: String
    let name: String
    let subName: String
    let recentPrice: Int
    let likeCount: Int
    let commentCount: Int
    let imageUrl: String
}
