//
//  ProjectFeatureCell.swift
//  Eva
//
//  Created by AmrFawaz on 26/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class ProjectFeatureCell: UITableViewCell {

    @IBOutlet weak var labelProjectDetails: UILabel!
    @IBOutlet weak var imageViewOpenClose: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(projectDetails: String, opened: Bool) {
        self.labelProjectDetails.text = projectDetails
        self.labelProjectDetails.setLineHeight(lineHeight: 10)
        if opened {
            imageViewOpenClose.image = #imageLiteral(resourceName: "section-open-icon")
        } else {
            imageViewOpenClose.image = #imageLiteral(resourceName: "section-close-icon")
        }
    }
}
