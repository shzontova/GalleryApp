//
//  GalleryViewController.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 29.01.24.
//

import RxCocoa
import RxSwift
import UIKit

final class GalleryViewController: UIViewController {
    
    enum Constants {
        static let screenWidth = UIScreen.main.fixedCoordinateSpace.bounds.size.width
    }
    
    @IBOutlet private weak var photoCollectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private let viewModel = GalleryViewModel()
    private let bag = DisposeBag()
    private let reloadSubject = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadSubject.onNext(())
    }
}

// MARK: Setup
private extension GalleryViewController {
    
    func setup() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        photoCollectionView.register(R.nib.galleryCollectionViewCell)
        photoCollectionView.rx.setDelegate(self).disposed(by: bag)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 5, left: 10, bottom: 5, right: 10)
        photoCollectionView.collectionViewLayout = layout
    }
}

// MARK: Binding
private extension GalleryViewController {
    
    func bind() {
        viewModel.photoRelay
            .bind(to: photoCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.galleryCollectionViewCell.identifier,
                                                   cellType: GalleryCollectionViewCell.self)) { _, photo, cell in
                cell.configure(photo: photo)
            }.disposed(by: bag)
        
        photoCollectionView.rx.modelSelected(Photo.self)
            .subscribe(onNext: { [unowned self] selectedPhoto in
                navigateToDetails(photo: selectedPhoto)
            }).disposed(by: bag)
        
        photoCollectionView.rx.willDisplayCell
            .subscribe(onNext: { [unowned self] _, indexPath in
                let items = viewModel.photoRelay.value.count
                if indexPath.item == items - 2 {
                    viewModel.loadPhotos()
                }
            }).disposed(by: bag)
        
        reloadSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                photoCollectionView.reloadData()
            }).disposed(by: bag)
    }
}

// MARK: Private
private extension GalleryViewController {
    
    func updateCoolectionView() {
        DispatchQueue.main.async {
            self.photoCollectionView.reloadData()
        }
    }
    
    func navigateToDetails(photo: Photo) {
        if let detailsViewController = R.storyboard.details.detailsViewController() {
            detailsViewController.modalPresentationStyle = .fullScreen
            detailsViewController.modalTransitionStyle = .crossDissolve
            detailsViewController.configure(photo: photo)
            present(detailsViewController, animated: true, completion: nil)
        }
    }
}

// MARK: UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.galleryCollectionViewCell, for: indexPath) != nil {
            let width = (Constants.screenWidth - 30) / 2
            let height = Constants.screenWidth / 3
            return CGSize(width: width, height: height)
        }
        
        return .zero
    }
}
