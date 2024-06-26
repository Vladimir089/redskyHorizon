//
//  MainDashboardView.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 25.06.2024.
//

import UIKit

class MainDashboardView: UIView {
    
    var showCoursesButton: UIButton?
    weak var delegate: MainDashboardViewControllerDelegate?

    override init(frame: CGRect) {
        super .init(frame: frame)
        createInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createInterface() {
        backgroundColor = .BG
        
        let imageView: UIImageView = {
            let image:UIImage = .top
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        addSubview(imageView)
        
        if let image = imageView.image {
            imageView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalToSuperview()
                let aspectRatio = image.size.height / image.size.width
                make.height.equalTo(imageView.snp.width).multipliedBy(aspectRatio)
            }
        }
        
        
        let dashboardTextLabel: UILabel = {
            let label = UILabel()
            label.text = "Dashboard"
            label.textColor = .mainText
            label.font = .systemFont(ofSize: 28, weight: .semibold)
            return label
        }()
        addSubview(dashboardTextLabel)
        dashboardTextLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        
        showCoursesButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = .secondary
            button.layer.cornerRadius = 20
            button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
            button.setTitle("$", for: .normal)
            button.setTitleColor(.mainText, for: .normal)
            return button
        }()
        addSubview(showCoursesButton!)
        showCoursesButton?.snp.makeConstraints({ make in
            make.height.equalTo(40)
            make.width.equalTo(66)
            make.centerY.equalTo(dashboardTextLabel.snp.centerY)
            make.right.equalToSuperview().inset(15)
        })
        showCoursesButton?.addTarget(self, action: #selector(showCourses), for: .touchUpInside)
        
        
        let secondaryLabel: UILabel = {
            let label = UILabel()
            label.text = "The dashboard serves as the central hub for your, providing a comprehensive overview of learning progress"
            label.numberOfLines = 2
            label.textColor = .secondText
            label.font = .systemFont(ofSize: 13, weight: .regular)
            label.textAlignment = .left
            return label
        }()
        addSubview(secondaryLabel)
        secondaryLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(dashboardTextLabel.snp.bottom).inset(-15)
        }
        
        
        let midView: UIView = {
            let view = UIView()
            view.backgroundColor = .white.withAlphaComponent(0.1)
            view.layer.cornerRadius = 16
            return view
        }()
        addSubview(midView)
        midView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(80)
            make.top.equalTo(secondaryLabel.snp.bottom).inset(-20)
        }
        
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 10
            stack.distribution = .fillEqually
            return stack
        }()
        midView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(10)
        }
        
        let oneBut = createButton(image: .one.resize(targetSize: CGSize(width: 20, height: 20)))
        stackView.addArrangedSubview(oneBut)
        oneBut.addTarget(self, action: #selector(showTotalBalance), for: .touchUpInside)
        
        let twoBut = createButton(image: .two.resize(targetSize: CGSize(width: 17, height: 20)))
        stackView.addArrangedSubview(twoBut)
        twoBut.addTarget(self, action: #selector(showAverageLoss), for: .touchUpInside)
        
        let threeBut = createButton(image: .three.resize(targetSize: CGSize(width: 18, height: 20)))
        stackView.addArrangedSubview(threeBut)
        threeBut.addTarget(self, action: #selector(showAverageLessionDuration), for: .touchUpInside)
        
        let fourBut = createButton(image: .four.resize(targetSize: CGSize(width: 17, height: 20)))
        stackView.addArrangedSubview(fourBut)
        fourBut.addTarget(self, action: #selector(showAverageProfit), for: .touchUpInside)
        
        let fiveBut = createButton(image: .five.resize(targetSize: CGSize(width: 22, height: 20)))
        stackView.addArrangedSubview(fiveBut)
        fiveBut.addTarget(self, action: #selector(totalCourses), for: .touchUpInside)
        
        
        let activeCoursesLabel: UILabel = {
            let label = UILabel()
            label.text = "Active courses"
            label.textColor = .SC.withAlphaComponent(1)
            label.font = .systemFont(ofSize: 17, weight: .semibold)
            return label
        }()
        addSubview(activeCoursesLabel)
        activeCoursesLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.top.equalTo(midView.snp.bottom).inset(-15)
        }
        
    }
    
    //MARK: -objc func
    
    //для кнопки показать курсы валют
    @objc func showCourses() {
        delegate?.showCourses()
    }
    
    @objc func showTotalBalance() {
        delegate?.showModalVC(tag: 1)
    }
    
    @objc func showAverageLoss() {
        delegate?.showModalVC(tag: 2)
    }
    
    @objc func showAverageLessionDuration() {
        delegate?.showModalVC(tag: 3)
    }
    
    @objc func showAverageProfit() {
        delegate?.showModalVC(tag: 4)
    }
    
    @objc func totalCourses() {
        delegate?.showModalVC(tag: 5)
    }
    
    //MARK: -Next
    
    
    func createButton(image: UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 54/255, green: 54/255, blue: 53/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.setImage(image, for: .normal)
        button.setTitleColor(.mainText, for: .normal)
        button.tintColor = .mainText
        return button
    }
}









