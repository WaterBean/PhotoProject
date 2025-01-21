//
//  TrendingPhotosByTopicViewController.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/19/25.
//

import UIKit
import Kingfisher

final class TrendingPhotosByTopicViewController: UIViewController {

    var photoList1 = [Photo]() {
        didSet {
            mainView.goldCollection.reloadData()
        }
    }
    var photoList2 = [Photo](){
        didSet {
            mainView.busiCollection.reloadData()
        }
    }
    var photoList3 = [Photo](){
        didSet {
            mainView.archCollection.reloadData()
        }
    }
    
    
    let mainView = TrendingPhotosByTopicView()
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkClient.request([Photo].self, router: .topicPhotos(topic: Topic.goldenHour.rawValue, page: 1, per_page: 10)) {
            self.photoList1 = $0
        } failure: { error in
            
        }
        
        NetworkClient.request([Photo].self, router: .topicPhotos(topic: Topic.businessWork.rawValue, page: 1, per_page: 10)) {
            self.photoList2 = $0
        } failure: { error in
            
        }
        
        NetworkClient.request([Photo].self, router: .topicPhotos(topic: Topic.architectureInterior.rawValue, page: 1, per_page: 10)) {
            self.photoList3 = $0
        } failure: { error in
            
        }

        mainView.goldCollection.delegate = self
        mainView.goldCollection.dataSource = self
        mainView.busiCollection.delegate = self
        mainView.busiCollection.dataSource = self
        mainView.archCollection.delegate = self
        mainView.archCollection.dataSource = self
     
        navigationItem.title = "OUR TOPIC"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

    }
        
}


extension TrendingPhotosByTopicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = switch collectionView.tag {
        case 0: photoList1.count
        case 1: photoList2.count
        case 2: photoList3.count
        default: 0
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = switch collectionView.tag {
        case 0 : photoList1[indexPath.row]
        case 1 : photoList2[indexPath.row]
        case 2 : photoList3[indexPath.row]
        default: Photo()
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { return PhotoCollectionViewCell()}
        
    
        cell.updateCell(image: item.urls.raw, star: item.likes)
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 12
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.isUserInteractionEnabled = false
        let vc = PhotoDetailsViewController()
        let item = switch collectionView.tag {
        case 0 : photoList1[indexPath.row]
        case 1 : photoList2[indexPath.row]
        case 2 : photoList3[indexPath.row]
        default: Photo()
        }
        vc.photo = item
        NetworkClient.request(PhotoStatisticsResponse.self, router: .photoStatics(id: item.id)) {
            vc.response = $0
            let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            backBarButtonItem.tintColor = .black
            self.navigationItem.backBarButtonItem = backBarButtonItem
            self.show(vc, sender: self)
        } failure: { error in
         
        }
                              
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            collectionView.isUserInteractionEnabled = true
        }

    }
    
}
