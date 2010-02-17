//
//  TrackMeViewController.h
//  TrackMe
//
//  Created by Steve Baker on 2/15/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TrackMeViewController : UIViewController 
<CLLocationManagerDelegate, MKMapViewDelegate> {
    MKMapView *myMapView;
    CLLocationManager *locationManager;
}
#pragma mark -
#pragma mark properties
@property(nonatomic, retain) IBOutlet MKMapView *myMapView;
@property(nonatomic,retain)CLLocationManager *locationManager;

@end
