//
//  AppDelegate.swift
//  MyHabits
//
//  Created by M M on 6/9/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        self.window?.rootViewController = tabBarController

        let habitsViewController = HabitsViewController()
        let infoViewController = InfoViewController()

        let habitsViewNavigationController = UINavigationController(rootViewController: habitsViewController)
        habitsViewNavigationController.setViewControllers([habitsViewController], animated: true)
        habitsViewNavigationController.tabBarItem.image = UIImage(systemName: "rectangle.grid.1x2.fill")
        habitsViewNavigationController.tabBarItem.title = "Привычки"

        let infoViewNavigationController = UINavigationController(rootViewController: infoViewController)
        infoViewNavigationController.setViewControllers([infoViewController], animated: true)
        infoViewNavigationController.tabBarItem.image = UIImage(systemName: "info.circle.fill")
        infoViewNavigationController.tabBarItem.title = "Информация"

        tabBarController.viewControllers = [habitsViewNavigationController, infoViewNavigationController]
        tabBarController.tabBar.backgroundColor = UIColor(named: "ghostWhite")
        tabBarController.tabBar.tintColor = UIColor(named: "Lilac")
        tabBarController.tabBar.isTranslucent = false

        self.window?.makeKeyAndVisible()
        return true
    }
}

