//
//  ProjectDetailsMainImageCell.swift
//  Eva
//
//  Created by AmrFawaz on 24/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

protocol ProjectDetailsMainImageCellDelegate: AnyObject {
    func dismissView()
    func showInterestView()
}
class ProjectDetailsMainImageCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var imageViewMain: UIImageView!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonOrderNow: UIButton!
    @IBOutlet weak var collectionViewGallary: UICollectionView!
    @IBOutlet weak var buttonScrollLeft: UIButton!
    @IBOutlet weak var buttonScrollRight: UIButton!
    
    weak var delegate: ProjectDetailsMainImageCellDelegate?
    private var gallary: [Gallary]?
    
    private var currentSelectedCellIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionViewGallary.dataSource = self
        self.collectionViewGallary.delegate = self
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: 100)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionViewGallary.collectionViewLayout = layout

        collectionViewGallary.register(UINib(nibName: Constants.CellsIdentefires.ImageGallaryCell, bundle: nil), forCellWithReuseIdentifier: Constants.CellsIdentefires.ImageGallaryCell)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.collectionViewGallary.scrollToPreviousItem()
        })

    }

    func configureCell(gallary: [Gallary]) {
        
        self.gallary = gallary
        if let imageStringURL = gallary.first?.full {
            imageViewMain?.kf.setImage(with: URL(string: imageStringURL))
        }

        DispatchQueue.main.async {
            self.collectionViewGallary.reloadData()
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Actions
    @IBAction func buttoonBackClicked(_ sender: Any) {
        delegate?.dismissView()
    }
    
    @IBAction func buttonOrderNowClicked(_ sender: Any) {
        delegate?.showInterestView()
    }
    
    @IBAction func buttonScrollLeftClicked(_ sender: Any) {
        let imagesCount = (gallary?.count ?? 0) - 1
        if currentSelectedCellIndex < imagesCount {
            currentSelectedCellIndex = currentSelectedCellIndex + 1
            self.collectionViewGallary.scrollToNextItem()
            if let imageStringURL = gallary?[currentSelectedCellIndex].full {
                imageViewMain?.kf.setImage(with: URL(string: imageStringURL))
            }
        }
    }
    
    @IBAction func buttonScrollRightClicked(_ sender: Any) {
        if currentSelectedCellIndex >= 1 {
            currentSelectedCellIndex = currentSelectedCellIndex - 1
            self.collectionViewGallary.scrollToPreviousItem()
            if let imageStringURL = gallary?[currentSelectedCellIndex].full {
                imageViewMain?.kf.setImage(with: URL(string: imageStringURL))
            }

        }
    }
    
    
    
}

extension ProjectDetailsMainImageCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallary?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gallaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellsIdentefires.ImageGallaryCell, for: indexPath) as? ImageGallaryCell
        if let imageURL = URL(string: gallary?[indexPath.item].thumb ?? "") {
            gallaryCell?.imageView.kf.setImage(with: imageURL)
        }
        
        return gallaryCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width

        return CGSize(width: screenWidth/3, height: 100);
    }

}
extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + (self.bounds.size.width / 3)))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - (self.bounds.size.width / 3)))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}
