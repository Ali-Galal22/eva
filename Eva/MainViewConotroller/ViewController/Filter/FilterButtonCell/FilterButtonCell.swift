//
//  FilterButtonCell.swift
//  Eva
//
//  Created by AmrFawaz on 17/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

protocol FilterButtonCellDelegate: AnyObject {
    func filter()
}
class FilterButtonCell: UITableViewCell {
    @IBOutlet weak var buttonFilter: UIButton!
    
    weak var delegate: FilterButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buttoonFilterDidClicked(_ sender: Any) {
        delegate?.filter()
    }
    
}
