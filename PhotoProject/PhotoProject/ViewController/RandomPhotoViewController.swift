//
//  RandomPhotoViewController.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/21/25.
//

import UIKit
import Kingfisher

final class RandomPhotoViewController: UIViewController {

    var list = [Photo]()
    let mainView = RandomPhotoView()
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        NetworkClient.request([Photo].self, router: .randomPhoto(count: 10)) {
            self.list = $0
            self.mainView.collectionView.reloadData()
        } failure: { error in
            AlertManager.showErrorAlert(vc: self, message: error.message)
        }
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
}

extension RandomPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = list[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomPhotoCollectionViewCell", for: indexPath) as? RandomPhotoCollectionViewCell else { return RandomPhotoCollectionViewCell() }
        cell.imageView.kf.setImage(with: URL(string: item.urls.raw))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailsViewController()
        let item = list[indexPath.item]
        vc.photo = item
        NetworkClient.request(PhotoStatisticsResponse.self, router: .photoStatics(id: item.id)) {
            vc.response = $0
            let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            backBarButtonItem.tintColor = .black
            self.navigationItem.backBarButtonItem = backBarButtonItem
            self.show(vc, sender: self)
        } failure: { error in
            AlertManager.showErrorAlert(vc: self, message: error.message)
        }

    }
}
