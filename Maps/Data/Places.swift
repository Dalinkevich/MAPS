//
//  Places.swift
//  Maps
//
//  Created by Роман далинкевич on 25.06.2021.
//

import Foundation
import MapKit
import Contacts

class Places: NSObject, MKAnnotation {
    var title: String?
    var bridgeRaisingTimes: String?
    var image: UIImage?
    var coordinate: CLLocationCoordinate2D
    init(title: String?, bridgeRaisingTimes: String?, image: UIImage, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.bridgeRaisingTimes = bridgeRaisingTimes
        self.image = image
        self.coordinate = coordinate
        super.init()
         
    }
    
    var subtitle: String? {
        return bridgeRaisingTimes
    }
    
    var mapItem: MKMapItem? {
        guard let bridgeRaisingTimes = bridgeRaisingTimes else {
            return nil
        }
        
        let adressDict = [CNPostalAddressStreetKey: bridgeRaisingTimes]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: adressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
