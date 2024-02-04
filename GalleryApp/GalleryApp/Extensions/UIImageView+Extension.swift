//
//  UIImageView+Extension.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 4.02.24.
//

import Kingfisher
import UIKit

extension UIImageView {
    
    func loadImage(urlString: String) {
        let options: KingfisherOptionsInfo = [
            .transition(.fade(0.2)),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage
        ]

        if let url = URL(string: urlString) {
            self.kf.indicatorType = .custom(indicator: ActivityIndicator())
            self.kf.setImage(with: url, 
                             options: options,
                             completionHandler: { result in
                                     switch result {
                                     case .failure:
                                         self.image = R.image.notLoading()
                                     case .success: break
                                     }
                                 })
        }
    }
}
