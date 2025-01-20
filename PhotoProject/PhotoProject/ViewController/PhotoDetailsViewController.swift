//
//  PhotoDetailsViewController.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/19/25.
//

import UIKit
import Kingfisher
import SnapKit


final class PhotoDetailsViewController: UIViewController {
    
    var photo: Photo?
    var response: PhotoStatisticsResponse? {
        didSet {
            mainView.viewsNumberLabel.text = response?.views.total.formatted(.number)
            mainView.downloadNumberLabel.text = response?.downloads.total.formatted(.number)
        }
    }
    
    let mainView = PhotoDetailsView()
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.nameLabel.text = photo?.user.name
        mainView.dateLabel.text = DataFormatterManager.formatted(string: photo!.created_at)
//        mainView.imageView.kf.setImage(with: URL(string: photo!.urls.raw))
        mainView.imageView.kf.setImage(with:  URL(string: photo!.urls.raw)) { response in
            switch response {
            case .success(let result):
                self.mainView.updateConstraintsIfNeeded()
                self.mainView.layoutIfNeeded()
            case .failure(let error): print(error)
            }
        }
        mainView.profileImage.kf.setImage(with: URL(string: photo!.user.profile_image.medium))
        mainView.infoTitleLabel.text = "정보"
        mainView.downloadTitleLabel.text = "다운로드"
        mainView.viewsTitleLabel.text = "조회수"
        mainView.sizeTitleLabel.text = "크기"
        mainView.sizeNumberLabel.text = "\(photo!.width) x \(photo!.width)"
        mainView.chartLabel.text = "차트"
        
        
        mainView.imageView.snp.remakeConstraints {
            $0.top.equalTo(mainView.profileImage.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(mainView.contentView)
            $0.height.equalTo(Int(UIScreen.main.bounds.width) * (photo!.width/photo!.height))
        }
        
        mainView.infoTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainView.imageView.snp.bottom).offset(20)
            $0.bottom.equalTo(mainView.chartLabel.snp.top).offset(-100)
            $0.leading.equalTo(mainView.contentView).inset(20)
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.view.layoutIfNeeded()
        }
    }
    
}
