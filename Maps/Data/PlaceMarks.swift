//
//  Placemarks.swift
//  Maps
//
//  Created by Роман далинкевич on 12.07.2021.
//

import Foundation
import MapKit

class PlaceMarks {
    
    var places = [
        Places(title: "Tuchkov Bridge", bridgeRaisingTimes: "2:00-2:55,3:35-4:55", image: UIImage(named: "мост1")!, coordinate: CLLocationCoordinate2D(latitude: 59.948979, longitude: 30.285477)),
        Places(title: "Birzhevoy Bridge", bridgeRaisingTimes: "2:00-4:55", image: UIImage(named: "мост1")!, coordinate: CLLocationCoordinate2D(latitude: 59.946312, longitude: 30.303540)),
        Places(title: "Blagoveshensky Bridge", bridgeRaisingTimes: "1:25-2:45,3:10-5:00", image: UIImage(named: "мост1")!, coordinate: CLLocationCoordinate2D(latitude: 59.935103, longitude: 30.289036)),
        Places(title: "Palace Bridge", bridgeRaisingTimes: "1:10-2:50,3:10-4:55", image: UIImage(named: "мост1")!, coordinate: CLLocationCoordinate2D(latitude: 59.940719, longitude: 30.308910)),
        Places(title: "Troitsky Bridge", bridgeRaisingTimes: "1:20-8:00",  image: UIImage(named: "мост1")!, coordinate: CLLocationCoordinate2D(latitude: 59.948498, longitude: 30.327591)),
        Places(title: "Liteyny Bridge", bridgeRaisingTimes: "1:40-4:45",  image: UIImage(named: "мост1")!, coordinate: CLLocationCoordinate2D(latitude: 59.951622, longitude: 30.349395)),
        Places(title: "Bolsheokhtinsky Bridge", bridgeRaisingTimes: "2:00-5:00",  image: UIImage(named: "мост1")!, coordinate: CLLocationCoordinate2D(latitude: 59.942638, longitude: 30.400735)),
        Places(title: "Alexander Nevsky Bridge", bridgeRaisingTimes: "2:20-5:10",  image: UIImage(named: "мост1")!, coordinate: CLLocationCoordinate2D(latitude: 59.925779, longitude: 30.395769)),
        Places(title: "Volodarsky Bridge", bridgeRaisingTimes: "2:00-3:45, 4:15-5:45",  image: UIImage(named: "мост1")!, coordinate: CLLocationCoordinate2D(latitude: 59.877676, longitude: 30.452944))
    ]
}
