//
//  GoogleMapMarker.swift
//  Maps
//
//  Created by Роман далинкевич on 28.06.2021.
//

import Foundation
import GoogleMaps

final class GoogleMapMarker: GMSMarker {
    let plases: Places
    
    init(plases: Places) {
        self.plases = plases
        super.init()
        
        position = plases.coordinate
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
        title = plases.title
        snippet = plases.bridgeRaisingTimes
        
        icon = UIImage(named: "мост1")
    }
}
