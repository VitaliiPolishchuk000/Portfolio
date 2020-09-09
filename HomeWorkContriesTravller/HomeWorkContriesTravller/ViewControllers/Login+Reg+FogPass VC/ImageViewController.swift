//
//  MainViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 17.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var avatarLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var regFinishButton: CustomButton!
    
    // MARK: - Class Properties
    var user = UserProfile()
    
    // MARK: - UIViewController events
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNextButton()
        prepareView()
        setBackground()
        prepareImageView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Methods
    func prepareView() {
        avatarLabel.text = kAvatarLabel
        avatarLabel.font = UIFont(name: Fonts.futuraMediumTextFont, size: 20)
    }
    
    func prepareImageView() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        avatarImage.image = UIImage(named: kNamePhotoDefaultImage)
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(recognizer)
        
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.backgroundColor = Colors.purple
        avatarImage.clipsToBounds = true
        avatarImage.layer.cornerRadius = 0.5 * avatarImage.frame.size.width
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
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
    
    func prepareNextButton() {
        regFinishButton.addTarget(self, action: #selector(onTapNextButton), for: .touchUpInside)
        regFinishButton.setTitle(kNextButtonTitle, for: .normal)
      }
      
    @objc func onTapNextButton() {
        
        guard avatarImage.image != nil else {
            showAlert(title: kAlertTitleError, message: kPhotoNotExist)
            return
        }
        
        let vc = self.storyboard?.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        vc.userImage = self.avatarImage.image
        vc.user = user
        if let nc = self.navigationController {
            nc.pushViewController(vc, animated: true)
        }
    }
    
}

// MARK: - Image Tapped
extension ImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        avatarImage.image = info[.editedImage] as? UIImage
        dismiss(animated: true)
    }
}



