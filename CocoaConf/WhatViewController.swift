//  Copyright © 2016 JABT Labs. All rights reserved.

import C4

class WhatViewController: CanvasController {
    let π = M_PI
    let radius = 200.0
    let font = Font(name: "Avenir", size: 30)!

    var wedges = [Wedge]()

    override func setup() {
        buildWedges()

        let codeTitle = TextShape(text: "Code", font: font)
        codeTitle?.fillColor = black
        codeTitle?.center = canvas.center + Vector(x: radius, y: radius)
        canvas.add(codeTitle)

        let designTitle = TextShape(text: "Design", font: font)
        designTitle?.fillColor = black
        designTitle?.center = canvas.center + Vector(x: radius, y: -radius)
        canvas.add(designTitle)

        reset()
        canvas.addTapGestureRecognizer { _,_,_ in
            self.animate()
        }
    }

    func reset() {
        let codeRange = 0..<240
        let designRange = 240..<360
        for wedge in wedges[codeRange] {
            wedge.fillColor = C4Blue
        }
        for wedge in wedges[designRange] {
            wedge.fillColor = C4Pink
        }
    }

    func buildWedges() {
        let wedgeAngle = π / 180.0

        for a in 0.0.stride(to: 2 * π, by: wedgeAngle) {
            let wedge = Wedge(center: canvas.center, radius: radius, start: a, end: a + wedgeAngle * 1.5)
            wedge.lineWidth = 0.0
            wedge.strokeColor = C4Blue
            wedge.fillColor = C4Blue
            wedges.append(wedge)
            canvas.add(wedge)
        }
    }

    func animate() {
        var animations = [ViewAnimation]()

        let changeRange = 120..<240
        let duration = 0.5 / Double(changeRange.count)
        for wedge in wedges[changeRange].reverse() {
            animations.append(ViewAnimation(duration: duration) { wedge.fillColor = C4Pink })
        }
        ViewAnimationSequence(animations: animations).animate()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        reset()
    }
}
