
import Combine
import Foundation

class ProductDetailViewModel {
    let productId: Int
    @Published var productDetail: ProductDetail?
    
    init(productId: Int) {
        self.productId = productId
    }
    
}
