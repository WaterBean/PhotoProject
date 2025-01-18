//
//  PhotoSearchViewController.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/17/25.
//

import UIKit

final class PhotoSearchViewController: UIViewController {

    let mainView = PhotoSearchView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SEARCH PHOTO"
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }


}


extension PhotoSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            return PhotoCollectionViewCell()
        }
        cell.photoImageView.image = UIImage(systemName: "1.circle")
        return cell
    }
    
    
}
