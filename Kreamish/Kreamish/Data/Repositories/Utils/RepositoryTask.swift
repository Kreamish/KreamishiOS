//
//  RepositoryTask.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/24.
//

import Combine
import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
