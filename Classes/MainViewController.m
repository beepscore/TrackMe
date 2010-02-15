//
//  MainViewController.m
//  TrackMe
//
//  Created by Steve Baker on 2/15/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "PointOfInterest.h"


@implementation MainViewController

#pragma mark -
#pragma mark properties
@synthesize myMapView;
@synthesize locationManager;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Ref Dudney Ch 24 Distance
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.delegate = self;
        // notify us only if distance changes by 10 meters or more
        self.locationManager.distanceFilter = 10.0f;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [self.locationManager startUpdatingLocation];
    
    // Load the points of interest. Very manual for now.    
    // CLLocationCoordinate2D coord1 = { 37.323388, -122.013958 };
    // Seattle
    CLLocationCoordinate2D coord1 = { 47.65, -122.35 };
    PointOfInterest *pointOfInterest1 = [[PointOfInterest alloc] init];
    pointOfInterest1.coordinate = coord1;
    pointOfInterest1.title = @"Point 1";
    
    CLLocationCoordinate2D initialCenter = pointOfInterest1.coordinate;
    
    //  MKCoordinateSpan initialSpan = MKCoordinateSpanMake(0.454305, 0.398254);
    MKCoordinateSpan initialSpan = MKCoordinateSpanMake(0.4, 0.4);
    
    MKCoordinateRegion initialRegion = MKCoordinateRegionMake(initialCenter, initialSpan);
    self.myMapView.region = initialRegion;
    
    [self.myMapView addAnnotation:pointOfInterest1];
    [pointOfInterest1 release], pointOfInterest1 = nil;
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}



/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark destructors and memory cleanUp
// use cleanUp method to avoid repeating code in setView, viewDidUnload, and dealloc
- (void)cleanUp {
    [myMapView release], myMapView = nil;
    [locationManager release], locationManager = nil;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


// Release IBOutlets in setView.  
// Ref http://developer.apple.com/iPhone/library/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/mmNibObjects.html
//
// http://moodle.extn.washington.edu/mod/forum/discuss.php?d=3162
- (void)setView:(UIView *)aView {
    
    if (!aView) { // view is being set to nil        
        // set outlets to nil, e.g. 
        // self.anOutlet = nil;
        [self cleanUp];
    }    
    // Invoke super's implementation last    
    [super setView:aView];    
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	[self cleanUp];
}


- (void)dealloc {
    [self cleanUp];
    [super dealloc];
}

#pragma mark -
#pragma mark MKMapViewDelegate methods
// Ref Dudney sec 25.3
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKPinAnnotationView *annotationView = nil;
    
    if(annotation != mapView.userLocation)
    {
        // Attempt to get an unused annotationView.  Returns nil if one isn't available.
        // Ref http://developer.apple.com/iphone/library/documentation/MapKit/Reference/MKMapView_Class/MKMapView/MKMapView.html#//apple_ref/occ/instm/MKMapView/dequeueReusableAnnotationViewWithIdentifier:
        annotationView = (MKPinAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:@"myIdentifier"];
        
        // if dequeue didn't return an annotationView, allocate a new one
        if (nil == annotationView) {
            // NSLog(@"dequeue didn't return an annotationView, allocing a new one");
            annotationView = [[[MKPinAnnotationView alloc] 
                               initWithAnnotation:annotation
                               reuseIdentifier:@"myIdentifier"]
                              autorelease];
        } else {
            NSLog(@"dequeueReusableAnnotationViewWithIdentifier returned an annotationView");
        }    
        [annotationView setPinColor:MKPinAnnotationColorPurple];
        [annotationView setCanShowCallout:YES];
        [annotationView setAnimatesDrop:YES];
    } else {
        [mapView.userLocation setTitle:@"I am here"];
    }
    return annotationView;
}


- (void)mapView:(MKMapView *)aMapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"lat: %f, long: %f, latDelta: %f, longDelta: %f",
          aMapView.region.center.latitude, aMapView.region.center.longitude, 
          aMapView.region.span.latitudeDelta, aMapView.region.span.longitudeDelta);
}


#pragma mark Location methods
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {

    PointOfInterest *newPointOfInterest = [[PointOfInterest alloc] init];
    newPointOfInterest.title = @"POI";
    newPointOfInterest.coordinate = newLocation.coordinate;

    [self.myMapView addAnnotation:newPointOfInterest];
    [newPointOfInterest release], newPointOfInterest = nil;
    
    // receiver is myMapView.  myMapView will call it's delegate, MainViewController
//    [self.myMapView mapView:self.myMapView viewForAnnotation:newPointOfInterest];
    [self.myMapView setNeedsDisplay];
}


@end

