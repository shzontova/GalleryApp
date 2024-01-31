//
//  GalleryViewController.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 29.01.24.
//

import RxSwift
import RxCocoa
import UIKit

final class GalleryViewController: UIViewController {
    
    @IBOutlet private weak var photoCollectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private let viewModel = GalleryViewModel()
    private let bag = DisposeBag()
    
    private var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
}

// MARK: Setup
private extension GalleryViewController {
    
    func setup() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(R.nib.galleryCollectionViewCell)
        
        if let layout = photoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.itemSize = CGSize(width: (view.bounds.width - 30) / 2, height: 200)
        }
    }
}

// MARK: Binding
private extension GalleryViewController {
    
    func bind() {
        viewModel.photos
            .drive(onNext: { [unowned self] images in
                photos = images
                photoCollectionView.reloadData()
            })
            .disposed(by: bag)
    }
}

// MARK: UICollectionViewDelegate
extension GalleryViewController: UICollectionViewDelegate { }

// MARK: UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { photos.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.galleryCollectionViewCell, for: indexPath) else { return UICollectionViewCell() }
        return cell
    }
}
