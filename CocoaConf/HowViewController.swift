//  Copyright © 2016 JABT Labs. All rights reserved.

import C4
import UIKit

class HowViewController: CanvasController {
    @IBOutlet weak var label: UILabel!

    let font = Font(name: "Avenir", size: 30)!
    var shape: TextShape!
    var current = -1
    var before = false

    override func setup() {
        canvas.addTapGestureRecognizer { _, location, _ in
            if location.x > self.canvas.center.x {
                self.next()
            } else {
                self.prev()
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
