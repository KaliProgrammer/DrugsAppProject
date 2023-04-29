//
//  ListViewController+Extension.swift
//  DrugsApp
//
//  Created by MacBook Air on 28.04.2023.
//

import Foundation
import UIKit

extension ListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.drugsSubject.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.reuseIdentifier, for: indexPath) as? ListCell else {
            return UICollectionViewCell()
        }
                cell.setupCell(cell: cell)
                let viewModel = viewModel.drugsSubject.value[indexPath.row]
                cell.configure(using: viewModel)
                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 171, height: 296)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let catalog = viewModel.drugsSubject.value[indexPath.row]
        let viewModel = CardViewModel(list: catalog)
        let vc = CardViewController(viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.willDisplay(itemAtIndex: indexPath.row)
    }
}
