//
//  MapViewController.h
//  LastFM1
//
//  Created by Russell Barnes on 1/10/14.
//  Copyright (c) 2014 Russell Barnes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "EventClass.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

// Array of EventClass's passed from ViewController
@property (nonatomic, strong) NSArray *eventArray;

// The point to display on the map
@property (nonatomic, strong) MKPointAnnotation *point;
//not needed @property (nonatomic, strong) MKAnnotationView *annotationView;

// This does not seem to be required!
//- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation;

@end
