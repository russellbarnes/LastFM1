//
//  MapViewController.m
//  LastFM1
//
//  Created by Russell Barnes on 1/10/14.
//  Copyright (c) 2014 Russell Barnes. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    // Zoom to the location of the Last.FM event found in ViewController
    CLLocationCoordinate2D eventLocation;
    eventLocation.latitude = [self.latitude floatValue];
    eventLocation.longitude = [self.longitude floatValue];
    
    // The window to display around the event
    MKCoordinateRegion windowRegion = MKCoordinateRegionMakeWithDistance(eventLocation, 800, 800);
    
    [_mapView setRegion:windowRegion animated:YES];
    
    NSLog(@"%f", [self.latitude floatValue]);
    
    // Display a point where the cooridnates are
    self.point = [[MKPointAnnotation alloc] init];
    [self.point setCoordinate:(CLLocationCoordinate2D)CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue])];
    // Add title
    [self.point setTitle:self.title];
    [self.point setSubtitle:self.venue];
    
    // Add an annotation view to the map, and give it the annotation
    // This does not seem to be required!
    //self.annotationView = [[MKAnnotationView alloc] initWithAnnotation:self.point reuseIdentifier:@"eventAnnotationView"];
    
    // Add the annotation point
    [self.mapView addAnnotation:self.point];
}

// mapView:viewForAnnotation: provides the view for each annotation.
// This method may be called for all or some of the added annotations.
// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
/*- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:NSClassFromString(@"MKUserLocation")])
        return Nil;
    
    // We return the view initialized in viewWillAppear
    return self.annotationView;
}*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
