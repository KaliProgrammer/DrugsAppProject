//
//  CardView.swift
//  DrugsApp
//
//  Created by MacBook Air on 28.04.2023.
//

import Foundation
import UIKit
import SnapKit

class CardView: UIView {
    
    //MARK: - UI Components

    lazy var cardImage: UIImageView = {
        let cardView = UIImageView()
        cardView.layer.cornerRadius = 12
        cardView.layer.masksToBounds = true
        return cardView
    }()
    
    lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.backgroundColor = .white
        return label
    }()
    
    lazy var cardDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(red: 0.683, green: 0.691, blue: 0.712, alpha: 1)
        return label
    }()
    
    lazy var leftImage: UIImageView = {
        let cardView = UIImageView()
        cardView.layer.cornerRadius = 12
        cardView.layer.masksToBounds = true
        cardView.image = UIImage(named: "leftImage")
        return cardView
    }()
    
    lazy var ratingImage: UIImageView = {
        let cardView = UIImageView()
        cardView.layer.cornerRadius = 12
        cardView.layer.masksToBounds = true
        cardView.image = UIImage(named: "rate")
        return cardView
    }()
    
    lazy var locationImage: UIImageView = {
        let cardView = UIImageView()
        cardView.layer.masksToBounds = true
        cardView.image = UIImage(named: "location")
        return cardView
    }()
    
    private lazy var whereToBuyButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapToBuy), for: .touchUpInside)
        button.setTitle("Где купить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 1
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.borderColor = CGColor(red: 174, green: 176, blue: 182, alpha: 1)
        return button
    }()
    
    @objc func tapToBuy() {
        
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI Function
    
    func setupElements() {
        addSubviews([cardImage,
                     cardNameLabel,
                     cardDescriptionLabel,
                     leftImage,
                     ratingImage,
                     whereToBuyButton])
        whereToBuyButton.addSubview(locationImage)
        
        locationImage.snp.makeConstraints { make in
            make.leading.equalTo(whereToBuyButton.snp.leading).offset(127)
            make.width.equalTo(15)
            make.top.equalTo(whereToBuyButton.snp.top).offset(9)
            make.height.equalTo(17.5)
        }
        
        cardImage.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(127)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-131)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(124)
            make.height.equalTo(183)
        }
        
        cardNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(14)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-170)
            make.top.equalTo(cardImage.snp.bottom).offset(32)
            make.height.equalTo(28)
        }
        
        cardDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(14)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-33)
            make.top.equalTo(cardNameLabel.snp.bottom).offset(8)
            make.bottom.equalTo(whereToBuyButton.snp.top).offset(-12)
        }
        
        leftImage.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(25.15)
            make.width.equalTo(28.67)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(126.33)
            make.height.equalTo(27.33)
        }
        
        ratingImage.snp.makeConstraints { make in
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-35.67)
            make.width.equalTo(28.67)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(126.33)
            make.height.equalTo(27.33)
        }
        
        whereToBuyButton.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.height.equalTo(34)
        }
    }
}
