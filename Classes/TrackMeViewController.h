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
#pragma mark -
#pragma mark instance variables
    // Xcode will automatically add instance variables to back properties

    CLLocationAccuracy desiredAccuracyMeters;
    NSArray *desiredAccuracyKeyArray;
    NSArray *desiredAccuracyObjectArray;
    
    CLLocationDistance distanceFilterValueMeters;
    
    NSArray *pinColorKeyArray;
    NSArray *pinColorObjectArray;
    NSUInteger myPinColor;
}

#pragma mark -
#pragma mark properties
@property(nonatomic, retain) IBOutlet MKMapView *myMapView;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property(nonatomic, copy, readonly) NSDictionary *desiredAccuracyDictionary;
@property(nonatomic, copy, readonly) NSDictionary *pinColorDictionary;
@end
