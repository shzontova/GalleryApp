//
//  DetailsViewController.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 1.02.24.
//

import Kingfisher
import RxSwift
import RxCocoa
import UIKit

final class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var detailsView: GradientView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private var swipeRecognizer: UISwipeGestureRecognizer!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var desriptionLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    
    private let viewModel = DetailsViewModel()
    private let bag = DisposeBag()
    
    private var photo: Photo?
    
    func configure(photo: Photo) {
        self.photo = photo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
}

// MARK: Setup
private extension DetailsViewController {
    
    func setup() {
        if let url = URL(string: photo?.urls?.url ?? "") {
            photoImageView.kf.setImage(with: url)
        }
        nameLabel.text = photo?.user?.name
        desriptionLabel.text = photo?.description
    }
}

// MARK: Binding
private extension DetailsViewController {
    
    func bind() {
        backButton.rx.tap.asDriver().drive(onNext: { [unowned self]_ in
            dismiss(animated: true)
        }).disposed(by: bag)
    }
}
