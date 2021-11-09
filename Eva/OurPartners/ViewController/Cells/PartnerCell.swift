//
//  PartnerCell.swift
//  Eva
//
//  Created by AmrFawaz on 29/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit
import Kingfisher
class PartnerCell: UITableViewCell {

    @IBOutlet weak var imageViewPartner: UIImageView!
    @IBOutlet weak var labelPartnerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configuerCell(imageUrl: String?, partnerName: String?) {
        self.labelPartnerName.text = partnerName ?? ""
        let image_url = imageUrl?.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)

        if let url = URL(string: image_url ?? "") {
            self.imageViewPartner.kf.setImage(with: url)
        }
    }
}
