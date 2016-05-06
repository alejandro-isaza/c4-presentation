//
//  CosmosViewController.swift
//  CocoaConf
//
//  Created by travis on 2016-05-06.
//  Copyright © 2016 JABT Labs. All rights reserved.
//

import Foundation
import C4

class CosmosViewController: CanvasController {
    var movie: Movie?

    override func setup() {
        movie = Movie("cosmos.mp4")
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