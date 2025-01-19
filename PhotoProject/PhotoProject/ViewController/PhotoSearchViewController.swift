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
        return bar
    }()
    
    
    var photoResponseList = [Photo]() {
        didSet {
            mainView.collectionView.reloadData()
            print(photoResponseList)
        }
    }
    
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
    }

    func searchPhotos(text: String) {
        NetworkManager.shared.fetchSearchPhotos(query: text, page: 1, per_page: 10, order_by: .latest, color: .black) {
            self.photoResponseList = $0
        }
    }

}


// MARK: - CollectionView Delegate, DataSource


extension PhotoSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoResponseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = photoResponseList[indexPath.item]
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
        //        print(#function, indexPaths, self.item?.items.count, self.item?.start)
        guard let text = navigationItem.title else { return }
//        guard enableStartRange ~= photoResponseList.start else {
//            print("현재가 마지막 페이지임")
//            return
//        }
        print(indexPaths[0].item, photoResponseList.count - 8)
//        if NetworkManager.shared.status == .satisfied {
            if indexPaths[0].item >= photoResponseList.count - 8 {
//                self.item?.start += 30
                NetworkManager.shared.fetchSearchPhotos(query: text, page: 1, per_page: 10, order_by: .latest, color: .blue) {
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
