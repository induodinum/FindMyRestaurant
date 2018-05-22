//
//  Artwork.swift
//  indiv-week4
//
//  Created by admin on 25/2/2561 BE.
//  Copyright © 2561 admin. All rights reserved.
//

import Foundation
import MapKit

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
}
