//
//  MapViewController.h
//  LastFM1
//
//  Created by Russell Barnes on 1/10/14.
//  Copyright (c) 2014 Russell Barnes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

// These are set in ViewController
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *venue;

// The point to display on the map
@property (nonatomic, strong) MKPointAnnotation *point;
@property (nonatomic, strong) MKAnnotationView *annotationView;

// mapView:viewForAnnotation: provides the view for each annotation.
// This method may be called for all or some of the added annotations.
// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
// This does not seem to be required!
//- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation;

@end
