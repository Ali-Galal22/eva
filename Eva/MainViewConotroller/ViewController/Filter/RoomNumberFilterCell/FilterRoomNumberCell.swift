//
//  FilterRoomNumberCell.swift
//  Eva
//
//  Created by AmrFawaz on 15/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

protocol FilterRoomNumberCellDelegate: AnyObject {
    func plus()
    func minus()
}
class FilterRoomNumberCell: UITableViewCell {

    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var labelRoomsNumber: UILabel!
    
    weak var delegate: FilterRoomNumberCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.buttonPlus.cornerRadius = self.buttonPlus.bounds.height / 2
        self.buttonMinus.cornerRadius = self.buttonMinus.bounds.height / 2
    }

    // MARK: - Actions
    @IBAction func buttonMinusClicked(_ sender: Any) {
        delegate?.minus()
    }
    
    @IBAction func buttonPlusClicked(_ sender: Any) {
        delegate?.plus()
    }
    
}
