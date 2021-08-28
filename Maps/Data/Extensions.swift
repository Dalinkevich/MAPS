//
//  Extensions.swift
//  Maps
//
//  Created by Роман далинкевич on 27.06.2021.
//

import Foundation
import UIKit
import YandexMapsMobile


struct AssociatedKeys {
    static var Title: UInt8 = 0
    static var Snippet: UInt8 = 0
}
extension YMKMapObject {
    var title: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.Title) as? String
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.Title, newValue as String?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    var snippet: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.Snippet) as? String
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.Snippet, newValue as String?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
//MARK: Centering on an array of coordinates
extension Array where Element == Places {

    func region() -> YMKBoundingBox? {
        guard self.count > 1 else { return nil }
        
        let longArray = self.map { $0.coordinate.longitude }
        let latArray = self.map { $0.coordinate.latitude }
        
        let minLong = longArray.min()!
        let maxLong = longArray.max()!
        
        let minLat =  latArray.min()!
        let maxLat =  latArray.max()!
        
        let southWest = YMKPoint(latitude: minLat, longitude: minLong)
        let northEast = YMKPoint(latitude: maxLat, longitude: maxLong)
        
        return YMKBoundingBox(southWest: southWest, northEast: northEast)
    }

    func center() -> YMKPoint? {
        guard self.count >= 1 else { return nil }
        
        let longArray = self.map { $0.coordinate.longitude }
        let latArray = self.map { $0.coordinate.latitude }
        
        let minLong = longArray.min()!
        let maxLong = longArray.max()!
        
        let minLat =  latArray.min()!
        let maxLat =  latArray.max()!
        
        return YMKPoint(latitude: (minLat + maxLat) / 2, longitude: (minLong + maxLong) / 2)
    }
}
extension String {
    var hex: Int? {
        return Int(self, radix: 16)
    }
}




