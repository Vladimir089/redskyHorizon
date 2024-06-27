//
//  DetailViewController.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 27.06.2024.
//

import UIKit
import SnapKit

protocol DetailViewControllerDelegate: AnyObject {
    func saveCourse(course: [Course])
}

class DetailViewController: UIViewController {
    
    weak var delegate: YouCoursesViewControllerDelegate?
    weak var secondDelagate: MainDashboardViewControllerDelegate?
    var index: Int?
    
    // UI
    var scrollView: UIScrollView?
    
    var statuslabel, nameLabel: UILabel?
    var durationLabel, dateLabel: UILabel?
    var descrLabel: UILabel?
    
    var botView: UIView?
    var catlabel, ketLabel: UILabel?
    
    // Next
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
        title = courses[index ?? 0].name.count > 50 ? String(courses[index ?? 0].name.prefix(20)) + "..." : courses[index ?? 0].name
        configureNavigationBar()
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .BG
        createInterface()
    }
    
    
    func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .BG
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.tintColor = UIColor.OC
    }
    
    
    func createInterface() {
        
        scrollView = UIScrollView()
        view.addSubview(scrollView!)
        scrollView?.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
        }
        
        let contentView = UIView()
        scrollView?.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        statuslabel = {
            let label = UILabel()
            label.text = courses[index ?? 0].status
            if courses[index ?? 0].status == "Active" {
                label.textColor = .OC
            } else {
                label.textColor = .SC.withAlphaComponent(1)
            }
            label.font = .systemFont(ofSize: 17, weight: .semibold)
            return label
        }()
        contentView.addSubview(statuslabel!)
        statuslabel?.snp.makeConstraints({ make in
            make.left.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(20) // changed from view.safeAreaLayoutGuide.snp.top
        })
        
        nameLabel = {
            let label = UILabel()
            label.text = courses[index ?? 0].name
            label.numberOfLines = 2
            label.font = .systemFont(ofSize: 28, weight: .regular)
            label.textColor = .SC.withAlphaComponent(1)
            label.textAlignment = .left
            return label
        }()
        contentView.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo((statuslabel ?? UIView()).snp.bottom).inset(-5)
        })
        
        let imageView: UIImageView = {
            let image: UIImage = .clock.resize(targetSize: CGSize(width: 40, height: 40))
            let imageView = UIImageView(image: image)
            return imageView
        }()
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.left.equalToSuperview().inset(15)
            make.top.equalTo((nameLabel ?? UILabel()).snp.bottom).inset(-15)
        }
        
        let textDurationlabel: UILabel = {
            let label = UILabel()
            label.textColor = .OC
            label.text = "Duration"
            label.font = .systemFont(ofSize: 13, weight: .regular)
            return label
        }()
        contentView.addSubview(textDurationlabel)
        textDurationlabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).inset(-10)
            make.top.equalTo(imageView.snp.top).inset(2)
        }
        
        durationLabel = {
            let label = UILabel()
            label.textColor = .SC.withAlphaComponent(0.7)
            label.text = courses[index ?? 0].duration
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 13, weight: .regular)
            return label
        }()
        contentView.addSubview(durationLabel!)
        durationLabel?.snp.makeConstraints({ make in
            make.left.equalTo(imageView.snp.right).inset(-10)
            make.bottom.equalTo(imageView.snp.bottom).inset(2)
            make.width.equalTo(100)
        })
        
        dateLabel = {
            let label = UILabel()
            label.textColor = .SC.withAlphaComponent(0.7)
            label.text = courses[index ?? 0].creationDate
            label.font = .systemFont(ofSize: 13, weight: .semibold)
            label.textAlignment = .right
            return label
        }()
        contentView.addSubview(dateLabel!)
        dateLabel?.snp.makeConstraints({ make in
            make.right.equalToSuperview().inset(15)
            make.bottom.equalTo((durationLabel ?? UIView()).snp.bottom)
            make.left.equalTo((durationLabel ?? UILabel()).snp.right).inset(-15)
        })
        
        let separator: UIView = {
            let view = UIView()
            view.backgroundColor = .SC.withAlphaComponent(0.3)
            return view
        }()
        contentView.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo((dateLabel ?? UILabel()).snp.bottom).inset(-15)
        }
        
        descrLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 15, weight: .regular)
            label.textColor = .SC.withAlphaComponent(1)
            label.text = courses[index ?? 0].description
            label.numberOfLines = 0
            return label
        }()
        contentView.addSubview(descrLabel!)
        descrLabel?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(separator.snp.bottom).inset(-15)
        })
        
        botView = {
            let view = UIView()
            view.backgroundColor = .SC.withAlphaComponent(0.1)
            view.layer.cornerRadius = 14
            return view
        }()
        contentView.addSubview(botView!)
        botView?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo((descrLabel ?? UILabel()).snp.bottom).inset(-15)
        })
        
        let catTextLabel: UILabel = {
            let label = UILabel()
            label.text = "Category"
            label.textColor = .SC.withAlphaComponent(0.5)
            label.font = .systemFont(ofSize: 13, weight: .regular)
            return label
        }()
        botView?.addSubview(catTextLabel)
        catTextLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(15)
        }
        
        catlabel = {
            let label = UILabel()
            label.text = courses[index ?? 0].category
            label.font = .systemFont(ofSize: 17, weight: .semibold)
            label.textColor = .SC.withAlphaComponent(1)
            label.textAlignment = .left
            label.numberOfLines = 0
            return label
        }()
        botView?.addSubview(catlabel!)
        catlabel?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(catTextLabel.snp.bottom).inset(-5)
        })
        
        let secondSeparatorView: UIView = {
            let view = UIView()
            view.backgroundColor = .SC.withAlphaComponent(0.3)
            return view
        }()
        botView?.addSubview(secondSeparatorView)
        secondSeparatorView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo((catlabel ?? UILabel()).snp.bottom).inset(-15)
        }
        
        let keyTextLabel: UILabel = {
            let label = UILabel()
            label.text = "Key Concept"
            label.textColor = .SC.withAlphaComponent(0.5)
            label.font = .systemFont(ofSize: 13, weight: .regular)
            return label
        }()
        botView?.addSubview(keyTextLabel)
        keyTextLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.top.equalTo(secondSeparatorView.snp.bottom).inset(-15)
        }
        
        ketLabel = {
            let label = UILabel()
            label.text = courses[index ?? 0].keyConcepts
            label.font = .systemFont(ofSize: 17, weight: .semibold)
            label.textColor = .SC.withAlphaComponent(1)
            label.textAlignment = .left
            label.numberOfLines = 0
            return label
        }()
        botView?.addSubview(ketLabel!)
        ketLabel?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(keyTextLabel.snp.bottom).inset(-5)
            make.bottom.equalToSuperview().inset(15)
        })
        
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(botView!.snp.bottom).offset(100)
        }
        
        
        let delButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = .OC
            button.layer.cornerRadius = 14
            button.setImage(UIImage.trash.resize(targetSize: CGSize(width: 20, height: 22)), for: .normal)
            button.tintColor = .SC.withAlphaComponent(1)
            return button
        }()
        view.addSubview(delButton)
        delButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalToSuperview().inset(15)
        }
        delButton.addTarget(self, action: #selector(del), for: .touchUpInside)
        
        let saveButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = .OC
            button.layer.cornerRadius = 14
            button.setTitle("Edit", for: .normal)
            button.tintColor = .SC.withAlphaComponent(1)
            button.setTitleColor(.SC.withAlphaComponent(1), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
            return button
        }()
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalTo(delButton.snp.right).inset(-15)
            make.right.equalToSuperview().inset(15)
            make.centerY.equalTo(delButton)
        }
        saveButton.addTarget(self, action: #selector(openEdit), for: .touchUpInside)
        
        
    }
    
    @objc func del() {
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            if let index = self?.index {
                courses.remove(at: index)
                self?.navigationController?.popToRootViewController(animated: true)
                self?.delegate?.updateInterface(cours: courses)
                self?.secondDelagate?.updateTable(cours: courses)
            }
        }
        let cancelAction = UIAlertAction(title: "Close", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @objc func openEdit() {
        let vc = workCourseViewController()
        vc.secondDelegate = self
        vc.isNew = false
        vc.index = index ?? 0
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}


extension DetailViewController: DetailViewControllerDelegate {
    
    func saveCourse(course: [Course]) {
        delegate?.updateInterface(cours: course)
        secondDelagate?.updateTable(cours: course)
        
        nameLabel?.text = courses[index ?? 0].name
        statuslabel?.text = courses[index ?? 0].status
        durationLabel?.text = courses[index ?? 0].duration
        dateLabel?.text = courses[index ?? 0].creationDate
        descrLabel?.text = courses[index ?? 0].description
        catlabel?.text = courses[index ?? 0].category
        ketLabel?.text = courses[index ?? 0].keyConcepts
        title = courses[index ?? 0].name
        
        if courses[index ?? 0].status == "Active" {
            statuslabel?.textColor = .OC
        } else {
            statuslabel?.textColor = .SC.withAlphaComponent(1)
        }
    }
    
    
    
    
}
