//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Can Kanbur on 5.04.2023.
//

import Parse
import UIKit

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var placeNameArray = [String]()
    var placeIDArray = [String]()
    var selectedPlaceId = ""
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))

        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
        
        getDataFromParse()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destination = segue.destination as! DetailsVC
            destination.chosenPlaceId = selectedPlaceId
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = placeIDArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    func getDataFromParse(){
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "error", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            }else{
                if objects != nil {
                    self.placeNameArray.removeAll(keepingCapacity: false)
                    self.placeIDArray.removeAll(keepingCapacity: false)
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String {
                            if let placeID = object.objectId{
                                self.placeNameArray.append(placeName)
                                self.placeIDArray.append(placeID)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = placeNameArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }

    @objc func logoutButtonClicked() {
        PFUser.logOutInBackground { error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "error", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
    }

    @objc func addButtonClicked() {
        performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
    }
}
