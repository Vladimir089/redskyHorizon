//
//  TwoUserViewController.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 25.06.2024.
//


import UIKit

class TwoUserViewController: UIViewController {

    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBG
        createInterface()
    }
    
    
    func createInterface() {
        
        let imageView: UIImageView = {
            let image:UIImage = .twoUser
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        view.addSubview(imageView)
        if let image = imageView.image {
            imageView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalToSuperview()
                let aspectRatio = image.size.height / image.size.width

                // Получаем ширину экрана
                let screenWidth = UIScreen.main.bounds.width

                // Задаем новую ширину, если ширина экрана меньше 375 (например для iPhone SE)
                if screenWidth <= 375 {
                    let newWidth = screenWidth * 0.85 // на 10% меньше
                    make.width.equalTo(newWidth)
                    make.height.equalTo(newWidth * aspectRatio)
                } else {
                    make.height.equalTo(imageView.snp.width).multipliedBy(aspectRatio)
                }
            }
        }
        
        let labelMain: UILabel = {
            let label = UILabel()
            label.text = "Collect your knowledge"
            label.font = .systemFont(ofSize: 28, weight: .bold)
            label.textColor = .mainText
            return label
        }()
        view.addSubview(labelMain)
        labelMain.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).inset(-20)
        }
        
        let secondLabal: UILabel = {
            let label = UILabel()
            label.text = "You won't lost anything"
            label.textColor = .secondText
            label.numberOfLines = 2
            label.font = .systemFont(ofSize: 17, weight: .regular)
            return label
        }()
        view.addSubview(secondLabal)
        secondLabal.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labelMain.snp.bottom).inset(-10)
        }
        
        let buttonGo: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Next", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .OC
            button.layer.cornerRadius = 12
            return button
        }()
        view.addSubview(buttonGo)
        buttonGo.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(25)
        }
        
        
        let midView = UIView()
        midView.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.7)
        midView.layer.cornerRadius = 12
        view.addSubview(midView)
        midView.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(48)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(buttonGo.snp.top).inset(-20)
        }
        
        
        let oneView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
            view.layer.cornerRadius = 4
            return view
        }()
        midView.addSubview(oneView)
        oneView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(8)
            make.right.equalToSuperview().inset(11)
        }
        
        let twoView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 0.3)
            view.layer.cornerRadius = 4
            return view
        }()
        midView.addSubview(twoView)
        twoView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(8)
            make.left.equalToSuperview().inset(11)
        }
        buttonGo.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        
        
    }
    
    @objc func nextPage() {
        self.navigationController?.setViewControllers([TabViewController()], animated: true)
    }
    
    
    
}

