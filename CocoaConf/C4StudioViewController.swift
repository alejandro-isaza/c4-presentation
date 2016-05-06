//  Copyright © 2016 JABT Labs. All rights reserved.

import Foundation
import C4

class C4StudioViewController: CanvasController {
    let images = [Image("C4StudioLogo")!, Image("C4StudioScreen")!, Image("C4StudioSketch")!]
    var currentIndex = 0
    override func setup() {
        for image in images {
            image.center = canvas.center
            canvas.add(image)
            if image != images.first {
                image.hidden = true
            }
        }
        canvas.addTapGestureRecognizer { (locations, center, state) in
            self.currentIndex += 1
            if self.currentIndex == self.images.count {
                self.currentIndex = 0
                self.images[1].hidden = true
                self.images[2].hidden = true
            }
            self.images[self.currentIndex].hidden = false
        }
    }
}