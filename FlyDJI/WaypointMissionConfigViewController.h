//
//  DJIWaypointConfigViewController.h
//  GSDemo
//
//  Created by OliverOu on 12/7/15.
//  Copyright (c) 2015 DJI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaypointViewController.h"

@class WaypointMissionConfigViewController;
@protocol WaypointMissionConfigViewControllerDelegate <NSObject>

- (void)flightPathModeWaypointMissionConfigVCDelegate:(BOOL)isCurve;
- (void)headingWaypointMissionConfigVCDelegate:(int)poiIndex;

@end

@interface WaypointMissionConfigViewController : UIViewController

@property id<WaypointMissionConfigViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationTitle;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UIStepper *speedStepper;

@property (weak, nonatomic) IBOutlet UILabel *maxSpeedLabel;
@property (weak, nonatomic) IBOutlet UISlider *maxSpeedSlider;
@property (weak, nonatomic) IBOutlet UIStepper *maxSpeedStepper;



@property (weak, nonatomic) IBOutlet UISegmentedControl *flightPathMode;
@property (weak, nonatomic) IBOutlet UILabel *curveLabel;
@property (weak, nonatomic) IBOutlet UISlider *curveSlider;
@property (weak, nonatomic) IBOutlet UIStepper *curveStepper;

@property (weak, nonatomic) IBOutlet UISegmentedControl *actionSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *headingSegmentedControl;
@property (weak, nonatomic) IBOutlet UISwitch *rotateGimbalPitchSwitch;
//@property CLLocationCoordinate2D POI;
@property int poiIndex;

@property (strong, nonatomic) DJIWaypointMission *waypointMission;
@property NSArray *poiArray;

- (IBAction)rotateGimbalPitchSwitchAction:(id)sender;
- (IBAction)finishBtnAction:(id)sender;

- (void)waypointMissionConfigInit:(WaypointViewController *)waypointViewController;

@end
