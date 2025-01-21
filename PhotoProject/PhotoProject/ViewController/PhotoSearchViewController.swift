//
//  PhotoSearchViewController.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/17/25.
//

import UIKit
import Kingfisher

final class PhotoSearchViewController: UIViewController {
    
    let mainView = PhotoSearchView()
    let buttonStatus = \PhotoSearchViewController.mainView.sortButton.option
    typealias CollectionViewWithTag = (collection: UICollectionView , tag: Int)
    private lazy var optionCollection: CollectionViewWithTag = (collection: mainView.optionCollectionView, mainView.optionCollectionView.tag)
    private lazy var searchCollection: CollectionViewWithTag = (collection: mainView.searchCollectionView, mainView.searchCollectionView.tag)

    private let searchController = {
        let bar = UISearchController()
        bar.searchBar.placeholder = "키워드 검색"
        bar.automaticallyShowsCancelButton = false
        bar.hidesNavigationBarDuringPresentation = false
        return bar
    }()
    
    var photoResponseList = PhotoSearchResponse(total: 0, total_pages: 0, results: []) {
        didSet {
            searchCollection.collection.reloadData()
        }
    }
    
    var page = 1
    let colorList = Color.allCases
    var selectedColor = Color.black {
        didSet {
            print(selectedColor)
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SEARCH PHOTO"
        
        searchCollection.collection.delegate = self
        searchCollection.collection.dataSource = self
        searchCollection.collection.prefetchDataSource = self
        optionCollection.collection.delegate = self
        optionCollection.collection.dataSource = self
        optionCollection.collection.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
        
        navigationItem.searchController = searchController
        navigationItem.searchController?.delegate = self
        navigationItem.searchController?.searchBar.delegate = self
        mainView.sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    func searchPhotos() {
        guard let text = searchController.searchBar.text else { print("SearchBar something wrong"); return }
        
        NetworkClient.request(PhotoSearchResponse.self, router: .searchPhotos(query: text, page: page, per_page: 20, order_by: mainView.sortButton.option, color: selectedColor)) {
            print("응담완")
            self.photoResponseList = $0
            self.mainView.searchStatusLabel.text = $0.total == 0 ? "검색 결과가 없습니다." : ""
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
        case optionCollection.tag: colorList.count
        case searchCollection.tag: photoResponseList.results.count
        default: 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == optionCollection.tag{
            let item = colorList[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as? ColorCollectionViewCell else { return ColorCollectionViewCell() }
            cell.updateCell(color: item)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { return PhotoCollectionViewCell()}
            let item = photoResponseList.results[indexPath.item]
            cell.updateCell(image: item.urls.raw, star: item.likes)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == optionCollection.tag {
            guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell else { return }
            cell.backView.backgroundColor = .systemBlue
            selectedColor = colorList[indexPath.item]
            
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
            print("현재가 마지막 페이지임")
            return
        }
        //        if NetworkManager.shared.status == .satisfied {
        if let item = indexPaths.last?.item {
            if item >= photoResponseList.results.count - 8 {
                self.page += 1
                NetworkClient.request(PhotoSearchResponse.self, router: .searchPhotos(query: text, page: 1, per_page: 20, order_by: mainView.sortButton.option, color: selectedColor)) {
                    self.photoResponseList.results.append(contentsOf: $0.results)
                } failure: { error in
                }
            }
        }
        //        }
        //    else {
        //            present(AlertManager.simpleAlert(title: "네트워크 연결 불가", message: "와이파이나 데이터 연결을 확인해주세요."), animated: true)
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell else { return }
            cell.photoImageView.kf.cancelDownloadTask() // 이게 되는지 어떻게 확인?
        }
        print(#function)
    }
    

}


// MARK: - SearchController Delegate


extension PhotoSearchViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        searchPhotos()
    }
}
