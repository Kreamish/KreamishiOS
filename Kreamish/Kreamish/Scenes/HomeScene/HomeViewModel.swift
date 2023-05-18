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
}

typealias HomeViewModelProtocol = HomeViewModelInput & HomeViewModelOutput

final class HomeViewModel: HomeViewModelProtocol {
    var widthRatioPublisher: AnyPublisher<Double?, Never> {
        self.$widthRatio.eraseToAnyPublisher()
    }
    @Published var widthRatio: Double?
    @Published var indicatorViewLeftOffsetRatio: Double?
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
}
