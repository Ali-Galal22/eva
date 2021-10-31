//
//  ErrorView.swift
//  Eva
//
//  Created by AmrFawaz on 31/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit
import Lottie

class ErrorView: UIViewController {

    @IBOutlet weak var labelErrorDescription: UILabel!
    @IBOutlet weak var errorIconView: UIView!
    var onRetry: (() -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSplashAnimation()
    }
    

    func showSplashAnimation() {
        var loadAnimationView: AnimationView?
        loadAnimationView = AnimationView(name: "error")
        loadAnimationView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loadAnimationView?.contentMode = .scaleAspectFill

        errorIconView.addSubview(loadAnimationView!)
        loadAnimationView?.loopMode = .loop
        loadAnimationView?.play()
    }

    @IBAction func buttonRetryClicked(_ sender: Any) {
        if let callback = self.onRetry {
            callback ()
        }
    }
    
}
