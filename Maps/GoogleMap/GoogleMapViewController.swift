//
//  GoogleMapViewController.swift
//  Maps
//
//  Created by Роман далинкевич on 28.06.2021.
//
import UIKit
import GoogleMaps
import GooglePlaces

class GoogleMapViewController: UIViewController {
    
    let infoMarker = GMSMarker()
    
    @IBOutlet var mapView: GMSMapView!
    
    var placeMarks = PlaceMarks()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.rotateGestures = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        
    DispatchQueue.main.async {
        let bounds = self.placeMarks.places.reduce(GMSCoordinateBounds()) {
            $0.includingCoordinate($1.coordinate)
        }
        self.mapView.moveCamera(.fit(bounds, withPadding: 30))
        self.mapView.animate(with: .fit(bounds, withPadding: 30.0))
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        markerAdd()
    }
    
    func colorMarker(title: String) -> UIColor {
        switch title {
        case "Tuchkov Bridge":
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case "Birzhevoy Bridge":
            return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case "Blagoveshensky Bridge":
            return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        case "Palace Bridge":
            return #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        case "Troitsky Bridge":
            return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case "Liteyny Bridge":
            return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        case "Bolsheokhtinsky Bridge":
            return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        case "Alexander Nevsky Bridge":
            return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case "Volodarsky Bridge":
            return #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        default:
            return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
    
//MARK: Adding markers
    func markerAdd() {
        for place in placeMarks.places {
        let marker = GMSMarker(position: place.coordinate)
        marker.title = place.title
        marker.snippet = place.bridgeRaisingTimes
        marker.icon = GMSMarker.markerImage(with: colorMarker(title: place.title!))
        marker.map = mapView
        }
    }
}

extension GoogleMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let place = marker.userData as? Places {
            print("Did tap marker for cluster item \(place.title ?? "Untitled")")
        } else {
             print("Did tap a normal marker")
            print(marker.title ?? "Untitled", " - ", marker.snippet ?? "Without a description")
        }
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf: \(marker.title ?? "Untitled")")
    }

 func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {

    infoMarker.snippet = placeID
    infoMarker.position = location
    infoMarker.title = name
    infoMarker.opacity = 0;
    infoMarker.infoWindowAnchor.y = 1
    infoMarker.map = mapView
    mapView.selectedMarker = infoMarker

    print("Title: \(name)")
    print("lat: \(location.latitude) lng: \(location.longitude)")
    
    }
}
