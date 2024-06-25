//
//  TotalBalanceViewController.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 25.06.2024.
//

import UIKit

class TotalBalanceViewController: UIViewController {
    
    var tag = 1
    
    var headerLabel: UILabel?
    var leftImage: UIImageView?
    var onTextFieldLabel: UILabel?
    var textField: UITextField?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .SC.withAlphaComponent(1)
        createInterface()
    }
    
    func loadData() {
        switch tag {
        case 1:
            headerLabel?.text = "Total Balance"
            leftImage?.image = .one.resize(targetSize: CGSize(width: 20, height: 20))
            onTextFieldLabel?.text = "Total Balance"
            if let value = UserDefaults.standard.string(forKey: "1") {
                textField?.text = value
            }
        case 2:
            headerLabel?.text = "Average Loss"
            leftImage?.image = .two.resize(targetSize: CGSize(width: 20, height: 20))
            onTextFieldLabel?.text = "Average Loss"
            if let value = UserDefaults.standard.string(forKey: "2") {
                textField?.text = value
            }
        case 3:
            headerLabel?.text = "Average Lesson Duration"
            leftImage?.image = .three.resize(targetSize: CGSize(width: 20, height: 20))
            onTextFieldLabel?.text = "Average Lesson Duration"
            if let value = UserDefaults.standard.string(forKey: "3") {
                textField?.text = value
            }
        case 4:
            headerLabel?.text = "Average Profit"
            leftImage?.image = .four.resize(targetSize: CGSize(width: 20, height: 20))
            onTextFieldLabel?.text = "Average Profit"
            if let value = UserDefaults.standard.string(forKey: "4") {
                textField?.text = value
            }
        case 5:
            headerLabel?.text = "Total Courses"
            leftImage?.image = .five.resize(targetSize: CGSize(width: 20, height: 20))
            onTextFieldLabel?.text = "Total Courses"
            if let value = UserDefaults.standard.string(forKey: "5") {
                textField?.text = value
            }
        default:
            return 
        }
    }
    
    func createInterface() {
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
        
        let closeViewSlider: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 0.2)
            view.layer.cornerRadius = 2
            return view
        }()
        view.addSubview(closeViewSlider)
        closeViewSlider.snp.makeConstraints { make in
            make.height.equalTo(5)
            make.width.equalTo(36)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(24)
        }
        
        var closeButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 0.2)
            button.setTitleColor(UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1), for: .normal)
            button.setImage(.xmark.resize(targetSize: CGSize(width: 9.6, height: 9.6)), for: .normal)
            button.tintColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1)
            button.layer.cornerRadius = 12
            return button
        }()
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.left.equalToSuperview().inset(15)
            make.top.equalTo(closeViewSlider.snp.bottom).inset(-15)
        }
        closeButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
        headerLabel = {
            let label = UILabel()
            label.text = "---"
            label.font = .systemFont(ofSize: 17, weight: .semibold)
            label.textColor = .black
            return label
        }()
        view.addSubview(headerLabel!)
        headerLabel?.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(closeButton.snp.centerY)
        })
        
        let topSeparatorView: UIView = {
            let view = UIView()
            view.backgroundColor = .separator
            return view
        }()
        view.addSubview(topSeparatorView)
        topSeparatorView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.left.right.equalToSuperview()
            make.top.equalTo(closeButton.snp.bottom).inset(-15)
        }
        
        leftImage = {
            let image: UIImage = .one.resize(targetSize: CGSize(width: 20, height: 20))
            let imageView = UIImageView(image: image)
            imageView.backgroundColor = .OC
            imageView.contentMode = .center
            imageView.layer.cornerRadius = 14
            return imageView
        }()
        view.addSubview(leftImage!)
        leftImage?.snp.makeConstraints({ make in
            make.height.equalTo(76)
            make.width.equalTo(57)
            make.left.equalToSuperview().inset(15)
            make.top.equalTo(topSeparatorView.snp.bottom).inset(-15)
        })
        
        let centerView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            view.layer.cornerRadius = 14
            view.layer.borderColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 0.2).cgColor
            view.layer.borderWidth = 1
            return view
        }()
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.height.equalTo(76)
            make.left.equalTo(leftImage!.snp.right).inset(-10)
            make.right.equalToSuperview().inset(15)
            make.centerY.equalTo(leftImage!.snp.centerY)
        }
        
        onTextFieldLabel = {
            let label = UILabel()
            label.text = "Total Balance"
            label.textColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 0.7)
            label.font = .systemFont(ofSize: 13, weight: .regular)
            return label
        }()
        centerView.addSubview(onTextFieldLabel!)
        onTextFieldLabel?.snp.makeConstraints({ make in
            make.left.top.equalToSuperview().inset(17)
        })
        
        textField = {
            let textField = UITextField()
            textField.placeholder = "Text"
            textField.borderStyle = .none
            textField.textColor = .black
            textField.keyboardType = .numberPad

            return textField
        }()
        centerView.addSubview(textField!)
        textField?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(17)
            make.top.equalTo(onTextFieldLabel!.snp.bottom)
            make.bottom.equalToSuperview().inset(7)
        })
        
        
        let saveButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Save", for: .normal)
            button.setTitleColor(.mainText, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
            button.backgroundColor = .OC
            button.layer.cornerRadius = 14
            return button
        }()
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(35)
        }
        saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        
        loadData()
    }
    
    
    @objc func saveData() {
        
        var value = textField?.text
        
        switch tag {
        case 1:
            var textString = "$\(value ?? "")"
            UserDefaults.standard.setValue(textString, forKey: "1")
        case 2:
            var textString = "$\(value ?? "")"
            UserDefaults.standard.setValue(textString, forKey: "2")
        case 3:
            var textString = "\(value ?? "") minutes"
            UserDefaults.standard.setValue(textString, forKey: "3")
        case 4:
            var textString = "$\(value ?? "")"
            UserDefaults.standard.setValue(textString, forKey: "4")
        case 5:
            UserDefaults.standard.setValue(value, forKey: "5")
        default:
            return
        }
        self.dismiss(animated: true)
    }
    
    
    @objc func closeVC() {
        self.dismiss(animated: true)
    }
    
    @objc func hideKeyboard() {
        textField?.endEditing(true)
    }

   
}
