//
//  FilterCollectionViewCell.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/06/06.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    static var id: String {  // computed property. 메모리 공간 가지지 않음.
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    
}
