//
//  SearchBar+Extension.swift
//  DrugsApp
//
//  Created by MacBook Air on 29.04.2023.
//

import Foundation
import UIKit

extension ListViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getData(keyword: searchBar.text!)
        viewModel.drugsSubject.sink { [weak self] value in
            guard let self = self else {
                return
            }
            self.navigationCollection.reloadData()
        }
        .store(in: &cancellable)
    }
}
