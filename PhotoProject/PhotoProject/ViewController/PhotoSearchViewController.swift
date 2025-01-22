//
//  PhotoSearchViewController.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/17/25.
//

import UIKit
import Kingfisher

final class PhotoSearchViewController: UIViewController {
    
    private let mainView = PhotoSearchView()
    private let order_by = \PhotoSearchViewController.mainView.sortButton.option
    private let group = DispatchGroup()
    typealias CollectionViewWithTag = (collection: UICollectionView , tag: Int)
    private lazy var colorCollection: CollectionViewWithTag = (collection: mainView.colorCollectionView, mainView.colorCollectionView.tag)
    private lazy var searchCollection: CollectionViewWithTag = (collection: mainView.searchCollectionView, mainView.searchCollectionView.tag)
    
    private let searchController = {
        let bar = UISearchController()
        bar.searchBar.placeholder = "키워드 검색"
        bar.automaticallyShowsCancelButton = false
        bar.hidesNavigationBarDuringPresentation = false
        return bar
    }()
    
    private var photoResponseList = PhotoSearchResponse(total: 0, total_pages: 0, results: [])
    private var page = 1
    private let colorList = Color.allCases
    private var selectedColor = Color.black
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SEARCH PHOTO"
        
        searchCollection.collection.delegate = self
        searchCollection.collection.dataSource = self
        searchCollection.collection.prefetchDataSource = self
        colorCollection.collection.delegate = self
        colorCollection.collection.dataSource = self
        colorCollection.collection.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
        
        navigationItem.searchController = searchController
        navigationItem.searchController?.delegate = self
        navigationItem.searchController?.searchBar.delegate = self
        mainView.sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    private func searchPhotos() {
        page = 1
        guard let text = searchController.searchBar.text else { print("SearchBar something wrong"); return }
        NetworkClient.request(PhotoSearchResponse.self, router: .searchPhotos(query: text, page: self.page, per_page: 20, order_by: self[keyPath: self.order_by], color: self.selectedColor)) {
            self.photoResponseList = $0
            self.mainView.searchStatusLabel.text = self.photoResponseList.total == 0 ? "검색 결과가 없습니다." : ""
            self.searchCollection.collection.reloadData()
            
        } failure: { error in
            
        }
    }
    
    @objc func sortButtonTapped(_ sender: SortButton) {
        sender.isSelected.toggle()
        searchPhotos()
    }
    
}


// MARK: - CollectionView Delegate, DataSource


extension PhotoSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return switch collectionView.tag {
        case colorCollection.tag: colorList.count
        case searchCollection.tag: photoResponseList.results.count
        default: 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == colorCollection.tag{
            let item = colorList[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as? ColorCollectionViewCell else { return ColorCollectionViewCell() }
            cell.updateCell(color: item)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { return PhotoCollectionViewCell() }
            let item = photoResponseList.results[indexPath.item]
            cell.updateCell(image: item.urls.small, star: item.likes)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == colorCollection.tag {
            guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell else { return }
            cell.backView.backgroundColor = .systemBlue
            selectedColor = colorList[indexPath.item]
            searchPhotos()
        } else {
            let vc = PhotoDetailsViewController()
            vc.photo = photoResponseList.results[indexPath.item]
            let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            backBarButtonItem.tintColor = .black
            navigationItem.backBarButtonItem = backBarButtonItem
            
            show(vc, sender: self)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell else { return }
        cell.backView.backgroundColor = .white
    }
    
}

// MARK: - Prefetching(Pagination)


extension PhotoSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths, self.photoResponseList.results.count, self.photoResponseList.total_pages, page)
        guard let text = searchController.searchBar.text else { return }
        guard 0...photoResponseList.total_pages ~= page else {
            return
        }
        
        if let item = indexPaths.last?.item {
            if item >= photoResponseList.results.count - 12 {
                self.page += 1
                NetworkClient.request(PhotoSearchResponse.self, router: .searchPhotos(query: text, page: self.page, per_page: 20, order_by: self[keyPath: order_by], color: selectedColor)) {
                    self.photoResponseList.results.append(contentsOf: $0.results)
                    self.searchCollection.collection.reloadData()
                } failure: { error in
                    print(error)
                    
                }
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell else { return }
            cell.photoImageView.kf.cancelDownloadTask() // 이게 되는지 어떻게 확인?
        }
    }
    
    
}


// MARK: - SearchController Delegate


extension PhotoSearchViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchPhotos()
    }
}
