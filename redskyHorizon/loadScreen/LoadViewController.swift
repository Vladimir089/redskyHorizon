//
//  LoadViewController.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 25.06.2024.
//

import UIKit
import SnapKit

class LoadViewController: UIViewController {
    
    var progresBar: UIProgressView?
    var timer: Timer?
    var progressValue: Float = 0.0
    let targetProgress: Float = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .BG
        createInterface()
    }
    
    
    func createInterface() {
        
        let imageView: UIImageView = {
            let image:UIImage = .logo
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        
        progresBar = {
            let progres = UIProgressView(progressViewStyle: .bar)
            progres.trackTintColor = .SC
            progres.progressTintColor = .OC
            progres.layer.cornerRadius = 7
            progres.clipsToBounds = true
            progres.setProgress(0.0, animated: true)
            return progres
        }()
        view.addSubview(progresBar!)
        progresBar?.snp.makeConstraints({ make in
            make.height.equalTo(11)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        })
        startTimer()
    }
    
    func startTimer() {
        let duration: TimeInterval = 1.0 //ВРЕМЯ ЗАГРУЗКИ МЕНЯТЬ МЕНЯЕМ
        let stepValue: Float = 1.0 / Float(duration / 0.1)
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.progressValue += stepValue
            DispatchQueue.main.async { [self] in
                UIView.animate(withDuration: 0.1) {
                    self.progresBar?.setProgress(self.progressValue, animated: true)
                }
                if progressValue >= targetProgress {
                    timer.invalidate()
                    if isBet == true {
                        print("Тут выполняем переход к веб")
                    } else {
                        self.navigationController?.setViewControllers([OneUserViewController()], animated: true)
                    }
                }
            }
        }
    }

   

}



extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
