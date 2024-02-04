//
//  ActivityIndicator.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 1.02.24.
//

import Kingfisher

class ActivityIndicator: Indicator {
    
    var view: IndicatorView

    init() {
        let activityView = UIActivityIndicatorView(style: .medium)
        activityView.color = .white
        view = activityView
        view.center = view.superview?.center ?? CGPoint.zero
    }

    func startAnimatingView() {
        (view as? UIActivityIndicatorView)?.startAnimating()
    }

    func stopAnimatingView() {
        (view as? UIActivityIndicatorView)?.stopAnimating()
    }
}
