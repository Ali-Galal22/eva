//
//  AppDelegate.swift
//  Eva
//
//  Created by AmrFawaz on 10/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        RunLoop.current.run(until: NSDate(timeIntervalSinceNow:3) as Date)

        StartUpCoordinator().start()


        return true
    }



}

