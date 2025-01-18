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
    }


}

