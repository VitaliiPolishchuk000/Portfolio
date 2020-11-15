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

    static let data: [Double] = [101, 142, 66, 178, 92]
    static let palette = [0xf08c00, 0xbf1a04, 0xffd505, 0x8fcc16, 0xd1aae3].map { val in Color(val: val)}

//    required init?(coder aDecoder: NSCoder) {
////        let button = MacavChartView.createButton()
////        let chart = MacavChartView.createChart(button.contents[0])
//        let bar = MacavChartView.createBar(weight: 200)
////        super.init(node: Group(contents: [bar]), coder: aDecoder)200
//
//
//        super.init(node: bar, coder: aDecoder)
//
//    }
//
//
//    func setWeight(totalCases: Double) -> Double{
//
//       let weight = totalCases/1000
//
//        return weight
//    }
//
//
//    static func createBar(weight: Double) -> Node {
////        var items: [Node] = []
//        var animations: [Animation] = []
//        let bar = Shape(
//            form: Rect(x: 0, y: 0, w: weight, h: 35),
//            fill: LinearGradient(degree: 180, from: MacavChartView.palette[1], to: MacavChartView.palette[1].with(a: 0.3)),
//            place: .scale(sx: 0, sy: 1))
////        items.append(bar)
//        animations.append(bar.placeVar.animation(to: .move(dx: 0, dy: 0)))
//        animations.combine().play()
//
//        return bar
//    }
//
//
}
