//
//  MainViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 17.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import Alamofire
import DropDown

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var UserProfileBarButtonItem: UIBarButtonItem!
    
    // MARK: - Class Properties
    private let rightBarDropDown = DropDown()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCountries = Countries()
    private var countries = Countries()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
//    var availableCurrency: Currency!
    
    // MARK: - UIViewController events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        navigationBarButtonRightItem()
        prepareNavigationTitle()
        prepareSearchController()
        prepareTableView()
        fetchCountries()
    }
    
    // MARK: - Methods
    
    func navigationBarButtonRightItem()  {
        
        rightBarDropDown.anchorView = UserProfileBarButtonItem
        rightBarDropDown.dataSource = [kTranslateImage, kCurrencyConvert, kLogOutAction]
        rightBarDropDown.cellConfiguration = { (index, item) in return "\(item)" }

        let button = UIButton(type: .custom)
        let image = UIImage(named: "ic_account_circle")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
    }
    
    func showBarButtonDropDown() {
        rightBarDropDown.selectionAction = { (index: Int, item: String) in
            if item == kTranslateImage {
                self.imageTranslate()
            }
            if item == kLogOutAction {
                self.logOut()
            }
            if item == kCurrencyConvert {
                self.fetchAvailableCurrency()
//                self.goToCurrencyConverter()
            }
        }

        rightBarDropDown.width = 150
        rightBarDropDown.bottomOffset = CGPoint(x: (UIScreen.main.bounds.width/2 - 50), y: -(UIScreen.main.bounds.height)/2 + rightBarDropDown.cellHeight*2 + 20)
        rightBarDropDown.show()
    }

    
    @objc func buttonTapped() {
        showBarButtonDropDown()
    }
    
    private func goToCurrencyConverter(availableCurrency: Currency) {
        let vc = storyboard?.instantiateViewController(identifier: "CurrencyViewController") as! CurrencyViewController
        vc.availableCurrency = availableCurrency
        vc.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func prepareSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = kSearchPlaceholder
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    private func prepareNavigationTitle() {
        navigationController?.navigationBar.barTintColor = Colors.peachColor
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: Fonts.futuraMediumTextFont, size: 30)!, .foregroundColor: Colors.purple]
        navigationItem.title = kMainVCTitle
    }
    
    private func prepareTableView() {
        tableView.register(CountryTableViewCell.nib(), forCellReuseIdentifier: CountryTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
    }
    
    private func fetchCountries() {
        
        let headers: HTTPHeaders = ["x-rapidapi-host": "restcountries-v1.p.rapidapi.com",
                                    "x-rapidapi-key" : "5149ae2853msh263c0299a79f836p1b75acjsn9841e9ac2704",
                                    "useQueryString" : "true"]
        
        NetworkManager.shared.requestApi(stringURL: "https://restcountries-v1.p.rapidapi.com/all", method: .GET, headers: headers) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                if let contriesArray = NetworkHelpers.shared.parseCountries(data) {
                    self.countries = contriesArray
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchAvailableCurrency() {
        
        let headers: HTTPHeaders = ["x-rapidapi-host": "currency-converter5.p.rapidapi.com",
                                    "x-rapidapi-key" : "5149ae2853msh263c0299a79f836p1b75acjsn9841e9ac2704"]
        
        NetworkManager.shared.requestApi(stringURL: "https://currency-converter5.p.rapidapi.com/currency/list?format=json", method: .GET, headers: headers) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                if let currencyArray = NetworkHelpers.shared.parseAvailableCurrency(data) {
//                    self.availableCurrency = currencyArray
                    self.goToCurrencyConverter(availableCurrency: currencyArray)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func logOut() {
        showLogoutActionSheet() {
            do {
                try Auth.auth().signOut()
                let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LogInVCID")
                UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    window?.rootViewController = vc
                    window?.makeKeyAndVisible()
                })
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func imageTranslate() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: kActionSheetCamera, style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        
        let photo = UIAlertAction(title: kActionSheetPhoto, style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        
        let cancel = UIAlertAction(title: kActionSheetCancel, style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
       dismiss(animated: true)
           
       let vc = storyboard?.instantiateViewController(identifier: "TranslatedImageViewController") as! TranslatedImageViewController
       vc.image = image
       vc.modalPresentationStyle = .fullScreen
       
       self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        guard isFiltering else {
            tableView.reloadData()
            return
        }
        
        let filtered = countries.filter { (country) -> Bool in
            let string = country.name + country.alpha2Code + country.alpha3Code
            return string.lowercased().contains(text.lowercased())
        }
        
        filteredCountries = filtered
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCountries.count : countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as! CountryTableViewCell
                        
        if isFiltering {
            cell.configure(withCountry: filteredCountries[indexPath.row])
        } else {
            cell.configure(withCountry: countries[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "CountryInfoViewController") as! CountryInfoViewController
        
        if isFiltering {
            vc.country = filteredCountries[indexPath.row]
        } else {
            vc.country = countries[indexPath.row]
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 10
    }
}
