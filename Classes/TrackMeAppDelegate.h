//
//  TrackMeAppDelegate.h
//  TrackMe
//
//  Created by Steve Baker on 2/15/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

@class MainViewController;

@interface TrackMeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;

@end

