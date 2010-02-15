//
//  TrackMeAppDelegate.m
//  TrackMe
//
//  Created by Steve Baker on 2/15/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import "TrackMeAppDelegate.h"
#import "MainViewController.h"

@implementation TrackMeAppDelegate


@synthesize window;
@synthesize mainViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
	MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
	[aController release];
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [mainViewController release];
    [window release];
    [super dealloc];
}

@end
