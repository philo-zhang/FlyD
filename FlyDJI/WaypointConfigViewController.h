//
//  WaypointAddAction.h
//  Butterfly
//
//  Created by zhangzhe on 10/8/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef WaypointAddAction_h
#define WaypointAddAction_h
#import "DJISDK/DJISDK.h"
#import <UIKit/UIKit.h>

@class WaypointConfigViewController;
@protocol WaypointConfigViewControllerDelegate <NSObject>

- (void)removeWaypoint: (WaypointConfigViewController *)waypointConfigViewController;
- (void)cornerRadiusChanged:(int)index coor1:(CLLocationCoordinate2D)coor1 coor2:(CLLocationCoordinate2D)coor2 coorC:(CLLocationCoordinate2D)coorC;
- (void)modifyHeight:(int)index height:(int)height;

@end


@interface WaypointConfigViewController : UIViewController

@property (weak, nonatomic) id<WaypointConfigViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UINavigationItem *navigation;
@property (weak, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (weak, nonatomic) IBOutlet UISlider *altitudeSlider;
@property (weak, nonatomic) IBOutlet UIStepper *altitudeStepper;

@property (weak, nonatomic) IBOutlet UILabel *cornerLabel;
@property (weak, nonatomic) IBOutlet UISlider *cornerSlider;
@property (weak, nonatomic) IBOutlet UIStepper *cornerStepper;

@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UISlider *headingSlider;
@property (weak, nonatomic) IBOutlet UIStepper *headingStepper;

//@property (weak, nonatomic) IBOutlet UISegmentedControl *rotationMode;
@property (weak, nonatomic) IBOutlet UILabel *poiLabel;
@property (weak, nonatomic) IBOutlet UIButton *poiButton;
@property (weak, nonatomic) IBOutlet UILabel *gimbalPitchLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gimbalPitchMode;
@property (weak, nonatomic) IBOutlet UISlider *gimbalPitchSlider;
@property (weak, nonatomic) IBOutlet UIStepper *gimbalPitchStepper;

@property (weak, nonatomic) IBOutlet UIButton *ActionBtn;
@property (weak, nonatomic) IBOutlet UITableView *actionTable;

@property (retain, nonatomic) UITextField *stayFor;
@property (retain, nonatomic) UITextField *aircraftRotate;
@property (retain, nonatomic) UITextField *gimbalRotate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) DJIWaypointMission *waypointMission;
@property (strong, nonatomic) DJIWaypoint *waypoint;
@property (strong, nonatomic) NSArray *poiArray;
@property int *poiIndex;
@property BOOL *isGimbalPoi;
@property int waypointIndex;
@property float distance1;
@property float distance2;

@property UITextField *textField;
@property int textfieldrow;

- (IBAction)altitudeSliderChanged:(UISlider *)sender;
- (IBAction)altitudeStepperChanged:(UIStepper *)sender;
- (IBAction)cornerSliderChanged:(UISlider *)sender;
- (IBAction)cornerStepperChanged:(UIStepper *)sender;

- (IBAction)headingSliderChanged:(UISlider *)sender;
- (IBAction)headingStepperChanged:(UIStepper *)sender;
//- (IBAction)rotationModeChanged:(UISegmentedControl *)sender;
- (IBAction)poiBtnAction:(UIButton *)sender;
- (IBAction)gimbalPitchModeChanged:(UISegmentedControl *)sender;
- (IBAction)gimbalPitchSliderChanged:(UISlider *)sender;
- (IBAction)gimbalPitchStepperChanged:(UIStepper *)sender;

- (IBAction)addAction:(UIButton *)sender;
- (IBAction)removeAction:(id)sender;
- (IBAction)doneAction:(id)sender;

- (void)waypointConfigInit:(DJIWaypointMission *)waypointMission poiArray:(NSArray *)poiArray waypointIndex:(int)index poiIndex:(int *)poiIndex isGimbalPoi:(BOOL *)isGimbalPoi;

@end

#endif /* WaypointAddAction_h */
