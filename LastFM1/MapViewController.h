//
//  MapViewController.h
//  LastFM1
//
//  Created by Russell Barnes on 1/10/14.
//  Copyright (c) 2014 Russell Barnes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

// These are set in ViewController
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;

@end
