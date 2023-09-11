//
//  ProductDetailViewModel.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/09/04.
//
import Combine
import Foundation

class ProductDetailViewModel {
    let productId: Int
    @Published var productDetail: ProductDetail?
    
    init(productId: Int) {
        self.productId = productId
    }
    
}
