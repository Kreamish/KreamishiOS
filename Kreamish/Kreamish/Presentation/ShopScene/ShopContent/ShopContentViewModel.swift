
import Combine
import Foundation

class ShopContentViewModel: ObservableObject {
    @Published var trendingKeywordList: [TrendingKeyword] = []
    @Published var productList: [Product] = []
    @Published var filterList: [Filter] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchTrendingKeywordList() {
        
    }
    
    func fetchProductList() {
        
    }
    
    func fetchFilterList() {
        
    }
}
