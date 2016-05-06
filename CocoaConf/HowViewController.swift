//  Copyright © 2016 JABT Labs. All rights reserved.

import C4
import UIKit

class HowViewController: CanvasController {
    @IBOutlet weak var label: UILabel!

    let font = Font(name: "Avenir", size: 30)!
    var shape: TextShape!
    var current = -1
    var before = false
    var tap: UITapGestureRecognizer!
    var pan: UIPanGestureRecognizer!
    weak var pageViewController: MainViewController!

    override func setup() {
        tap = canvas.addTapGestureRecognizer { _, location, _ in
            if location.x > self.canvas.center.x {
                self.next()
            } else {
                self.prev()
            }
        }

        canvas.addLongPressGestureRecognizer { locations, center, state in
            if state == .Began {
                var vcs = self.pageViewController.pageViewController(self.pageViewController, viewControllerAfterViewController: self.pageViewController.viewControllers!.first!)!
                var direction = UIPageViewControllerNavigationDirection.Forward
                if center.x < self.canvas.center.x {
                    direction = .Reverse
                    vcs = self.pageViewController.pageViewController(self.pageViewController, viewControllerBeforeViewController: self.pageViewController.viewControllers!.first!)!
                }
                self.pageViewController.setViewControllers([vcs], direction: direction, animated: true, completion: nil)
            }
        }

        pan = canvas.addPanGestureRecognizer { (locations, center, translation, velocity, state) in
            if state == .Began {
                for location in locations {
                    ShapeLayer.disableActions = true
                    let c = Circle(center: location, radius: 25)
                    self.canvas.add(c)
                    ShapeLayer.disableActions = false

                    let a = ViewAnimation(duration: 0.5) {
                        c.center += Vector(x: velocity.x / 10.0, y: velocity.y / 10.0)
                        c.opacity = 0.0
                        c.lineWidth = 50.0
                    }

                    a.addCompletionObserver() {
                        c.removeFromSuperview()
                    }
                    a.animate()
                }
            }
        }


    }

    func prev() {
        if before {
            before = false
            current -= 1
        } else {
            before = true
        }
        load()
    }

    func next() {
        if before {
            before = false
        } else {
            current += 1
            before = true
        }
        load()
    }

    func load() {
        let bundle = NSBundle.mainBundle()
        guard let url = bundle.URLForResource("example\(current)_\(before ? "before" : "after")", withExtension: "rtf") else {
            label.attributedText = nil
            current = -1
            before = false
            return
        }
        guard let string = try? NSAttributedString(URL: url, options: [:], documentAttributes: nil) else {
            label.attributedText = nil
            current = -1
            before = false
            return
        }
        label.attributedText = string

    }
}
