//
//  WaypointViewController.h
//  FlyDJI
//
//  Created by zhangzhe on 17/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef WaypointViewController_h
#define WaypointViewController_h

#import <UIKit/UIKit.h>
#import <DJISDK/DJISDK.h>

@class WaypointViewController;
@protocol WaypointViewControllerDelegate <NSObject>

- (CLLocationCoordinate2D)newpointWaypointDelegate:(BOOL)isWaypoint;
- (void)clearAllPointsWaypointDelegate;
- (void)configWaypointMissionDelegate;

@end

@interface WaypointViewController : UIViewController

@property DJIWaypointMission *waypointMission;
@property NSMutableArray *poiArray;
@property (weak, nonatomic) id<WaypointViewControllerDelegate> delegate;


@property (weak, nonatomic) IBOutlet UIButton *addWaypoint;
@property (weak, nonatomic) IBOutlet UIButton *addPoI;
@property (weak, nonatomic) IBOutlet UIButton *clearAllPoints;
@property (weak, nonatomic) IBOutlet UIButton *config;
@property (weak, nonatomic) IBOutlet UIButton *start;
@property (weak, nonatomic) IBOutlet UIButton *stop;
@property (strong, nonatomic) DJIMissionManager *missionManager;
@property int *poiIndexArray;
@property BOOL *isGimbalPoiArray;

@property DJIFlightControllerCurrentState *state;
@property DJIRCHardwareState hardwareState;
@property DJIWaypoint *firstWaypoint;


- (IBAction)addWaypointAction:(id)sender;
- (IBAction)addPoIAction:(id)sender;
- (IBAction)clearAction:(id)sender;
- (IBAction)configAction:(id)sender;
- (IBAction)startAction:(id)sender;
- (IBAction)stopAction:(id)sender;

- (void)removeWaypoint:(int)index;
- (void)removePoipoint:(int)index;

@end

#endif /* WaypointViewController_h */
