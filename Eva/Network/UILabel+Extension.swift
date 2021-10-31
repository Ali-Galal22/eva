//
//  UILabel+Extension.swift
//  Eva
//
//  Created by AmrFawaz on 31/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            style.alignment = .right
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
            self.attributedText = attributeString
        }
    }

}
