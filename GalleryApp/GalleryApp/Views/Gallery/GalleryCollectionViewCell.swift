//
//  GalleryCollectionViewCell.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 30.01.24.
//

import Kingfisher
import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(photo: Photo) {
        if let url = photo.urls?.url {
            imageView.kf.setImage(with: url)
        }
    }
}
