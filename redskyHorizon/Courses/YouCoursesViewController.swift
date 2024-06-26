//
//  YouCoursesViewController.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 26.06.2024.
//

import UIKit

protocol YouCoursesViewControllerDelegate: AnyObject {
    func showAlert(tag: Int)
    func showCourse(isNew: Bool, course: Course?)
}

class YouCoursesViewController: UIViewController {

    var mainView: CoursesView?

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = CoursesView()
        mainView?.delegate = self
        self.view = mainView
    }

}


extension YouCoursesViewController: YouCoursesViewControllerDelegate {
    
    func showCourse(isNew: Bool, course: Course?) {
        let vc = workCourseViewController()
        if isNew == true {
            vc.isNew = true
        } else {
            vc.isNew = false
            vc.course = course
        }
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
