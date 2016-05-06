//  Copyright © 2016 JABT Labs. All rights reserved.

import Foundation
import C4

class C4SiteViewController: CanvasController {
    
    override func setup() {
        let image = Image("c4site")
        image?.constrainsProportions = true
        image?.width = canvas.width
        image?.center = canvas.center
        canvas.add(image)
    }
}
