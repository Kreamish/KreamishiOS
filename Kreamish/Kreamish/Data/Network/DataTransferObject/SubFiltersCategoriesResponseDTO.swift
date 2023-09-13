
import Foundation

struct SubFiltersCategoriesResponseDTO: Codable {
    let success: Bool
    let response: [SubFilterOfCategory]
    let error: String?
    
    func toDomain() -> [SubFilter] {
        return response.map { $0.toDomain() }
    }
    
    struct SubFilterOfCategory: Codable {
        let subFilterId: Int?
        let subFilterName: String
        let filterItems: [FilterItemOfCategory]
        
        enum CodingKeys: String, CodingKey {
            case subFilterId = "category_id"
            case subFilterName = "category_name"
            case filterItems = "category_detail_list"
        }
        
        func toDomain() -> SubFilter {
            return .init(subFilterId: subFilterId, subFilterName: subFilterName, filterItems: filterItems.map{$0.toDomain()})
        }
        
        struct FilterItemOfCategory: Codable {
            let filterItemId: Int
            let filterItemName: String
            
            enum CodingKeys: String, CodingKey {
                case filterItemId = "category_detail_id"
                case filterItemName = "category_detail_name"
            }
            
            func toDomain() -> FilterItem {
                return .init(filterItemId: filterItemId, filterItemName: filterItemName)
            }
        }

    }
    
}
