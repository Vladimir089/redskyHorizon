//
//  YouCoursesViewController.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 26.06.2024.
//

import UIKit

var courses: [Course] = []

protocol YouCoursesViewControllerDelegate: AnyObject {
    func showAlert(tag: Int)
    func showCourse(isNew: Bool, course: Course?)
    func updateInterface(cours: [Course])
    func showDetail(index: Int)
    func updateTable()
    func resetAll()
}

class YouCoursesViewController: UIViewController {

    var mainView: CoursesView?
    weak var delegate: MainDashboardViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = CoursesView()
        mainView?.delegate = self
        self.view = mainView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar()
    }
    
    
    
    

    
}


extension YouCoursesViewController: YouCoursesViewControllerDelegate {
    
    func resetAll() {
        mainView?.collectionView?.reloadData()
        mainView?.activeLabel?.text = "0"
        mainView?.allLabel?.text = "0"
    }
    
    
    func updateTable() {
        mainView?.collectionView?.reloadData()
    }
    
    
    func showDetail(index: Int) {
        let vc = DetailViewController()
        vc.delegate = self
        vc.index = index
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func updateInterface(cours: [Course]) {
        courses = cours
        mainView?.collectionView?.reloadData()
        UserDefaults.standard.setCourses(cours, forKey: "courses")
        delegate?.updateTable(cours: courses)
    }
    
    
    func showCourse(isNew: Bool, course: Course?) {
        let vc = workCourseViewController()
        vc.delegate = self
        vc.isNew = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func showAlert(tag: Int) {

        switch tag {
        case 1:
            let alertController = UIAlertController(title: "Active Courses", message: "", preferredStyle: .alert)
                alertController.addTextField { (textField) in
                    textField.placeholder = "Active Courses"
                    textField.keyboardType = .numberPad
                }

                let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                alertController.addAction(cancelAction)
                
                let okAction = UIAlertAction(title: "Save", style: .default) { (_) in
                    if let textField = alertController.textFields?.first, let text = textField.text {
                        UserDefaults.standard.setValue(text, forKey: "AC")
                        self.mainView?.activeLabel?.text = text
                    }
                }
                alertController.addAction(okAction)
                
            self.present(alertController, animated: true)
        case 2:
            let alertController = UIAlertController(title: "All Courses", message: "", preferredStyle: .alert)
                
                alertController.addTextField { (textField) in
                    textField.placeholder = "All Courses"
                    textField.keyboardType = .numberPad
                }
                
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                alertController.addAction(cancelAction)
                
                let okAction = UIAlertAction(title: "Save", style: .default) { (_) in
                    if let textField = alertController.textFields?.first, let text = textField.text {
                        UserDefaults.standard.setValue(text, forKey: "AllC")
                        self.mainView?.allLabel?.text = text
                    }
                }
                alertController.addAction(okAction)
                
            self.present(alertController, animated: true)
            
        default:
            return
        }
    }
    
}
