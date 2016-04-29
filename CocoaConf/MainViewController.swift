//  Copyright © 2016 JABT Labs. All rights reserved.

import UIKit

class MainViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    let pages = ["Intro", "What", "How", "More"]

    lazy var contentViewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        for identifier in self.pages {
            viewControllers.append(self.storyboard!.instantiateViewControllerWithIdentifier(identifier))
        }
        return viewControllers
    }()

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
