//
//  ProjectInfoCell.swift
//  Eva
//
//  Created by AmrFawaz on 26/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class ProjectInfoCell: UITableViewCell {

    
    
    @IBOutlet weak var labelProjectType: UILabel!
    @IBOutlet weak var labelProjectTitle: UILabel!
    @IBOutlet weak var labelProjectExcerpt: UILabel!
    @IBOutlet weak var imageViewProjectType: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(projectType: String, projectTitle: String, projectExcerpt: String) {
        if projectType.isEmpty {
            imageViewProjectType.isHidden = true
        } else {
            imageViewProjectType.isHidden = false
        }
        labelProjectType.text = projectType
        labelProjectTitle.text = projectTitle
        labelProjectExcerpt.text = projectExcerpt
    }
    
}
