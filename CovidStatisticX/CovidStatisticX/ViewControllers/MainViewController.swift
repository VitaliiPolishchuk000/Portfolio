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
    var statisticDictSorted: [String: CovidStatistic] = [:]
    var covidStatistic = CovidStatistic(){
        didSet {
            setSortStatisticToDict()
        }
    }
    
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
    private func setSortStatisticToDict() {
        statisticDictSorted[kStatisticDictSortedKeys.sortedByCases.rawValue] = covidStatistic.sorted() { $0.totalCasesDouble > $1.totalCasesDouble }
        statisticDictSorted[kStatisticDictSortedKeys.sortedByRecovered.rawValue] = covidStatistic.sorted() { $0.persentOfRecoveredDouble > $1.persentOfRecoveredDouble }
        statisticDictSorted[kStatisticDictSortedKeys.sortedByDeath.rawValue] = covidStatistic.sorted() { $0.totalDeathsDouble > $1.totalDeathsDouble }
    }
    
    private func prepareTableView() {
        countryTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        countryTableView.register(MainTableViewCell.nib(), forCellReuseIdentifier: MainTableViewCell.identifier)
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.reloadDataOnMainQueue()
    }
    
    private func prepareSegmentedControls() {
        segmentedControl.selectedSegmentTintColor = .red
       
        if #available(iOS 14.0, *) {
            let segmentedControlAction = UIAction(title: "ReloadDataTableView") { (action) in
                self.countryTableView.reloadDataOnMainQueue()
            }
            segmentedControl.addAction(segmentedControlAction, for:.allEvents)
        } else {
            segmentedControl.addTarget(self, action: #selector(tapSegmentControl), for:.allEvents)
        }
    }
    
    @objc private func tapSegmentControl() {
        self.countryTableView.reloadDataOnMainQueue()
        
    }
    
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 18
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueTest", sender: indexPath)
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
            if let statistic = statisticDictSorted[kStatisticDictSortedKeys.sortedByCases.rawValue] {
            cell.configure(withCountry: statistic[indexPath.row + 1],
                           casesText: statistic[indexPath.row + 1].totalCasesText,
                           casesDouble: statistic[indexPath.row + 1].totalCasesDouble,
                           firstArrayElementTotCase: statistic[1].totalCasesDouble,
                           cellWidth: screenSize.width,
                           chartColor: .red,
                           animated: false)
            }
        case 1:
            if let statistic = statisticDictSorted[kStatisticDictSortedKeys.sortedByRecovered.rawValue] {
            cell.configure(withCountry: statistic[indexPath.row + 1],
                           casesText: statistic[indexPath.row + 1].persentOfRecoveredText,
                           casesDouble: statistic[indexPath.row + 1].persentOfRecoveredDouble,
                           firstArrayElementTotCase: statistic[1].persentOfRecoveredDouble,
                           cellWidth: screenSize.width,
                           chartColor: .green,
                           animated: false)
            }
        case 2:
            if let statistic = statisticDictSorted[kStatisticDictSortedKeys.sortedByDeath.rawValue] {
            cell.configure(withCountry: statistic[indexPath.row + 1],
                           casesText: statistic[indexPath.row + 1].totalDeathsText,
                           casesDouble: statistic[indexPath.row + 1].totalDeathsDouble,
                           firstArrayElementTotCase: statistic[1].totalDeathsDouble,
                           cellWidth: screenSize.width,
                           chartColor: .black,
                           animated: false)
            }
        default:
            break
        }
        
        return cell
    }
    
}

