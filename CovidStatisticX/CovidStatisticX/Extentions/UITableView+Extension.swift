//
//  UITableView+Extension.swift
//  CovidStatisticX
//
//  Created by Vitalii on 28.10.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func reloadDataOnMainQueue() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
