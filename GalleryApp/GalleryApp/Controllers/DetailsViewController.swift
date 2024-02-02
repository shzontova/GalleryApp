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
    @IBOutlet private weak var detailsView: UIView!
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
        detailsView.addGradient(startColor: .clear, endColor: .black)
    }
    
   func setupSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeGesture.direction = .left
        view.addGestureRecognizer(swipeGesture)
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

// MARK: Private
private extension DetailsViewController {
    
    @objc private func handleSwipe() {
        
    }
}
