//
//  YandexMapViewController.swift
//  Maps
//
//  Created by Роман далинкевич on 07.07.2021.
//

import UIKit
import YandexMapsMobile
import CoreLocation

class YandexMapViewController: UIViewController {

    @IBOutlet weak var mapView: YMKMapView!

    
    var zoom: Float = 1
    var placeMarks = PlaceMarks()
    let initialLocation = YMKPoint(latitude: 59.940719, longitude: 30.308910)
    
    private var circleMapObjectTapListener: PlacesMapObjectTapListener!
    private var userLocationLayer: YMKUserLocationLayer!
    private var locationManager: YMKLocationManager!
    private var nativeLocationManager = CLLocationManager()
    private var userLocationPoint: YMKPoint!
    
    var userLocation: YMKPoint? {
        didSet {
            guard userLocation != nil && userLocation?.latitude != 0 && userLocation?.longitude != 0 else { return }
            mapView.mapWindow.map.move(
                with: YMKCameraPosition.init(target: userLocation!, zoom: 15, azimuth: 0, tilt: 0),
                animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
                cameraCallback: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleMapObjectTapListener = PlacesMapObjectTapListener(self)

        createPoints()
        
        self.zoom = calcZoom(region: placeMarks.places.region())
    
        mapView.mapWindow.map.move(with: YMKCameraPosition(
                target: placeMarks.places.center()!,
                zoom: self.zoom,
                azimuth: 0,
                tilt: 0),
                    animationType: YMKAnimation(
                        type: .smooth,
                        duration: 2),
                        cameraCallback: { _ in
                    print("ZOOM = \(self.zoom)\n")
        })
    }
    
    func calcZoom(region: YMKBoundingBox!) -> Float {
        let width = Float(self.view.frame.size.width)
        let southWest = region.southWest
        let northEast = region.northEast

        var delta = Float(northEast.longitude - southWest.longitude)

        if delta < 0 {
            delta = Float(360 + northEast.longitude) - Float(southWest.longitude)
        }
        return log2(360 * width / (360 * Float(delta)))
    }
    
//MARK: Adding markers 
    func createPoints() {
        for place in placeMarks.places {
            let mapObjects = mapView.mapWindow.map.mapObjects;
            let center = YMKPoint(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            let circle = mapObjects.addCircle(
                with: YMKCircle(center: center, radius: 500),
                stroke: #colorLiteral(red: 0.5186402798, green: 0.9156739116, blue: 1, alpha: 1),
                strokeWidth: 2,
                fill: #colorLiteral(red: 0.5545281172, green: 0.5406855345, blue: 1, alpha: 1))
            circle.zIndex = 100
            circle.userData = place
            circle.addTapListener(with: circleMapObjectTapListener)
            circle.snippet = place.bridgeRaisingTimes
            
        }
    }

}

private class PlacesMapObjectTapListener: NSObject, YMKMapObjectTapListener {
    private weak var controller: UIViewController?

    init(_ vc: UIViewController) {
        self.controller = vc
    }

    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {

        if let places = mapObject as? YMKCircleMapObject {
            if let place = places.userData as? Places, let title = place.title {
                print("Selected: \(title)")

            if let vc = controller as? YandexMapViewController {
                    vc.mapView.mapWindow.map.move(
                        with: YMKCameraPosition.init(target: point, zoom: 10.89998, azimuth: 0, tilt: 0),
                        animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
                        cameraCallback: nil)
                }
            }
        }
        return true
    }
 
}



