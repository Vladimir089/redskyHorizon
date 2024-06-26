//
//  MainDashboardViewController.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 25.06.2024.
//

import UIKit

protocol MainDashboardViewControllerDelegate: AnyObject {
    func showModalVC(tag: Int)
    func showCourses()
    func updateDollar(symbol: String)
    func updateTable()
}

class MainDashboardViewController: UIViewController {
    
    
    
    var mainView: MainDashboardView?

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = MainDashboardView()
        mainView?.delegate = self
        self.view = mainView
        checkSymbol()
        checkCourses()
    }
    
    func checkSymbol() {
        if UserDefaults.standard.object(forKey: "symbol") != nil {
            let symbol = UserDefaults.standard.object(forKey: "symbol") as! String
            print(symbol)
            self.mainView?.showCoursesButton?.setTitle(symbol, for: .normal)
        }
    }
    
    func checkCourses() {
        if let loadedCourses = UserDefaults.standard.courses(forKey: "courses") {
            courses = loadedCourses
            mainView?.collectionView?.reloadData()
        }
    }

}

extension MainDashboardViewController: MainDashboardViewControllerDelegate {
    func updateTable() {
        mainView?.collectionView?.reloadData()
    }
    
    
    
    func updateDollar(symbol: String) {
        UserDefaults.standard.setValue(symbol, forKey: "symbol")
        UIView.animate(withDuration: 0.5) {
            self.mainView?.showCoursesButton?.setTitle(symbol, for: .normal)
        }
    }
    
    func showModalVC(tag: Int) {
        let vc = TotalBalanceViewController()
        vc.tag = tag
        self.present(vc, animated: true)
    }
    
    func showCourses() {
        let vc = CoursesViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
