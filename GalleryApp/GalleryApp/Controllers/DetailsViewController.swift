//
//  DetailsViewController.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 1.02.24.
//

import RxSwift
import RxCocoa
import UIKit

final class DetailsViewController: UIViewController {
    
    private let viewModel = DetailsViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
