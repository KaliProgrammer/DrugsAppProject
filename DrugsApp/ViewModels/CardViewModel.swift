//
//  CardViewModel.swift
//  DrugsApp
//
//  Created by MacBook Air on 28.04.2023.
//

import Foundation
import UIKit

protocol CardViewModelProtocol {
    func loadImage(image: UIImageView)
}

class CardViewModel {
    let list: ListElement
    init(list: ListElement) {
        self.list = list
    }
    
    func loadImage(image: UIImageView) {
        if let listURL = URL(string: (Constants.baseURL + list.image).encodeURL) {
            image.sd_setImage(with: listURL)
        }
    }
    //MARK: - Computed Property

    var titleLabel: String {
      return list.name
    }
    
    var descriptionLabel: String {
        return list.description
    }
}


