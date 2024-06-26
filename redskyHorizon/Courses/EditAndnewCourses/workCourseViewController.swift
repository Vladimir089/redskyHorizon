//
//  workCourseViewController.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 26.06.2024.
//

import UIKit

class workCourseViewController: UIViewController {
    
    var isNew: Bool?
    var course: Course?
    var index: Int?

    weak var delegate: YouCoursesViewControllerDelegate?
    weak var secondDelegate: DetailViewControllerDelegate?
    
    
    //UI
    var contentView: UIView?
    var onePlaceLabel, twoPlaceLabel: UILabel?
    var scrollView: UIScrollView?
    var saveButton: UIButton?
    var titleTextField, categoryTextField, creationTextField, durationTextField: UITextField?
    var statusButton: UIButton?
    var descriptionText, keyText: UITextView?
    var isKeyboardShown = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavBar()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .OC
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.tintColor = UIColor.white
    }
    
    
    
    func settingNavBar() {
        showNavigationBar()
        if isNew == true {
            title = "Add Course"
        } else {
            title = "Edit"
        }
        createInterface()
    }
    
    func createInterface() {
        view.backgroundColor = .BG
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
        
        let orangeViewTop: UIView = {
            let view = UIView()
            view.backgroundColor = .OC
            return view
        }()
        view.addSubview(orangeViewTop)
        orangeViewTop.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        scrollView = UIScrollView()
        view.addSubview(scrollView!)
        scrollView?.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(orangeViewTop.snp.bottom)
        }
        contentView = UIView()
        scrollView!.addSubview(contentView!)
        contentView!.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        var topView: UIView = {
            let view = UIView()
            view.backgroundColor = .white.withAlphaComponent(0.1)
            view.layer.cornerRadius = 14
            return view
        }()
        scrollView?.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(15)
            make.height.equalTo(380)
        }
        
        
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 0
            stack.distribution = .fillEqually
            return stack
        }()
        topView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        //MARK: -MID VIEW
        
        let titleView: UIView = {
            let view = UIView()
            let titleStringLabel = createLabels(text: "Title")
            view.addSubview(titleStringLabel)
            titleStringLabel.snp.makeConstraints { make in
                make.left.top.equalToSuperview().inset(15)
            }
            titleTextField = {
                let textField = UITextField()
                textField.textColor = .SC.withAlphaComponent(1)
                textField.borderStyle = .none
                textField.attributedPlaceholder = NSAttributedString(
                    string: "Text",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
                    
                )
                textField.delegate = self
                textField.font = .systemFont(ofSize: 17, weight: .semibold)
                return textField
            }()
            view.addSubview(titleTextField!)
            titleTextField?.snp.makeConstraints({ make in
                make.left.right.equalToSuperview().inset(15)
                make.top.equalTo(titleStringLabel.snp.bottom).inset(-5)
            })
            let separatorView = UIView()
            separatorView.backgroundColor = .SC.withAlphaComponent(0.2)
            view.addSubview(separatorView)
            separatorView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(0.5)
                make.bottom.equalToSuperview()
            }
            return view
        }()
        
        stackView.addArrangedSubview(titleView)
        
        
        let categoryView: UIView = {
            let view = UIView()
            let titleStringLabel = createLabels(text: "Category")
            view.addSubview(titleStringLabel)
            titleStringLabel.snp.makeConstraints { make in
                make.left.top.equalToSuperview().inset(15)
            }
            categoryTextField = {
                let textField = UITextField()
                textField.textColor = .SC.withAlphaComponent(1)
                textField.borderStyle = .none
                textField.attributedPlaceholder = NSAttributedString(
                    string: "Text",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
                )
                textField.delegate = self
                textField.font = .systemFont(ofSize: 17, weight: .semibold)
                return textField
            }()
            view.addSubview(categoryTextField!)
            categoryTextField?.snp.makeConstraints({ make in
                make.left.right.equalToSuperview().inset(15)
                make.top.equalTo(titleStringLabel.snp.bottom).inset(-5)
            })
            let separatorView = UIView()
            separatorView.backgroundColor = .SC.withAlphaComponent(0.5)
            view.addSubview(separatorView)
            separatorView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(0.5)
                make.bottom.equalToSuperview()
            }
            return view
        }()
        
        stackView.addArrangedSubview(categoryView)
        
        
        let creationDateView: UIView = {
            let view = UIView()
            let titleStringLabel = createLabels(text: "Creation Date")
            view.addSubview(titleStringLabel)
            titleStringLabel.snp.makeConstraints { make in
                make.left.top.equalToSuperview().inset(15)
            }
            creationTextField = {
                let textField = UITextField()
                textField.textColor = UIColor(named: "SC")?.withAlphaComponent(1) ?? .black
                textField.borderStyle = .none
                textField.attributedPlaceholder = NSAttributedString(
                    string: "Text",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
                )
                textField.font = .systemFont(ofSize: 17, weight: .semibold)
                let datePicker = UIDatePicker()
                datePicker.datePickerMode = .date
                if #available(iOS 13.4, *) {
                    datePicker.preferredDatePickerStyle = .wheels
                }
                datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
                let toolbar = UIToolbar()
                toolbar.sizeToFit()
                let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
                toolbar.setItems([doneButtonItem], animated: false)
                textField.delegate = self
                textField.inputView = datePicker
                textField.inputAccessoryView = toolbar
                
                return textField
            }()
            view.addSubview(creationTextField!)
            creationTextField?.snp.makeConstraints({ make in
                make.left.right.equalToSuperview().inset(15)
                make.top.equalTo(titleStringLabel.snp.bottom).inset(-5)
            })
            let separatorView = UIView()
            separatorView.backgroundColor = UIColor(named: "SC")?.withAlphaComponent(0.2) ?? .gray
            view.addSubview(separatorView)
            separatorView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(0.5)
                make.bottom.equalToSuperview()
            }
            return view
        }()
        
        stackView.addArrangedSubview(creationDateView)
        
        
        
        let statusView: UIView = {
            let view = UIView()
            let titleStringLabel = createLabels(text: "Status")
            view.addSubview(titleStringLabel)
            titleStringLabel.snp.makeConstraints { make in
                make.left.top.equalToSuperview().inset(15)
            }
            statusButton = {
                let button = UIButton(type: .system)
                button.setTitle("Active", for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
                button.setTitleColor(.OC, for: .normal)
                button.contentHorizontalAlignment = .left
                return button
            }()
            view.addSubview(statusButton!)
            statusButton?.snp.makeConstraints({ make in
                make.left.right.equalToSuperview().inset(15)
                make.top.equalTo(titleStringLabel.snp.bottom).inset(-2)
            })
            statusButton!.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
            
            let imageView: UIImageView = {
                let image = UIImage(systemName: "chevron.up.chevron.down")?.resize(targetSize: CGSize(width: 14, height: 20))
                let tintedImage = image?.withTintColor(.white.withAlphaComponent(0.5), renderingMode: .alwaysTemplate)
                let imageView = UIImageView(image: tintedImage)
                imageView.tintColor = .white.withAlphaComponent(0.5)
                return imageView
            }()
            
            statusButton!.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.height.equalTo(20)
                make.width.equalTo(14)
                make.centerY.equalToSuperview()
                make.right.equalToSuperview()
            }
            
            
            
            let separatorView = UIView()
            separatorView.backgroundColor = .SC.withAlphaComponent(0.2)
            view.addSubview(separatorView)
            separatorView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(0.5)
                make.bottom.equalToSuperview()
            }
            return view
        }()
        
        stackView.addArrangedSubview(statusView)
        
        
        let durationView: UIView = {
            let view = UIView()
            let titleStringLabel = createLabels(text: "Duration")
            view.addSubview(titleStringLabel)
            titleStringLabel.snp.makeConstraints { make in
                make.left.top.equalToSuperview().inset(15)
            }
            durationTextField = {
                let textField = UITextField()
                textField.textColor = .SC.withAlphaComponent(1)
                textField.borderStyle = .none
                textField.attributedPlaceholder = NSAttributedString(
                    string: "Text",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
                )
                textField.delegate = self
                textField.font = .systemFont(ofSize: 17, weight: .semibold)
                return textField
            }()
            view.addSubview(durationTextField!)
            durationTextField?.snp.makeConstraints({ make in
                make.left.right.equalToSuperview().inset(15)
                make.top.equalTo(titleStringLabel.snp.bottom).inset(-5)
            })
            
            return view
        }()
        
        stackView.addArrangedSubview(durationView)
        
        
        //MARK: -BOT VIEW
        
        var botView: UIView = {
            let view = UIView()
            view.backgroundColor = .white.withAlphaComponent(0.1)
            view.layer.cornerRadius = 14
            return view
        }()
        scrollView?.addSubview(botView)
        botView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(topView.snp.bottom).inset(-15)
        }
        
        
        let descView: UIView = {
            let view = UIView()
            let titleStringLabel = createLabels(text: "Description")
            view.addSubview(titleStringLabel)
            titleStringLabel.snp.makeConstraints { make in
                make.left.top.equalToSuperview().inset(15)
            }
            descriptionText = {
                let textView = UITextView()
                textView.delegate = self
                textView.textColor = UIColor(named: "SC")?.withAlphaComponent(1)
                textView.font = .systemFont(ofSize: 17, weight: .semibold)
                textView.isScrollEnabled = false // Отключаем прокрутку
                textView.backgroundColor = .clear
                
                // Placeholder
                onePlaceLabel = UILabel()
                onePlaceLabel?.text = "Text"
                onePlaceLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
                onePlaceLabel?.textColor = UIColor.white.withAlphaComponent(0.5)
                textView.addSubview(onePlaceLabel!)
                onePlaceLabel?.snp.makeConstraints { make in
                    make.centerY.equalTo(textView)
                    make.left.equalTo(textView.snp.left)
                }
                
                
                
                if textView.text.isEmpty {
                    onePlaceLabel?.isHidden = false
                } else {
                    onePlaceLabel?.isHidden = true
                }
                
                return textView
            }()
            view.addSubview(descriptionText!)
            descriptionText?.snp.makeConstraints({ make in
                make.left.right.equalToSuperview().inset(15)
                make.top.equalTo(titleStringLabel.snp.bottom).offset(2)
                make.bottom.equalToSuperview().offset(-1)
            })
            let separatorView = UIView()
            separatorView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            view.addSubview(separatorView)
            separatorView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(0.5)
                make.bottom.equalToSuperview()
            }
            return view
        }()
        
        botView.addSubview(descView)
        descView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        let keyView: UIView = {
            let view = UIView()
            let titleStringLabel = createLabels(text: "Key Concepts")
            view.addSubview(titleStringLabel)
            titleStringLabel.snp.makeConstraints { make in
                make.left.top.equalToSuperview().inset(15)
            }
            keyText = {
                let textView = UITextView()
                textView.delegate = self
                textView.textColor = UIColor(named: "SC")?.withAlphaComponent(1)
                textView.font = .systemFont(ofSize: 17, weight: .semibold)
                textView.isScrollEnabled = false // Отключаем прокрутку
                textView.backgroundColor = .clear
                
                // Placeholder
                twoPlaceLabel = UILabel()
                twoPlaceLabel?.text = "Text"
                twoPlaceLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
                twoPlaceLabel?.textColor = UIColor.white.withAlphaComponent(0.5)
                textView.addSubview(twoPlaceLabel!)
                twoPlaceLabel?.snp.makeConstraints { make in
                    make.centerY.equalTo(textView)
                    make.left.equalTo(textView.snp.left)
                }
                
                
                if textView.text.isEmpty {
                    twoPlaceLabel?.isHidden = false
                } else {
                    twoPlaceLabel?.isHidden = true
                }
                
                return textView
            }()

            view.addSubview(keyText!)
            keyText?.snp.makeConstraints({ make in
                make.left.right.equalToSuperview().inset(15)
                make.top.equalTo(titleStringLabel.snp.bottom).offset(2)
                make.bottom.equalToSuperview().offset(-1)
            })
            
            return view
        }()
        
        botView.addSubview(keyView)
        keyView.snp.makeConstraints { make in
            make.top.equalTo(descView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        
        let botHeightView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }()
        contentView!.addSubview(botHeightView)
        botHeightView.snp.makeConstraints { make in
            make.top.equalTo(botView.snp.bottom)
            make.height.equalTo(65)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        saveButton = {
            let button = UIButton(type: .system)
            button.setTitle("Add", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
            button.backgroundColor = .OC
            button.layer.cornerRadius = 14
            button.setTitleColor(.SC.withAlphaComponent(1), for: .normal)
            button.setTitleColor(.SC.withAlphaComponent(0.5), for: .disabled)
            button.isEnabled = false
            return button
        }()
        view.addSubview(saveButton!)
        saveButton?.snp.makeConstraints({ make in
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(25)
        })
        
        settingsView()
    }
    
    
    func updateSaveButtonState() {
        let titleText = titleTextField?.text ?? ""
        let categoryText = categoryTextField?.text ?? ""
        let creationDateText = creationTextField?.text ?? ""
        let durationText = durationTextField?.text ?? ""
        let descriptionText = descriptionText?.text ?? ""
        let keyConceptsText = keyText?.text ?? ""

        let formIsComplete = !titleText.isEmpty && !categoryText.isEmpty && !creationDateText.isEmpty && !durationText.isEmpty && !descriptionText.isEmpty && !keyConceptsText.isEmpty

        saveButton?.isEnabled = formIsComplete
    }
    
    
    func settingsView() {
        switch isNew {
        case false:
            titleTextField?.text = courses[index ?? 0].name
            categoryTextField?.text = courses[index ?? 0].category
            creationTextField?.text = courses[index ?? 0].creationDate
            statusButton?.setTitle(courses[index ?? 0].status, for: .normal)
            durationTextField?.text = courses[index ?? 0].duration
            descriptionText?.text = courses[index ?? 0].description
            keyText?.text = courses[index ?? 0].keyConcepts
            saveButton?.setTitle("Save", for: .normal)
            onePlaceLabel?.isHidden = true
            twoPlaceLabel?.isHidden = true
            saveButton?.addTarget(self, action: #selector(editCourse), for: .touchUpInside)
        case true:
            saveButton?.setTitle("Add", for: .normal)
            saveButton?.addTarget(self, action: #selector(saveNewCourse), for: .touchUpInside)
        default:
            return
        }
    }
    
    
    func createLabels(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: objc
    
    @objc func editCourse() {
        let newCourse = Course(name: titleTextField?.text ?? "", category: categoryTextField?.text ?? "", creationDate: creationTextField?.text ?? "", status: statusButton?.titleLabel?.text ?? "", duration: durationTextField?.text ?? "", description: descriptionText?.text ?? "", keyConcepts: keyText?.text ?? "")
        
        courses[index ?? 0] = newCourse
        secondDelegate?.saveCourse(course: courses)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func saveNewCourse() {
        let newCourse = Course(name: titleTextField?.text ?? "", category: categoryTextField?.text ?? "", creationDate: creationTextField?.text ?? "", status: statusButton?.titleLabel?.text ?? "", duration: durationTextField?.text ?? "", description: descriptionText?.text ?? "", keyConcepts: keyText?.text ?? "")
        courses.insert(newCourse, at: 0)
       
        delegate?.updateInterface(cours: courses)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        creationTextField?.text = dateFormatter.string(from: sender.date)
        updateSaveButtonState()
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
        updateSaveButtonState()
    }
    
    @objc func hideKeyboard() {
        self.view.resignFirstResponder()
        self.view.endEditing(true)
        updateSaveButtonState()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        isKeyboardShown = true
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        isKeyboardShown = false
    }
    
    
    @objc func showMenu() {
        let option1Action = UIAction(title: "Active") { [weak self] _ in
            self?.statusButton?.setTitle("Active", for: .normal)
        }
        
        let option2Action = UIAction(title: "Inactive") { [weak self] _ in
            self?.statusButton?.setTitle("Inactive", for: .normal)
        }
        
        let menu = UIMenu(title: "", children: [option1Action, option2Action])
        
        if #available(iOS 14.0, *) {
            statusButton?.menu = menu
            statusButton?.showsMenuAsPrimaryAction = true
        } else {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let option1Action = UIAlertAction(title: "Active", style: .default) { [weak self] _ in
                self?.statusButton?.setTitle("Active", for: .normal)
            }
            
            let option2Action = UIAlertAction(title: "Inactive", style: .default) { [weak self] _ in
                self?.statusButton?.setTitle("Inactive", for: .normal)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            
            alertController.addAction(option1Action)
            alertController.addAction(option2Action)
            alertController.addAction(cancelAction)
            
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = statusButton
                popoverController.sourceRect = statusButton!.bounds
            }
            
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
}




extension workCourseViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        UIView.setAnimationsEnabled(false)
        view.layoutIfNeeded()
        UIView.setAnimationsEnabled(true)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        UIView.animate(withDuration: 0.2) {
            var contentInset = self.scrollView?.contentInset
            contentInset!.bottom = 400
            self.scrollView?.contentInset = contentInset!
            self.scrollView?.scrollIndicatorInsets = contentInset!
        }
        
        if textView == descriptionText {
            onePlaceLabel?.isHidden = true
        }
        if textView == keyText {
            twoPlaceLabel?.isHidden = true
        }
        updateSaveButtonState()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if isKeyboardShown == false {
            UIView.animate(withDuration: 0.2) {
                var contentInset = self.scrollView?.contentInset
                contentInset!.bottom = 400
                self.scrollView?.contentInset = .zero
                self.scrollView?.scrollIndicatorInsets = .zero
            }
        }
        
        if textView == descriptionText {
            if textView.text == "" {
                onePlaceLabel?.isHidden = false
            }
        }
        if textView == keyText {
            if textView.text == "" {
                twoPlaceLabel?.isHidden = false
            }
        }
        updateSaveButtonState()
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        updateSaveButtonState()
    }
    
    
}


extension workCourseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateSaveButtonState()
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateSaveButtonState()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        updateSaveButtonState()
        return true
    }
}
