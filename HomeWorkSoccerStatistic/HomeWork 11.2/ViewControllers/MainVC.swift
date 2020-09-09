//
//  ViewController.swift
//  HomeWork 11.2
//
//  Created by Vitalii on 06.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainVC: UIViewController {

    @IBOutlet weak var teamsTebleView: UITableView!
    
    var networkManager = NetworkManager()
    var teams = [Team]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamsTebleView.delegate = self
        teamsTebleView.dataSource = self
        teamsTebleView.register(TeamsTableViewCell.nib(), forCellReuseIdentifier: TeamsTableViewCell.identifier)
        fetchData()
        
    }

    func fetchData() {
        networkManager.fetchCurrentTeams() { teams in
            self.teams = teams
            DispatchQueue.main.async {
                self.teamsTebleView.reloadData()
            }
        }
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print (signOutError.localizedDescription)
        }

        dismiss(animated: true)
        
        let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        let vc = storyboard?.instantiateViewController(withIdentifier: "LogInVCID") as! SignInVC
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
    }

}

extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 7
    }
    
}

extension MainVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamsTableViewCell.identifier, for: indexPath) as! TeamsTableViewCell
        cell.configure(withTeam: teams[indexPath.row])

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        cell.teamImageView.addGestureRecognizer(tapGestureRecognizer)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "TeamInfoVC") as! TeamInfoVC
        vc.modalPresentationStyle = .fullScreen
        vc.team = teams[indexPath.row]
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "TeamStatisticVC") as! TeamStatisticVC
        vc.idTeam = teams[indexPath.row].teamID
        present(vc, animated: true)
    }
    
}

extension MainVC {
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let tappedImageView = UIImageView(image: imageView.image)
        tappedImageView.frame = UIScreen.main.bounds
        tappedImageView.contentMode = .scaleAspectFit
        tappedImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        tappedImageView.addGestureRecognizer(tap)
        self.view.addSubview(tappedImageView)
        self.navigationController?.isNavigationBarHidden = true
    }

    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        sender.view?.removeFromSuperview()
    }
    
}
