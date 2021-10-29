//
//  ProjectDetailsCell.swift
//  Eva
//
//  Created by AmrFawaz on 26/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class ProjectDetailsCell: UITableViewCell {

    @IBOutlet weak var labelStartDateTitle: UILabel!
    @IBOutlet weak var labelStartDateValue: UILabel!
    @IBOutlet weak var labelEndDateTitle: UILabel!
    @IBOutlet weak var labelEndDateValue: UILabel!
    @IBOutlet weak var labelProjectStatusTitle: UILabel!
    @IBOutlet weak var labelProjectStatusValue: UILabel!
    @IBOutlet weak var labelProjectLocationTitle: UILabel!
    @IBOutlet weak var labelProjectLocationValue: UILabel!
    @IBOutlet weak var labelProjectTypeTitle: UILabel!
    @IBOutlet weak var labelProjectTypeValue: UILabel!
    
    
    
    
    
    func configureCell(startDate: String, endDate: String, projectStatus: String, projectLocation: String, projectType: String) {
        
        labelStartDateValue.text = startDate
        labelEndDateValue.text = endDate
        labelProjectStatusValue.text = projectStatus
        labelProjectLocationValue.text = projectLocation
        labelProjectTypeValue.text = projectType
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
