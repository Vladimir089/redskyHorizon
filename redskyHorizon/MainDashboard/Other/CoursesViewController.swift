//
//  CoursesViewController.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 25.06.2024.
//

import UIKit

class CoursesViewController: UIViewController {
    
    var selectedItem: Int?
    var saveButton: UIButton?
    var tapNumb = 1
    weak var delegate: MainDashboardViewControllerDelegate?
    
    let arr = [(UIImage.usd, "USD", "US Dollar", "$"), (UIImage.eur, "EUR", "Euro", "€"),
               (UIImage.jpy, "JPY", "Japanse yen", "¥"), (UIImage.chf, "CHF", "Swiss franc", "₣"),
               (UIImage.try, "TRY", "Turkish lira", "₺"), (UIImage.kzt, "KZT", "Kazakhstani tenge", "₸"),
               (UIImage.gbp, "GBP", "Pound sterling", "£"), (UIImage.thb, "THB", "Thai baht", "฿")]
    
    var selectButton: UIButton?
    var collectionView: UICollectionView?
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.black
        
        if UserDefaults.standard.object(forKey: "selected") != nil {
            selectedItem = UserDefaults.standard.object(forKey: "selected") as? Int
        } else {
            selectedItem = 0
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Currency"
        createInterface()
    }
    
    
    func createInterface() {
        view.backgroundColor = .BG
        
        
        let orangeView: UIView = {
            let view = UIView()
            view.backgroundColor = .OC
            return view
        }()
        view.addSubview(orangeView)
        orangeView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        collectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            collectionView.backgroundColor = .clear
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.showsVerticalScrollIndicator = false
            return collectionView
        }()
        view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
            make.top.equalTo(orangeView.snp.bottom)
        })
        
        
        saveButton = {
            let buttom = UIButton(type: .system)
            buttom.setTitle("Select", for: .normal)
            buttom.setTitleColor(.SC.withAlphaComponent(1), for: .normal)
            buttom.backgroundColor = .OC
            buttom.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
            buttom.layer.cornerRadius = 14
            return buttom
        }()
        view.addSubview(saveButton!)
        saveButton?.snp.makeConstraints({ make in
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(30)
        })
        saveButton?.addTarget(self, action: #selector(saveButAction), for: .touchUpInside)
        
    }
    
    
    
    @objc func saveButAction() {
        tapNumb += 1
        
        if tapNumb == 1 {
            saveButton?.setTitle("Select", for: .normal)
            
        }
        if tapNumb == 2 {
            saveButton?.setTitle("Approve", for: .normal)
        }
        if tapNumb == 3 {
            print(234)
            tapNumb = 1
            UserDefaults.standard.setValue(selectedItem, forKey: "selected")
            saveButton?.setTitle("Saved", for: .normal)
            self.saveButton?.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                UIView.animate(withDuration: 0.5) {
                    self.saveButton?.setTitle("Select", for: .normal)
                    self.saveButton?.isUserInteractionEnabled = true
                }
            }
            delegate?.updateDollar(symbol: arr[selectedItem ?? 0].3)
        }
        
    }

}


extension CoursesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.subviews.forEach { $0.removeFromSuperview() }
        cell.layer.cornerRadius = 14
        if indexPath.row != arr.count {
            
            if indexPath.row == selectedItem {
                cell.backgroundColor = .OC
                cell.layer.borderColor = UIColor.OC.cgColor
            } else {
                cell.backgroundColor = .SC.withAlphaComponent(1)
                cell.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
                cell.layer.borderWidth = 1
            }
            
            
            let imageView: UIImageView = {
                let image = arr[indexPath.row].0
                let imageView = UIImageView(image: image.resize(targetSize: CGSize(width: 16, height: 16)))
                return imageView
            }()
            cell.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.height.width.equalTo(16)
                make.left.equalToSuperview().inset(15)
            }
            
            let labelName: UILabel = {
                let label = UILabel()
                label.text = arr[indexPath.row].1
                label.font = .systemFont(ofSize: 14, weight: .semibold)
                if indexPath.row == selectedItem {
                    label.textColor = UIColor.SC.withAlphaComponent(1)
                } else {
                    label.textColor = .black
                }
                return label
            }()
            cell.addSubview(labelName)
            labelName.snp.makeConstraints { make in
                make.left.equalTo(imageView.snp.right).inset(-10)
                make.bottom.equalTo(imageView.snp.centerY).inset(-5)
            }
            
            let psLabel: UILabel = {
                let label = UILabel()
                label.text = arr[indexPath.row].2
                label.font = .systemFont(ofSize: 12, weight: .regular)
                if indexPath.row == selectedItem {
                    label.textColor = .white.withAlphaComponent(0.5)
                } else {
                    label.textColor = .black.withAlphaComponent(0.7)
                }
                return label
            }()
            cell.addSubview(psLabel)
            psLabel.snp.makeConstraints { make in
                make.left.equalTo(imageView.snp.right).inset(-10)
                make.top.equalTo(imageView.snp.centerY).inset(5)
            }
            
            let symbolLabel: UILabel = {
                let label = UILabel()
                label.text = arr[indexPath.row].3
                label.font = .systemFont(ofSize: 12, weight: .regular)
                if indexPath.row == selectedItem {
                    label.textColor = .SC.withAlphaComponent(1)
                } else {
                    label.textColor = .black
                }
                return label
            }()
            cell.addSubview(symbolLabel)
            symbolLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(15)
            }
            
            
            
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == arr.count  {
            return CGSize(width: 0, height: 66)
        } else {
            return CGSize(width: collectionView.frame.width, height: 66)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let oldItem: Int = selectedItem ?? 0
        selectedItem = indexPath.row
        collectionView.reloadItems(at: [indexPath])
        for i in 0..<arr.count {
            if oldItem == i {
                let oldIndexPath = IndexPath(item: oldItem, section: 0)
                collectionView.reloadItems(at: [oldIndexPath])
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0) // Отступ сверху для первой ячейки
        }
    
}
