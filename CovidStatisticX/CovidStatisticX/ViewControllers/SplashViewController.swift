//
//  ViewController.swift
//  CovidStatisticX
//
//  Created by Vitalii on 29.09.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController {


    // MARK: - IBOutlets
    @IBOutlet weak var countryTableView: UITableView!
    
    // MARK: - Class Properties
    var covidStatistic = CovidStatistic() {
        didSet {
            countryTableView.reloadDataOnMainQueue()
            presentMainViewContriller()
        }
    }
    
    // MARK: - UIViewController events
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryStatistic()
        prepareTableView()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        self.countryTableView.reloadDataOnMainQueue()
    }
    
    // MARK: - Methods
    private func getCountryStatistic() {
        NetworkHelpers.shared.fetchCovidStatistic(completion: { (covidStatistic) in
            if let statistic = covidStatistic {
                self.covidStatistic = statistic.sorted() { $0.totalCasesDouble > $1.totalCasesDouble }
                //title.
            }
        })
    }
    
    private func prepareTableView() {
        countryTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        countryTableView.register(MainTableViewCell.nib(), forCellReuseIdentifier: MainTableViewCell.identifier)
        countryTableView.delegate = self
        countryTableView.dataSource = self
    }
    
    private func presentMainViewContriller() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController {
            vc.modalPresentationStyle = .fullScreen
            vc.covidStatistic = covidStatistic
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.present(vc, animated: false, completion: nil)
            }
        }
    }
    
}

//MARK: - UITableViewDelegate
extension SplashViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 20
    }
    
}
//MARK: - UITableViewDataSource
extension SplashViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covidStatistic.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let screenSize = UIScreen.main.bounds
        let cell = countryTableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        cell.configure(withCountry: covidStatistic[indexPath.row + 1],
                       casesText: covidStatistic[indexPath.row + 1].totalCasesText,
                       casesDouble: covidStatistic[indexPath.row + 1].totalCasesDouble,
                       firstArrayElementTotCase: covidStatistic[1].totalCasesDouble,
                       cellWidth: screenSize.width,
                       chartColor: .red,
                       animated: true)
        return cell
    }
    
}
