//
//  AboutUsCell.swift
//  Eva
//
//  Created by AmrFawaz on 30/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class AboutUsCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var imageViewOpenClose: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configureCell(title: String, content: String, opened: Bool) {
        self.labelTitle.text = title
        self.labelContent.text = content
        self.labelContent.setLineHeight(lineHeight: 10)

        if opened {
            imageViewOpenClose.image = #imageLiteral(resourceName: "section-open-icon")
        } else {
            imageViewOpenClose.image = #imageLiteral(resourceName: "section-close-icon")
        }
    }

}
