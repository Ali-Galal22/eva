//
//  MapCell.swift
//  Eva
//
//  Created by AmrFawaz on 26/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit
import WebKit
class MapCell: UITableViewCell {

    @IBOutlet weak var webView: WKWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(html: String) {
        self.webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
