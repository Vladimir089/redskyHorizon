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
    func updateTable(cours: [Course])
    func showDetail(index: Int)
    func updateGuestVC()
    func resetAll()
}

class MainDashboardViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar()
    }
    
    var mainView: MainDashboardView?
    var delegate: YouCoursesViewControllerDelegate?

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
    
    func resetAll() {
        mainView?.activeCourses.removeAll()
        mainView?.collectionView?.reloadData()
        mainView?.showCoursesButton?.setTitle("$", for: .normal)
    }
    
    
    func updateGuestVC() {
        delegate?.updateTable()
    }
    
    
    
    func showDetail(index: Int) {
        let vc = DetailViewController()
        vc.index = index
        vc.secondDelagate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func updateTable(cours: [Course]) {
        courses = cours
        UserDefaults.standard.setCourses(cours, forKey: "courses")
        mainView?.activeCourses.removeAll()
        mainView?.collectionView?.reloadData()
        updateGuestVC()
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
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
