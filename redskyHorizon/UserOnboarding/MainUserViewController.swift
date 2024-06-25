//
//  MainUserViewController.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 25.06.2024.
//

// MainUserViewController.swift
import UIKit

class MainUserViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем и показываем OneUserViewController
        let oneUserViewController = OneUserViewController()
        let navigationController = UINavigationController(rootViewController: oneUserViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: false, completion: nil)
    }
}

