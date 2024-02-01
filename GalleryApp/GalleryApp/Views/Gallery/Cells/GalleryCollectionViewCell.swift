//
//  GalleryCollectionViewCell.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 30.01.24.
//

import Kingfisher
import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var infoView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }

    func configure(photo: Photo) {
        if let url = URL(string: photo.urls?.url ?? "") {
            imageView.kf.indicatorType = .custom(indicator: ActivityIndicator())
            imageView.kf.setImage(with: url)
        }
        nameLabel.text = photo.user?.name
    }
}

// - MARK: Setup
private extension GalleryCollectionViewCell {
    
    func setup() {
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = contentView.bounds.height * 0.1
        infoView.addGradient(startColor: .black, endColor: .clear)
    }
}
