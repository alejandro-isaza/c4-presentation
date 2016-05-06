//  Copyright © 2016 JABT Labs. All rights reserved.

import Foundation
import C4

class C4StudioMovieViewController: CanvasController {
    var movie: Movie?

    override func setup() {
        movie = Movie("C4Studio.mov")
        movie?.constrainsProportions = true
        movie?.width = canvas.width
        movie?.center = canvas.center
        canvas.add(movie)
    }

    override func viewDidAppear(animated: Bool) {
        movie?.play()
    }

    override func viewDidDisappear(animated: Bool) {
        movie?.stop()
    }
}