//
//  SuccessViewController.swift
//  Eva
//
//  Created by AmrFawaz on 21/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(dismissView), userInfo: nil, repeats: false)

    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }

}
