//
//  TabViewController.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 25.06.2024.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let dashboardVC = MainDashboardViewController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "chart.pie.fill")?.resize(targetSize: CGSize(width: 24, height: 25)), tag: 0)
        dashboardVC.tabBarItem = tabBarItem
        
        let myCoursesVc = YouCoursesViewController()
        let tabBaritemTwo = UITabBarItem(title: "", image: UIImage(systemName: "chart.bar.doc.horizontal.fill")?.resize(targetSize: CGSize(width: 22, height: 25)), tag: 1)
        myCoursesVc.tabBarItem = tabBaritemTwo


        viewControllers = [dashboardVC, myCoursesVc]
        
        
        tabBar.backgroundColor = .BG
        tabBar.unselectedItemTintColor = .SC.withAlphaComponent(0.3)
        tabBar.tintColor = .OC.withAlphaComponent(1)
    
        let separator = UIView()
        separator.backgroundColor = .separator
        tabBar.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalToSuperview()
        }
    }
    

   

}
