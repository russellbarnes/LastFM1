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
    // Mark all events found from Last.FM
    
    CLLocationCoordinate2D eventLocation;
    
    // Draw all points in array
    for (int i = 0; i < [self.eventArray count]; i++)
    {
        eventLocation.latitude = [[(EventClass *)[self.eventArray objectAtIndex:i] latitude] floatValue];
        eventLocation.longitude = [[(EventClass *)[self.eventArray objectAtIndex:i] longitude] floatValue];
        
        // Display a point where the cooridnates are
        self.point = [[MKPointAnnotation alloc] init];
        [self.point setCoordinate:(CLLocationCoordinate2D)CLLocationCoordinate2DMake(eventLocation.latitude, eventLocation.longitude)];

        // Add title
        [self.point setTitle:[(EventClass*)[self.eventArray objectAtIndex:i] title]];
        [self.point setSubtitle:[(EventClass*)[self.eventArray objectAtIndex:i] venue]];
        
        // Add the annotation point
        [self.mapView addAnnotation:self.point];
    }
    
    // Add an annotation view to the map, and give it the annotation
    // This does not seem to be required!
    //self.annotationView = [[MKAnnotationView alloc] initWithAnnotation:self.point reuseIdentifier:@"eventAnnotationView"];
    
    
    // The window to display around the event
    MKCoordinateRegion windowRegion = MKCoordinateRegionMakeWithDistance(eventLocation, 800, 800);
    // Zoom to the location of the Last.FM event found in ViewController
    [_mapView setRegion:windowRegion animated:YES];
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
