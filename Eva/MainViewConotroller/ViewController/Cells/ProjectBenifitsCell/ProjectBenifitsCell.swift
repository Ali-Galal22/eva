//
//  ProjectBenifitsCell.swift
//  Eva
//
//  Created by AmrFawaz on 28/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class ProjectBenifitsCell: UITableViewCell {

    @IBOutlet weak var imageViewOpenClose: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(opened: Bool) {
        if opened {
            imageViewOpenClose.image = #imageLiteral(resourceName: "section-open-icon")
        } else {
            imageViewOpenClose.image = #imageLiteral(resourceName: "section-close-icon")
        }
    }
}
