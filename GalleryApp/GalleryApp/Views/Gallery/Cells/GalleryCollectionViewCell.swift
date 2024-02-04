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
    @IBOutlet private weak var likeImageView: UIImageView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var infoView: GradientView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.kf.cancelDownloadTask()
    }

    func configure(photo: Photo) {
        imageView.loadImage(urlString: photo.urls?.url ?? "")
        nameLabel.text = photo.user?.name
        likeImageView.isHidden = !DatabaseManager.isFavorite(photo: photo)
    }
}

// - MARK: Setup
private extension GalleryCollectionViewCell {
    
    func setup() {
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = contentView.bounds.height * 0.1
    }
}
