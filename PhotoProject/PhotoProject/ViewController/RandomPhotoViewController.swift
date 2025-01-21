//
//  RandomPhotoViewController.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/21/25.
//

import UIKit

final class RandomPhotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        NetworkClient.request(Photo.self, router: .randomPhoto(count: 10)) {
            print($0)
        } failure: { error in
            
        }

        
    }
    
}

//extension RandomPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
//    
//    
//}
