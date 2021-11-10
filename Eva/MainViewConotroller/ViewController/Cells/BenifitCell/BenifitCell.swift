//
//  BenifitCell.swift
//  Eva
//
//  Created by AmrFawaz on 03/11/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class BenifitCell: UITableViewCell {

    @IBOutlet weak var imageViewBenifitIcon: UIImageView!
    @IBOutlet weak var labelBenifitName: UILabel!
    @IBOutlet weak var labelBenifitValue: UILabel!
    @IBOutlet weak var imageViewCheckMark: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(imageUrl: String, benifitName: String, benifitValue: String, benifitType: String) {
        imageViewBenifitIcon?.kf.setImage(with: URL(string: imageUrl))
        labelBenifitName.text = benifitName
        labelBenifitValue.text = benifitValue

        if benifitType == "true_false" && benifitValue == "1" {
            labelBenifitValue.isHidden = true
            imageViewCheckMark.isHidden = false
        } else if !benifitValue.isEmpty {
            labelBenifitValue.text = benifitValue
            labelBenifitValue.isHidden = false
            imageViewCheckMark.isHidden = true
        }
    }

    
}
