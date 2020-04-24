//
//  AppDelegate.swift
//  CovidStatistic
//
//  Created by Vladimir on 4/22/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let vc = GlobalStatisticsViewController(viewModel: GlobalStatisticsViewModelImplementation())
		let navigationController = UINavigationController(rootViewController: vc)
		
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		return true
	}

}

