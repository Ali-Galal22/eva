//
//  HomeCell.swift
//  Eva
//
//  Created by AmrFawaz on 13/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit
import Kingfisher

protocol HomeCellDelegate: AnyObject {
    func didClickDetails()
}
class HomeCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    private weak var delegate: HomeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureServiceCell(with delegate: HomeCellDelegate, and service: Service?) {
        self.delegate = delegate
        self.labelTitle.text = service?.title
        if let imageURL = URL(string: service?.image ?? "") {
            self.itemImageView.kf.setImage(with: imageURL)
        }
    }
    
    func configureProjectCell(with delegate: HomeCellDelegate, and project: Project?) {
        self.delegate = delegate
        self.labelTitle.text = project?.title
        self.labelPrice.text = project?.price
        if let imageURL = URL(string: project?.image ?? "") {
            self.itemImageView.kf.setImage(with: imageURL)
        }
    }

    // MARK: - Actions
    @IBAction func buttonDetailsClicked(_ sender: Any) {
        delegate?.didClickDetails()
    }
}
