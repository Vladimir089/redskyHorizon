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
            let progress = UIProgressView(progressViewStyle: .bar)
            
            progress.trackTintColor = .SC // Цвет трека
            progress.progressTintColor = .OC   // Цвет прогресса
            
            progress.layer.cornerRadius = 6
            progress.clipsToBounds = true
            progress.layer.sublayers?[1].cornerRadius = 6
            progress.subviews[1].clipsToBounds = true

            if let trackImage = UIImage(color: .SC, size: CGSize(width: 1, height: 11))?.roundedImage(radius: 6) {
                progress.trackImage = trackImage
            }

            if let progressImage = UIImage(color: .OC, size: CGSize(width: 1, height: 11))?.roundedImage(radius: 6) {
                progress.progressImage = progressImage
            }
            
            progress.setProgress(0.0, animated: true)
            
            return progress
        }()

        
//        progresBar = {
//            let progres = UIProgressView(progressViewStyle: .bar)
//            progres.trackTintColor = .SC
//            progres.progressTintColor = .OC
//            progres.layer.cornerRadius = 7
//            progres.clipsToBounds = true
//            progres.setProgress(0.0, animated: true)
//            
//            return progres
//        }()
        
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
        let duration: TimeInterval = 7 //ВРЕМЯ ЗАГРУЗКИ МЕНЯТЬ МЕНЯЕМ
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
                        //переход в веб
                    } else {
                        if (UserDefaults.standard.object(forKey: "tabBar") != nil) == true  {
                            self.navigationController?.setViewControllers([TabViewController()], animated: true)
                        } else {
                            self.navigationController?.setViewControllers([UserPageViewController()], animated: true)
                        }
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



extension UIImage {
    convenience init?(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func roundedImage(radius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
