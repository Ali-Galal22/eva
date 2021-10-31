//
//  AboutUsMainCell.swift
//  Eva
//
//  Created by AmrFawaz on 30/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class AboutUsMainCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var labelAboutUs: UILabel!
    
    @IBOutlet weak var labelAboutUsContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(title: String, content: String) {
        self.labelAboutUs.text = title
        self.labelAboutUsContent.text = content
        self.labelAboutUsContent.setLineHeight(lineHeight: 10)
    }
}
