//
//  AddPlacesVC.swift
//  FoursquareClone
//
//  Created by Can Kanbur on 5.04.2023.
//

import UIKit

class AddPlacesVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var placeAtmosphereText: UITextField!
    @IBOutlet var placeTypeText: UITextField!
    @IBOutlet var placeNameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
    }

    @objc func chooseImage() {
        let pickerImage = UIImagePickerController()
        pickerImage.delegate = self
        pickerImage.sourceType = .photoLibrary
        present(pickerImage, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true)
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        if placeNameText.text != "" && placeTypeText.text != "" && placeAtmosphereText.text != "" {
            if let choosenImage = placeImageView.image {
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeNameText.text!
                placeModel.placeType = placeTypeText.text!
                placeModel.placeAtmosphere = placeAtmosphereText.text!
                placeModel.placeImage = choosenImage
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)
        }else{
            let alert = UIAlertController(title: "Error", message: "error", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true)
        }
    }
}
