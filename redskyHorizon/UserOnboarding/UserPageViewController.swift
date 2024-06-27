import UIKit

class UserPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
           super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    lazy var viewControllerList: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = OneUserViewController()
        let vc2 = TwoUserViewController()
        
        return [vc1, vc2]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self

        if let firstViewController = viewControllerList.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    
    func goToNextPage() {
        guard let currentViewController = viewControllers?.first else { return }
        guard let nextViewController = pageViewController(self, viewControllerAfter: currentViewController) else { return }
        
        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        guard viewControllerList.count > previousIndex else { return nil }
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard viewControllerList.count > nextIndex else { return nil }
        
        return viewControllerList[nextIndex]
    }
}
