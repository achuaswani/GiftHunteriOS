//
//  ImageLoader.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/28/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL?

    init(url: URL?) {
        self.url = url
    }
    private var cancellable: AnyCancellable?

    deinit {
        cancellable?.cancel()
    }

    func load() {
        guard let url = url else {
            cancellable?.cancel()
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map {
                UIImage(data: $0.data)

        }
        .replaceError(with: nil)
        .receive(on: DispatchQueue.main)
        .assign(to: \.image, on: self)
    }

    func cancel() {
        cancellable?.cancel()
    }
}
