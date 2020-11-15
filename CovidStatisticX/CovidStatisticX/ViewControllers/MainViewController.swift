//
//  MainViewController.swift
//  CovidStatisticX
//
//  Created by Vitalii on 04.11.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Class Properties
    static let identifier = "MainViewController"
    var covidStatistic = CovidStatistic()
    
    // MARK: - UIViewController events
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        prepareSegmentedControls()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        self.countryTableView.reloadDataOnMainQueue()
    }
    
    // MARK: - Methods
    private func prepareTableView() {
        countryTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        countryTableView.register(MainTableViewCell.nib(), forCellReuseIdentifier: MainTableViewCell.identifier)
        countryTableView.delegate = self
        countryTableView.dataSource = self
        //need to add some observer of segmented controller changed segment
        countryTableView.reloadDataOnMainQueue()
    }
    
    private func prepareSegmentedControls() {
        segmentedControl.selectedSegmentTintColor = .red
    }
    
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 18
    }
    
}
//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covidStatistic.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let screenSize = UIScreen.main.bounds
        let cell = countryTableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        switch  segmentedControl.selectedSegmentIndex {
        case 0:
            cell.configure(withCountry: covidStatistic[indexPath.row + 1],
                           casesText: covidStatistic[indexPath.row + 1].totalCasesText,
                           casesDouble: covidStatistic[indexPath.row + 1].totalCasesDouble,
                           firstArrayElementTotCase: covidStatistic[1].totalCasesDouble,
                           cellWidth: screenSize.width,
                           chartColor: .red,
                           animated: false)
        case 1:
            cell.configure(withCountry: covidStatistic[indexPath.row + 1],
                           casesText: covidStatistic[indexPath.row + 1].totalRecoveredText,
                           casesDouble: covidStatistic[indexPath.row + 1].totalRecoveredDouble,
                           firstArrayElementTotCase: covidStatistic[1].totalRecoveredDouble,
                           cellWidth: screenSize.width,
                           chartColor: .green,
                           animated: false)
        case 2:
            cell.configure(withCountry: covidStatistic[indexPath.row + 1],
                           casesText: covidStatistic[indexPath.row + 1].totalDeathsText,
                           casesDouble: covidStatistic[indexPath.row + 1].totalDeathsDouble,
                           firstArrayElementTotCase: covidStatistic[1].totalDeathsDouble,
                           cellWidth: screenSize.width,
                           chartColor: .black,
                           animated: false)
        default:
            break
        }
        
        return cell
    }
    
}

