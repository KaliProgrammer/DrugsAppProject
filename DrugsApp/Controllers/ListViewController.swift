//
//  ListViewController.swift
//  DrugsApp
//
//  Created by MacBook Air on 28.04.2023.
//

import UIKit
import SnapKit
import Combine

protocol NetworkProtocol {
    func checkNetwork()
}

extension NetworkProtocol {
    func checkNetwork(in vc: UIViewController) {
        if !NetworkMonitor.shared.isConnected {
            let alert = UIAlertController(title: "Нет интернета", message: "Убедитесь, что вы подключены к Wi-Fi", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(action)
            vc.present(alert, animated: true)
        }
    }
}

class ListViewController: UIViewController {
    
    var list: [ListViewModel] = .init()
    let viewModel = ListViewModel()
    
    var cancellable = Set<AnyCancellable>()
    
     lazy var navigationCollection: UICollectionView = {
        let screenSize = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.register(ListCell.self, forCellWithReuseIdentifier: ListCell.reuseIdentifier)
        return collection
    }()
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.backgroundColor = UIColor.theme.navBarColor
        return search
    }()
    
    private lazy var chevronImage: UIImageView = {
        let chevronImage = UIImageView()
        chevronImage.image = UIImage(systemName: "chevron.left")
        chevronImage.tintColor = .white
        return chevronImage
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchBar.delegate = self
        searchBar.sizeToFit()

        setupElements()
        
        viewModel.getData(keyword: searchBar.text!)
        
        viewModel.drugsSubject.sink { [weak self] _ in
            self?.navigationCollection.reloadData()
        }
        .store(in: &cancellable)

        setupNavBar()
        showSearchBarButton(shouldShow: true)
    }
    
    @objc func handleSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }

    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchBar))

        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func setupElements() {
        view.addSubview(navigationCollection)
        navigationCollection.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(15)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
        viewModel.getData(keyword: "")
    }
}


