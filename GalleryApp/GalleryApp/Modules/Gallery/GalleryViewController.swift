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
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: Setup
private extension GalleryViewController {
    
    func setupCollectionView() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
}

// MARK: UICollectionViewDelegate
extension GalleryViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
}
