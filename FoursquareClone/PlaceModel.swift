//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Can Kanbur on 5.04.2023.
//

import Foundation
import UIKit
class PlaceModel {
    static let sharedInstance = PlaceModel()
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    
    private init(){}
}
