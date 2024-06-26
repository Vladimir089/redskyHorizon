//
//  CoursesView.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 26.06.2024.
//

import UIKit

class CoursesView: UIView {
    
    var activeLabel, allLabel: UILabel?
    var delegate: YouCoursesViewControllerDelegate?

    override init(frame: CGRect) {
        super .init(frame: frame)
        createInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createInterface() {
        backgroundColor = .BG
        
        let topLabel: UILabel = {
            let label = UILabel()
            label.text = "Your Courses"
            label.textColor = .SC.withAlphaComponent(1)
            label.font = .systemFont(ofSize: 28, weight: .semibold)
            return label
        }()
        addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().inset(15)
        }
        
        let addCourseButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = UIColor(red: 54/255, green: 54/255, blue: 53/255, alpha: 1)
            button.layer.cornerRadius = 20
            button.setImage(UIImage(systemName: "plus")?.resize(targetSize: CGSize(width: 16, height: 20)), for: .normal)
            button.tintColor = .SC.withAlphaComponent(1)
            return button
        }()
        addSubview(addCourseButton)
        addCourseButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(66)
            make.right.equalToSuperview().inset(15)
            make.centerY.equalTo(topLabel.snp.centerY)
        }
        addCourseButton.addTarget(self, action: #selector(addNewCourse), for: .touchUpInside)
        
        let secondLabel: UILabel = {
            let label = UILabel()
            label.text = "This tab is meticulously designed to enhance experience by offering motivation, and tailored educational content"
            label.textColor = .SC.withAlphaComponent(0.5)
            label.font = .systemFont(ofSize: 13, weight: .regular)
            label.numberOfLines = 3
            return label
        }()
        addSubview(secondLabel)
        secondLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(topLabel.snp.bottom).inset(-15)
        }
        
        let topView: UIView = {
            let view = UIView()
            view.backgroundColor = .SC.withAlphaComponent(0.1)
            view.layer.cornerRadius = 16
            return view
        }()
        addSubview(topView)
        topView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(secondLabel.snp.bottom).inset(-15)
            make.height.equalTo(92)
        }
        
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 10
            stack.distribution = .fillEqually
            return stack
        }()
        topView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(10)
        }
        
        
        let activeView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 54/255, green: 54/255, blue: 53/255, alpha: 1)
            view.layer.cornerRadius = 10
            
            let labelText = UILabel()
            labelText.text = "Active"
            labelText.font = .systemFont(ofSize: 13)
            labelText.textColor = .SC.withAlphaComponent(1)
            view.addSubview(labelText)
            labelText.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(view.snp.centerY).offset(-2)
            }
            
            activeLabel = UILabel()
            activeLabel?.text = "0"
            activeLabel?.font = .systemFont(ofSize: 17, weight: .bold)
            activeLabel?.textColor = .OC
            view.addSubview(activeLabel!)
            activeLabel?.snp.makeConstraints({ make in
                make.centerX.equalToSuperview()
                make.top.equalTo(view.snp.centerY).offset(2)
            })
            
            return view
        }()
        
        let allView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 54/255, green: 54/255, blue: 53/255, alpha: 1)
            view.layer.cornerRadius = 10
            
            let labelText = UILabel()
            labelText.text = "All"
            labelText.font = .systemFont(ofSize: 13)
            labelText.textColor = .SC.withAlphaComponent(1)
            view.addSubview(labelText)
            labelText.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(view.snp.centerY).offset(-2)
            }
            
            allLabel = UILabel()
            allLabel?.text = "0"
            allLabel?.font = .systemFont(ofSize: 17, weight: .bold)
            allLabel?.textColor = .OC
            view.addSubview(allLabel!)
            allLabel?.snp.makeConstraints({ make in
                make.centerX.equalToSuperview()
                make.top.equalTo(view.snp.centerY).offset(2)
            })
            
            return view
        }()
        
        
        stackView.addArrangedSubview(activeView)
        stackView.addArrangedSubview(allView)
        
        let gestureActive = UITapGestureRecognizer(target: self, action: #selector(editActiveCourses))
        activeView.addGestureRecognizer(gestureActive)
        
        let gestureAll = UITapGestureRecognizer(target: self, action: #selector(eitAllCourses))
        allView.addGestureRecognizer(gestureAll)
        
        
        
        
        loadData()
    }
    
    
    
    
    func loadData() {
        //labels
        if let text = UserDefaults.standard.object(forKey: "AC") as? String {
            activeLabel?.text = text
        }
        if let text = UserDefaults.standard.object(forKey: "AllC") as? String {
            allLabel?.text = text
        }
        
        
    }
    
   
    //MARK: -objc func
    
    @objc func editActiveCourses() {
        delegate?.showAlert(tag: 1)
    }
    
    @objc func eitAllCourses() {
        delegate?.showAlert(tag: 2)
    }
    
    @objc func addNewCourse() {
        delegate?.showCourse(isNew: true, course: nil)
    }
    
}
