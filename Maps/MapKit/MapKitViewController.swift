//
//  MapKitViewController.swift
//  Maps
//
//  Created by Роман далинкевич on 25.06.2021.
//

import UIKit
import MapKit
import CoreLocation

class MapKitViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    var placeMark = PlaceMarks()

    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = false
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        mapView.addAnnotations(placeMark.places)
        mapView.register(Places.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        if let center = placeMark.places.center() {
            mapView.centerToLocation(CLLocation.init(latitude: center.latitude, longitude: center.longitude), regionRadius: 13000)
        }
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        mapView.addAnnotations(placeMark.places)

        view.addSubview(mapView)
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("places isEmpty?: \(self.placeMark.places.isEmpty)")
        }
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation,regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension MapKitViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("lat: \(userLocation.coordinate.latitude), lng: \(userLocation.coordinate.longitude)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("New location is \(location)")
       }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? Places else { return nil }
        let identifier = "annotation"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            
            let size = CGSize(width: 48, height: 48)
            let mapsButton = UIButton(frame: .init(origin: .zero, size: size))
            
            mapsButton.setBackgroundImage(annotation.image, for: .normal)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.rightCalloutAccessoryView = mapsButton
            
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let title = view.annotation?.title as? String else { return }
        guard let subtitle = view.annotation?.subtitle as? String else { return }
        print("The user clicked on the object")
        print(title)
        print(subtitle)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let places  = view.annotation as? Places else {
            return
        }
        let launchOption = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        places.mapItem?.openInMaps(launchOptions: launchOption)
    }
    
}

