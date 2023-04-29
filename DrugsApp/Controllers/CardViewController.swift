//
//  CardViewController.swift
//  DrugsApp
//
//  Created by MacBook Air on 28.04.2023.
//

import Foundation
import UIKit
import SnapKit

class CardViewController: UIViewController {
    
    var contentView = CardView()
    var cardViewModel: CardViewModel
    
    init(_ cardViewModel: CardViewModel) {
        self.cardViewModel = cardViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.view.backgroundColor = .white
        contentView.cardNameLabel.text = cardViewModel.titleLabel
        contentView.cardDescriptionLabel.text = cardViewModel.descriptionLabel
        cardViewModel.loadImage(image: contentView.cardImage)
        setupNavBar()
    }
    
    @objc func goToHomeVC() {
        self.navigationController?.popViewController(animated: true)
    }

    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goToHomeVC))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    func setupUI() {
        view.addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(800)
        }
    }
}
