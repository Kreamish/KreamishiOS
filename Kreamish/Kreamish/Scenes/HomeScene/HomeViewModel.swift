//
//  HomeViewModel.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/17.
//
import Combine
import Foundation

protocol HomeViewModelInput {
    func computeWidthRatio(
        _ contentSizeWidth: Double,
        _ contentInsetLeft: CGFloat,
        _ contentInsetRight: CGFloat,
        _ showingWidth: Double
    )
}

protocol HomeViewModelOutput {
    var widthRatioPublisher: AnyPublisher<Double?, Never> { get }
    var leftOffsetRatioPublisher: AnyPublisher<Double?, Never> { get }
}

typealias HomeViewModelProtocol = HomeViewModelInput & HomeViewModelOutput

final class HomeViewModel: HomeViewModelProtocol {
    var widthRatioPublisher: AnyPublisher<Double?, Never> {
        self.$widthRatio.eraseToAnyPublisher()
    }
    var leftOffsetRatioPublisher: AnyPublisher<Double?, Never> {
        self.$leftOffsetRatio.eraseToAnyPublisher()
    }
    @Published var widthRatio: Double?
    @Published var leftOffsetRatio: Double?
}
extension HomeViewModel {
    func computeWidthRatio(
        _ contentSizeWidth: Double,
        _ contentInsetLeft: CGFloat,
        _ contentInsetRight: CGFloat,
        _ showingWidth: Double
    ) {
        let allContentSizeWidth = contentSizeWidth + contentInsetLeft + contentInsetRight
        let widthRatio = showingWidth / allContentSizeWidth
        self.widthRatio = widthRatio
    }
    func computeLeftOffsetRatio(
        _ contentSizeWidth: Double,
        _ contentOffsetX: Double,
        _ contentInsetLeft: CGFloat,
        _ contentInsetRight: CGFloat
    ) {
        let leftOffset = contentOffsetX + contentInsetLeft
        let entireWidth = contentSizeWidth + contentInsetLeft + contentInsetRight
        let leftOffsetRatio = leftOffset / entireWidth
        self.leftOffsetRatio = leftOffsetRatio
    }
}
