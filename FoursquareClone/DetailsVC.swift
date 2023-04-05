//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Can Kanbur on 5.04.2023.
//

import MapKit
import UIKit
import Parse
class DetailsVC: UIViewController ,MKMapViewDelegate{
    @IBOutlet var detailsMapView: MKMapView!
    @IBOutlet var detailsAtmosphereLabel: UILabel!
    @IBOutlet var detailsTypeLabel: UILabel!
    @IBOutlet var detailsNameLabel: UILabel!
    @IBOutlet var detailsImageView: UIImageView!
    
    var chosenLat = Double()
    var chosenLong = Double()
    var chosenPlaceId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsMapView.delegate = self
   getData()
    }
    
    func getData(){
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                print("error")
            }else{
                if objects != nil {
                    let myObject = objects![0]
                    
                    
                    if let placeName = myObject.object(forKey: "name") as? String {
                        self.detailsNameLabel.text = placeName
                    }
                    if let placeType = myObject.object(forKey: "type") as? String {
                        self.detailsTypeLabel.text = placeType
                    }
                    if let placeAtmo = myObject.object(forKey: "atmosphere") as? String{
                        self.detailsAtmosphereLabel.text = placeAtmo
                    }
                    if let placeLat = myObject.object(forKey: "latitude") as? String {
                        if let doubleLat = Double(placeLat){
                            self.chosenLat = doubleLat
                        }
                    }
                    if let placeLong = myObject.object(forKey: "longitude") as? String {
                        if let doubleLong = Double(placeLong){
                            self.chosenLong = doubleLong
                        }
                    }
                    if let imageData = myObject.object(forKey: "image") as? PFFileObject{
                        imageData.getDataInBackground { data, error in
                            if error == nil {
                                self.detailsImageView.image = UIImage(data: data!)
                            }
                        }
                    }
                    
                    let location = CLLocationCoordinate2D(latitude: self.chosenLat, longitude: self.chosenLong)
                    let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
                    let region = MKCoordinateRegion(center: location, span: span)
                    self.detailsMapView.setRegion(region, animated: true)
                    
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.detailsNameLabel.text!
                    annotation.subtitle = self.detailsTypeLabel.text!
                    self.detailsMapView.addAnnotation(annotation)
                    
                }
            }
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           if annotation is MKUserLocation {
               return nil
           }
           
           let reusedId = "pin"
           var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reusedId)
           
           if pinView == nil {
               pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reusedId)
               pinView?.canShowCallout = true
               let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
               pinView?.rightCalloutAccessoryView = button
           } else {
               pinView?.annotation = annotation
           }
           return pinView
       }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if self.chosenLat != 0.0 && self.chosenLong != 0.0 {
                let requestLocaction = CLLocation(latitude: self.chosenLat, longitude: self.chosenLong)
                
                CLGeocoder().reverseGeocodeLocation(requestLocaction) { placemarks, error in
                    if let placemark = placemarks {
                        
                        if placemark.count > 0 {
                            let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                            let mapItem = MKMapItem(placemark: mkPlaceMark)
                            mapItem.name = self.detailsNameLabel.text
                            
                            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                            
                            mapItem.openInMaps(launchOptions: launchOptions)
                        }
                    }
                }
            }
        }
}
