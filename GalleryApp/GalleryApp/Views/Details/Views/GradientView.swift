//
//  GradientView.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 2.02.24.
//

import UIKit

@IBDesignable
final class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor = .clear { didSet { updateColors() } }
    @IBInspectable var endColor: UIColor = .black { didSet { updateColors() } }
    
    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradientLayer
    }()
    
    override class var layerClass: AnyClass { CAGradientLayer.self }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        layer.insertSublayer(gradientLayer, at: 0)
        updateColors()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        updateColors()
    }
    
    private func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
