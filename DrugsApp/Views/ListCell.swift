//
//  ListCell.swift
//  DrugsApp
//
//  Created by MacBook Air on 28.04.2023.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class ListCell: UICollectionViewCell {

    //MARK: - UI Components
    
    private var listImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    
    private var listLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private var listDescription: UITextView = {
        let listDescription = UITextView()
        listDescription.textAlignment = .left
        listDescription.isEditable = false
        listDescription.isScrollEnabled = false
        listDescription.textColor = UIColor(red: 0.683, green: 0.691, blue: 0.712, alpha: 1)
        listDescription.font = .systemFont(ofSize: 12, weight: .regular)
        return listDescription
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        listImage.image = nil
        listLabel.text = ""
        listDescription.text = ""
    }
    
    func configure(using viewModel: ListElement) {
        self.listLabel.text = viewModel.name
        self.listDescription.text = viewModel.description
        self.listImage.sd_setImage(with: URL(string: (Constants.baseURL + viewModel.image).encodeURL))
    }
    
    // MARK: - UI Setup
    
    private func setupElements() {
        contentView.addSubviews([listImage,
                    listLabel,
                    listDescription])
        
        listImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(12)
            make.trailing.equalTo(contentView.snp.trailing).offset(-12)
            make.top.equalTo(contentView.snp.top).offset(12)
            make.height.equalTo(82)
        }
        
        listLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-12)
            make.top.equalTo(listImage.snp.bottom).offset(12)
            make.bottom.equalTo(listDescription.snp.top).offset(-6)
        }

        listDescription.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(12)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.top.equalTo(listLabel.snp.bottom).offset(6)
            make.height.equalTo(85)
        }
    }
    
    func setupCell(cell: ListCell) {
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor(red: 0.282, green: 0.298, blue: 0.298, alpha: 0.15).cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false
    }
 
    
}
