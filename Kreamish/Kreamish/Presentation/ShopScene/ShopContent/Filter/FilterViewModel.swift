
import Combine
import Foundation

class FilterViewModel {
    private let getSubFiltersUseCase: GetSubFiltersUseCase
    private var subFiltersLoadTask: Cancellable?
    
    // 하드코딩.F
    let filterList: [Filter] = [Filter(filterId: Constants.FILTER_CATEGORIES_ID, name: Constants.FILTER_CATEGORIES_NAME_KOR), Filter(filterId: Constants.FILTER_BRANDS_ID, name: Constants.FILTER_BRANDS_NAME_KOR)]
    // 하드코딩.

    @Published var currentCategoriesSubFilterList: [SubFilter] = []
    @Published var currentBrandsSubFilterList: [SubFilter] = []
    
    init(getSubFiltersUseCase: GetSubFiltersUseCase) {
        self.getSubFiltersUseCase = getSubFiltersUseCase
    }
    
    func getSubFilters(filterId: Int) {
        load(filterId: filterId)
    }
    
    func load(filterId: Int) {
        subFiltersLoadTask = getSubFiltersUseCase.execute(parentFilterId: filterId) { result in
            switch result {
            case .success(let subFilters):
                switch filterId {
                case Constants.FILTER_CATEGORIES_ID:
                    self.currentCategoriesSubFilterList = subFilters
                case Constants.FILTER_BRANDS_ID:
                    self.currentBrandsSubFilterList = subFilters
                default:
                    print("the filterId doesn't exist")
                }
            case .failure(let error):
                self.currentCategoriesSubFilterList = [SubFilter(subFilterId: 1, subFilterName: "error신발", filterItems: [FilterItem(filterItemId: 1, filterItemName: "스니커즈"), FilterItem(filterItemId: 2, filterItemName: "구두"), FilterItem(filterItemId: 3, filterItemName: "샌들/슬리퍼"), FilterItem(filterItemId: 4, filterItemName: "부츠")]), SubFilter(subFilterId: 2, subFilterName: "error아우터", filterItems: [FilterItem(filterItemId: 1, filterItemName: "자켓"), FilterItem(filterItemId: 2, filterItemName: "아노락"), FilterItem(filterItemId: 3, filterItemName: "코트"), FilterItem(filterItemId: 4, filterItemName: "패딩")]), SubFilter(subFilterId: 3, subFilterName: "error상의", filterItems: [FilterItem(filterItemId: 1, filterItemName: "반팔 티셔츠"), FilterItem(filterItemId: 2, filterItemName: "긴팔 티셔츠"), FilterItem(filterItemId: 3, filterItemName: "가디건"), FilterItem(filterItemId: 4, filterItemName: "셔츠")]), SubFilter(subFilterId: 4, subFilterName: "error하의", filterItems: [FilterItem(filterItemId: 1, filterItemName: "바지"), FilterItem(filterItemId: 2, filterItemName: "반바지")])]
                self.currentBrandsSubFilterList = [SubFilter(subFilterId: 1, subFilterName: "errorA", filterItems: [FilterItem(filterItemId: 1, filterItemName: "Ad"), FilterItem(filterItemId: 2, filterItemName: "구두"), FilterItem(filterItemId: 3, filterItemName: "샌들/슬리퍼"), FilterItem(filterItemId: 4, filterItemName: "부츠")]), SubFilter(subFilterId: 2, subFilterName: "error아우터", filterItems: [FilterItem(filterItemId: 1, filterItemName: "자켓"), FilterItem(filterItemId: 2, filterItemName: "아노락"), FilterItem(filterItemId: 3, filterItemName: "코트"), FilterItem(filterItemId: 4, filterItemName: "패딩")]), SubFilter(subFilterId: 3, subFilterName: "error상의", filterItems: [FilterItem(filterItemId: 1, filterItemName: "반팔 티셔츠"), FilterItem(filterItemId: 2, filterItemName: "긴팔 티셔츠"), FilterItem(filterItemId: 3, filterItemName: "가디건"), FilterItem(filterItemId: 4, filterItemName: "셔츠")]), SubFilter(subFilterId: 4, subFilterName: "error하의", filterItems: [FilterItem(filterItemId: 1, filterItemName: "바지"), FilterItem(filterItemId: 2, filterItemName: "반바지")])]
                print(error)
            }
        }
    }
}
