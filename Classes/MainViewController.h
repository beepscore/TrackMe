//
//  MainViewController.h
//  TrackMe
//
//  Created by Steve Baker on 2/15/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "FlipsideViewController.h"

@interface MainViewController : UIViewController 
<FlipsideViewControllerDelegate, CLLocationManagerDelegate, MKMapViewDelegate> {
    MKMapView *myMapView;
}
#pragma mark -
#pragma mark properties
@property(nonatomic, retain) IBOutlet MKMapView *myMapView;

- (IBAction)showInfo;

@end
