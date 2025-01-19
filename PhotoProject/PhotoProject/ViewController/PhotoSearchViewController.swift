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
    
    private let searchBar = {
        let bar = UISearchController()
        bar.searchBar.placeholder = "키워드 검색"
        bar.automaticallyShowsCancelButton = false
        bar.hidesNavigationBarDuringPresentation = false
        return bar
    }()
    
    var photoResponseList = PhotoSearchResponse(total: 0, total_pages: 1, results: []) {
        didSet {
            mainView.collectionView.reloadData()
            print(photoResponseList)
        }
    }
    
    var page = 1
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SEARCH PHOTO"
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        //        mainView.collectionView.prefetchDataSource = self
        navigationItem.searchController = searchBar
        navigationItem.searchController?.delegate = self
        navigationItem.searchController?.searchBar.delegate = self
        mainView.sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    func searchPhotos(text: String) {
        if page <= photoResponseList.total_pages {
            NetworkManager.shared.fetchSearchPhotos(query: text, page: page, order_by: .latest, color: .black) {
                self.photoResponseList = $0
            }
        }
    }
    
    @objc func sortButtonTapped(_ sender: SortButton) {
        sender.isSelected.toggle()
//        sender.option.fetchString
    }
    
}


// MARK: - CollectionView Delegate, DataSource


extension PhotoSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoResponseList.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = photoResponseList.results[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            return PhotoCollectionViewCell()
        }
        cell.updateCell(image: item.urls.raw)
        return cell
    }
    
    
}

// MARK: - Prefetching(Pagination)


extension PhotoSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths, self.photoResponseList.results.count)
        guard let text = navigationItem.title else { return }
        //        guard enableStartRange ~= photoResponseList.start else {
        //            print("현재가 마지막 페이지임")
        //            return
        //        }
        //        if NetworkManager.shared.status == .satisfied {
        if indexPaths[0].item >= photoResponseList.results.count - 8 {
            //                self.item?.start += 30
            NetworkManager.shared.fetchSearchPhotos(query: text, page: 2, order_by: .latest, color: .blue) {
                let fetchedItems = $0
                //                    self.item?.items.append(contentsOf: fetchedItems.items)
                //                    self.item?.start = fetchedItems.start
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
        searchPhotos(text: searchBar.text!)
    }
}
