//
//  HeroHeaderUIView.swift
//  NetflixClone
//
//  Created by Gabriel Pereira on 06/01/24.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let downloadButton:UIButton = {
        let buttonView = UIButton()
        
        buttonView.setTitle("Download", for: .normal)
        buttonView.layer.borderColor = UIColor.white.cgColor
        buttonView.layer.borderWidth = 1
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonView
    }()
    
    private let playButton:UIButton = {
        let buttonView = UIButton()
        
        buttonView.setTitle("Play", for: .normal)
        buttonView.layer.borderColor = UIColor.white.cgColor
        buttonView.layer.borderWidth = 1
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonView
    }()
    
    private let heroImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "poster")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
    
    private func applyConstraints(){
        let playButtonWidthConstant:CGFloat = 100
        let playButtonPositionConstant = (bounds.width / 2) - playButtonWidthConstant
        let downloadButtonPositionConstant = (bounds.width / 2) - 110
        
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant:playButtonPositionConstant),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: playButtonWidthConstant)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -downloadButtonPositionConstant),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    private func addGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor,
        ]
        gradientLayer.frame = bounds
        
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
