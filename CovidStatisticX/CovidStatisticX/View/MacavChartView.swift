//
//  MacavChartView.swift
//  CovidStatisticX
//
//  Created by Vitalii on 29.09.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation
import Macaw

class MacavChartView: MacawView {

//    static let data: [Double] = [101, 142, 66, 178, 92]
//    static let palette = [0xf08c00, 0xbf1a04, 0xffd505, 0x8fcc16, 0xd1aae3].map { val in Color(val: val)}

    static func createBar(weight: Double, animated: Bool, color: Color) -> Node {
       
        var animations: [Animation] = []
        let bar = Shape(
            form: Rect(x: 0, y: 0, w: weight, h: 35),
            fill: LinearGradient(degree: 180, from: color.with(a: 0.5), to: color.with(a: 0.3)),
            place: .scale(sx: 1, sy: 1))
        if animated == true {
            bar.place = .scale(0, 1)
            animations.append(bar.placeVar.animation(to: .move(dx: 0, dy: 0)))
            animations.combine().play()
        }
        return bar
    }
}
