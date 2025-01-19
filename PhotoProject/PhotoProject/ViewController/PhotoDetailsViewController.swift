//
//  PhotoDetailsViewController.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/19/25.
//

import UIKit

final class PhotoDetailsViewController: UIViewController {

    let mainView = PhotoDetailsView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
