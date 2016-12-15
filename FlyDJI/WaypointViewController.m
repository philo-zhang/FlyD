//
//  WaypointViewController.m
//  FlyDJI
//
//  Created by zhangzhe on 17/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaypointViewController.h"
#import "Utility.h"
#import "MapViewController.h"

@interface WaypointViewController() <DJIMissionManagerDelegate>



@end

@implementation WaypointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.missionManager = [DJIMissionManager sharedInstance];
    self.missionManager.delegate = self;
    self.waypointMission = [[DJIWaypointMission alloc] init];
    float waypointSpeed = [[NSUserDefaults standardUserDefaults] floatForKey:@"WaypointSpeed"];
    if (waypointSpeed != 0)
        self.waypointMission.autoFlightSpeed = waypointSpeed;
    else
        self.waypointMission.autoFlightSpeed = 2;
    float waypointMaxSpeed = [[NSUserDefaults standardUserDefaults] floatForKey:@"WaypointMaxSpeed"];
    if (waypointMaxSpeed != 0)
        self.waypointMission.maxFlightSpeed = waypointMaxSpeed;
    else
        self.waypointMission.maxFlightSpeed = 15;
    BOOL isCurve = [[NSUserDefaults standardUserDefaults] boolForKey:@"WaypointCurve"];
    self.waypointMission.flightPathMode = isCurve;
    NSInteger finishedAction = [[NSUserDefaults standardUserDefaults] integerForKey:@"WaypointFinishedAction"];
    self.waypointMission.finishedAction = finishedAction;
    NSInteger heading = [[NSUserDefaults standardUserDefaults] integerForKey:@"WaypointHeading"];
    self.waypointMission.headingMode = heading;
    BOOL gimbalPitch = [[NSUserDefaults standardUserDefaults] boolForKey:@"WaypointGimbalPitch"];
    self.waypointMission.rotateGimbalPitch = gimbalPitch;
    self.poiArray = [[NSMutableArray alloc] init];
    self.poiIndexArray = malloc(sizeof(int)*100);
    for (int i = 0; i < 100; ++i)
        self.poiIndexArray[i] = 0;
    
    self.isGimbalPoiArray = malloc(sizeof(BOOL)*100);
    for (int i = 0; i < 100; ++i)
        self.isGimbalPoiArray[i] = NO;
    [self.view bringSubviewToFront:self.start];
    [self.view sendSubviewToBack:self.stop];
    self.stop.alpha = 0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopMission) name:@"Enter Background" object:nil];
}

- (void)stopMission {
    
}
- (void)dealloc {
    [self stopMission];
    free(self.poiIndexArray);
    free(self.isGimbalPoiArray);
}

- (IBAction)addWaypointAction:(id)sender {
    [self.delegate newpointWaypointDelegate:YES];
    //DJIWaypoint *waypoint = [[DJIWaypoint alloc] initWithCoordinate:coordinate];
    //[self.waypointMission addWaypoint:waypoint];
}
- (IBAction)addPoIAction:(id)sender {
    CLLocationCoordinate2D coordinate = [self.delegate newpointWaypointDelegate:NO];
}

- (void)removeWaypoint:(int)index {
    
}

- (void)removePoipoint:(int)index {
}

- (IBAction)clearAction:(id)sender {
    [self.delegate clearAllPointsWaypointDelegate];
    [self.waypointMission removeAllWaypoints];
    [self.poiArray removeAllObjects];
    for (int i = 0; i < 100; ++i)
        self.poiIndexArray[i] = 0;
    for (int i = 0; i < 100; ++i)
        self.isGimbalPoiArray[i] = NO;
}

- (IBAction)configAction:(id)sender {
    [self.delegate configWaypointMissionDelegate];
}

- (void)calculateRotation {
    }
- (IBAction)startAction:(id)sender {
    }



- (IBAction)stopAction:(id)sender {
    }

- (void)missionManager:(DJIMissionManager *_Nonnull)manager didFinishMissionExecution:(NSError *_Nullable)error {

}
@end
