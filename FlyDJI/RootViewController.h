//
//  RootViewController.h
//  FlyDJI
//
//  Created by zhangzhe on 15/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef RootViewController_h
#define RootViewController_h

#include <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FunctionCollectionViewController.h"
#import "MapViewController.h"
#import "CameraViewController.h"
#import "WaypointViewController.h"
#import "WaypointMissionConfigViewController.h"
#import "WaypointConfigviewController.h"
#import "WaypointPoiConfigViewController.h"
#import "Settings.h"
#import "LocationConverter.h"
#import "Utility.h"

@interface RootViewController : UIViewController

//@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
//@property (weak, nonatomic) IBOutlet UINavigationItem *systemState;
@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UILabel *systemState;
@property (weak, nonatomic) IBOutlet UIButton *missionBtn;
@property (weak, nonatomic) IBOutlet UIButton *settingsBtn;

@property (weak, nonatomic) IBOutlet UILabel *satelliteLabel;
@property (weak, nonatomic) IBOutlet UILabel *batteryLabel;
@property (weak, nonatomic) IBOutlet UILabel *remoteControllerLabel;
@property (weak, nonatomic) IBOutlet UILabel *sdCardLabel;
@property (weak, nonatomic) IBOutlet UILabel *remoteBatteryLabel;

@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *hSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *vSpeedLabel;

@property (weak, nonatomic) IBOutlet UIButton *startFlyBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopFlyBtn;
@property (weak, nonatomic) IBOutlet UIButton *joystickBtn;
@property (weak, nonatomic) IBOutlet UIImageView *centerLabel;

@property DJIRCHardwareState hardwareState;
@property (strong, nonatomic) DJIFlightControllerCurrentState *state;


@property (strong, nonatomic) FunctionCollectionViewController *functionViewController;
@property (strong, nonatomic) MapViewController *mapViewController;
@property (strong, nonatomic) CameraViewController *cameraViewController;

@property (strong, nonatomic) WaypointViewController *waypointViewController;
@property (strong, nonatomic) WaypointMissionConfigViewController *waypointMissionConfigViewController;
@property (strong, nonatomic) WaypointConfigViewController *waypointConfigViewController;
@property (strong, nonatomic) WaypointPoiConfigViewController *waypointPoiConfigViewController;

@property (strong, nonatomic) Settings *settingVC;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureCamera;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureMap;


- (IBAction)startBtnAction:(id)sender;
- (IBAction)stopBtnAction:(id)sender;
- (IBAction)joystickBtnAction:(id)sender;

@end

#endif /* RootViewController_h */
