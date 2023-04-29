//
//  ListViewModel.swift
//  DrugsApp
//
//  Created by MacBook Air on 28.04.2023.
//

import UIKit
import Foundation
import Combine

protocol ListViewModelProtocol {
    func getData(keyword: String)
    func pageDidLoad(data: [ListElement])
    func willDisplay(itemAtIndex index: Int)
    func requestNewPage()
}

class ListViewModel: ListViewModelProtocol {

    private enum Constants {
        static let pageItemsLimit = 26
    }

    let objectNetworkService = NetworkService()

    var elements: [ListElement] = []

    var drugsSubject = CurrentValueSubject<[ListElement], Never>([])
    
    var cancellable = Set<AnyCancellable>()

    //MARK: - Variables for pagination
    
    private var offset = 0

    private var isNeedToRequestMore = true
    private var searchKeyword: String = ""
    private var maxRequestedIndex: Int = -1
    private var isLoading: Bool = false
    private var newPageShouldBeRequested: Bool = false

    func getData(keyword: String) {
        do {
            if self.searchKeyword != keyword {
                isNeedToRequestMore = true
                elements = []
                maxRequestedIndex = -1
                newPageShouldBeRequested = false
                offset = 0
                cancellable.forEach({ $0.cancel() })
            }
            self.searchKeyword = keyword

            if isNeedToRequestMore {
                let data = try objectNetworkService.getList(by: self.searchKeyword, limit: Constants.pageItemsLimit, offset: offset)
                data
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .receive(on: RunLoop.main)
                    .map { element -> [ListElement] in
                        self.pageDidLoad(data: element)
                        return element
                    }
                    .replaceError(with: [])
                    .sink(receiveValue: { [weak self] element in
                        guard let self else {
                            return
                        }
                        self.elements.append(contentsOf: element)
                        self.drugsSubject.send(self.elements)
                        print(element)
                    })
                    .store(in: &cancellable)
            }
        } catch let error {
            print("\(error) Error")
        }
    }
    
    //Pagination

    func pageDidLoad(data: [ListElement]) {
        if data.isEmpty {
            self.isNeedToRequestMore = false
        }
        self.isLoading = false
        self.offset += self.offset + data.count
        if newPageShouldBeRequested {
            requestNewPage()
        }
    }

    func willDisplay(itemAtIndex index: Int) {
        guard index + Constants.pageItemsLimit > maxRequestedIndex else {
            newPageShouldBeRequested = false
            return
        }

        guard isLoading == false else {
            newPageShouldBeRequested = true
            return
        }
        requestNewPage()
    }

    func requestNewPage() {
        isLoading = true
        maxRequestedIndex = elements.count + Constants.pageItemsLimit
        getData(keyword: searchKeyword)
    }
}
