//
//  ServiceCell.swift
//  Eva
//
//  Created by AmrFawaz on 19/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit
import Kingfisher
protocol ServiceCellDelegate: AnyObject {
    func didClickReadMore(for cellIndex: Int)
    func didClickInteret(for cellIndex: Int)
}
class ServiceCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var imageViewService: UIImageView!
    @IBOutlet weak var labelServiceName: UILabel!
    @IBOutlet weak var labelServiceDetails: UILabel!
    @IBOutlet weak var buttonReadMore: UIButton!
    @IBOutlet weak var buttonInterest: UIButton!
    
    private weak var delegate: ServiceCellDelegate?
    var cellIndex: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureServiceCell(with delegate: ServiceCellDelegate, and service: Service?) {
        self.delegate = delegate
        self.labelServiceName.text = service?.title
        
        self.labelServiceDetails.text = service?.content
        self.labelServiceDetails.setLineHeight(lineHeight: 10)
        if let imageURL = URL(string: service?.image ?? "") {
            self.imageViewService.kf.setImage(with: imageURL)
        }
    }
    

    // MARK: - Actions
    @IBAction func buttonReadMoreClicked(_ sender: Any) {
        if let index = cellIndex {
            delegate?.didClickReadMore(for: index)
        }
    }
    @IBAction func buttonInterstClicked(_ sender: Any) {
        if let index = cellIndex {
            delegate?.didClickInteret(for: index)
        }
    }
    
}
