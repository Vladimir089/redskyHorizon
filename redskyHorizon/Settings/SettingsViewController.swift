//
//  SettingsViewController.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 27.06.2024.
//

import UIKit
import WebKit
import StoreKit


class SettingsViewController: UIViewController {
    
    var delegateOne: MainDashboardViewControllerDelegate?
    var delegateTwo: YouCoursesViewControllerDelegate?
    
    var appID = "idYOUR_APP_ID"

    override func viewDidLoad() {
        super.viewDidLoad()

        settingsView()
    }
    
    
    func settingsView() {
        view.backgroundColor = .BG
        
        
        let topLabel: UILabel = {
            let label = UILabel()
            label.text = "Settings"
            label.textColor = .SC.withAlphaComponent(1)
            label.font = .systemFont(ofSize: 28, weight: .semibold)
            return label
        }()
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(15)
            make.left.equalToSuperview().inset(15)
        }
        
        
        let midView: UIView = {
            let view = UIView()
            view.backgroundColor = .white.withAlphaComponent(0.1)
            view.layer.cornerRadius = 14
            view.layer.borderColor = UIColor.SC.withAlphaComponent(0.2).cgColor
            view.layer.borderWidth = 1
            return view
        }()
        
        view.addSubview(midView)
        midView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(topLabel.snp.bottom).inset(-20)
            make.height.equalTo(162)
        }
        
        let shareButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Share app", for: .normal)
            button.backgroundColor = .clear
            button.setTitleColor(.SC.withAlphaComponent(1), for: .normal)
            button.titleLabel?.textAlignment = .left
            button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
            button.contentHorizontalAlignment = .left
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
            
            let separator = UIView()
            separator.backgroundColor = UIColor.SC.withAlphaComponent(0.2)
            button.addSubview(separator)
            separator.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(1)
            }
            
            return button
        }()
        shareButton.addTarget(self, action: #selector(shareApp), for: .touchUpInside)
        
        
        let usageButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Usage policy", for: .normal)
            button.backgroundColor = .clear
            button.setTitleColor(.SC.withAlphaComponent(1), for: .normal)
            button.titleLabel?.textAlignment = .left
            button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
            button.contentHorizontalAlignment = .left
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
            
            
            let separator = UIView()
            separator.backgroundColor = UIColor.SC.withAlphaComponent(0.2)
            button.addSubview(separator)
            separator.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(1)
            }
            
            return button
        }()
        usageButton.addTarget(self, action: #selector(policy), for: .touchUpInside)
        
        
        let rateButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Rate App", for: .normal)
            button.backgroundColor = .clear
            button.setTitleColor(.SC.withAlphaComponent(1), for: .normal)
            button.titleLabel?.textAlignment = .left
            button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
            button.contentHorizontalAlignment = .left
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
            return button
        }()
        rateButton.addTarget(self, action: #selector(rateApp), for: .touchUpInside)
        
        let stackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.distribution = .fillEqually
            return view
        }()
        midView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        stackView.addArrangedSubview(shareButton)
        stackView.addArrangedSubview(usageButton)
        stackView.addArrangedSubview(rateButton)
        
        let resetButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Reset progress", for: .normal)
            button.layer.cornerRadius = 12
            button.backgroundColor = .OC
            button.setTitleColor(.SC.withAlphaComponent(1), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
            return button
        }()
        view.addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
        resetButton.addTarget(self, action: #selector(resetProgress), for: .touchUpInside)
    }


    //MARK: -objc
    
    @objc func shareApp() {
        let appURL = URL(string: "https://apps.apple.com/app/\(appID)")!
        let activityViewController = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @objc func policy() {
        let webVC = WebViewController()
        webVC.urlString = "https://www.google.com"
        present(webVC, animated: true, completion: nil)
    }
    

    @objc func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            if let url = URL(string: "itms-apps://itunes.apple.com/app/\(appID)") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }


    @objc func resetProgress() {
        let alert = UIAlertController(title: "Reset progress", message: "Are you sure you want to reset progress?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Reset", style: .destructive) { [weak self] _ in
            courses.removeAll()
            
            let defaults = UserDefaults.standard
            if let appDomain = Bundle.main.bundleIdentifier {
                defaults.removePersistentDomain(forName: appDomain)
            }
            defaults.synchronize()
            
            self?.delegateOne?.resetAll()
            self?.delegateTwo?.resetAll()
            UserDefaults.standard.setValue(true, forKey: "tabBar")
        }
        let cancelAction = UIAlertAction(title: "Close", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
 
}


class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var urlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        // Загружаем URL
        if let urlString = urlString, let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
}
