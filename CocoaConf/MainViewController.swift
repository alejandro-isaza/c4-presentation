//  Copyright © 2016 JABT Labs. All rights reserved.

import UIKit

class MainViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    lazy var contentViewControllers: [UIViewController] = {
        return [
            self.createIntroViewController(),
            self.createWhatViewController()
        ]
    }()

    func createIntroViewController() -> UIViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("Intro")
    }

    func createWhatViewController() -> UIViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("What")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        setViewControllers([contentViewControllers.first!], direction: .Forward, animated: true, completion: nil)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }


    // MARK: - UIPageViewControllerDataSource

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let index = contentViewControllers.indexOf(viewController) else {
            return nil
        }
        if index <= 0 {
            return nil
        }
        return contentViewControllers[index - 1]
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let index = contentViewControllers.indexOf(viewController) else {
            return nil
        }
        if index >= contentViewControllers.count - 1 {
            return nil
        }
        return contentViewControllers[index + 1]
    }
}
