//
//  DJIWaypointConfigViewController.m
//  GSDemo
//
//  Created by OliverOu on 12/7/15.
//  Copyright (c) 2015 DJI. All rights reserved.
//

#import "Utility.h"
#import "WaypointMissionConfigViewController.h"

@interface WaypointMissionConfigViewController ()



@end

@implementation WaypointMissionConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationBar.barTintColor = [UIColor blackColor];
    NSInteger curvePercent = [[NSUserDefaults standardUserDefaults] integerForKey:@"WaypointDefaultCurvePercent"];
    if (curvePercent == 0)
        curvePercent = 30;
    self.curveSlider.minimumValue = 0;
    self.curveSlider.maximumValue = 100;
    self.curveSlider.value = curvePercent;
    self.curveLabel.text = [NSString localizedStringWithFormat:NSLocalizedString(@"Default Curve Percentage: %d%%", @""), (int)curvePercent];
    self.curveSlider.continuous = YES;
    [self.curveSlider addTarget:self action:@selector(curveSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.curveStepper.minimumValue = 0;
    self.curveStepper.maximumValue = 100;
    self.curveStepper.value = curvePercent;
    self.curveStepper.continuous = YES;
    [self.curveStepper addTarget:self action:@selector(curveStepperValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)waypointMissionConfigInit:(WaypointMissionConfigViewController *)waypointMissionViewController
{
    self.waypointMission = waypointMissionViewController.waypointMission;
    self.poiArray = waypointMissionViewController.poiArray;
    
    self.speedSlider.minimumValue = -15;
    self.speedSlider.maximumValue = 15;
    self.speedSlider.continuous = YES;
    self.speedSlider.value = self.waypointMission.autoFlightSpeed;
    self.speedLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"Auto Speed: %0.1fm/s", @""), self.speedSlider.value];
    [self.speedSlider addTarget:self action:@selector(speedSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.speedStepper.minimumValue = -15;
    self.speedStepper.maximumValue = 15;
    self.speedStepper.value = self.waypointMission.autoFlightSpeed;
    self.speedStepper.continuous = YES;
    [self.speedStepper addTarget:self action:@selector(speedStepperValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    self.maxSpeedSlider.minimumValue = 2;
    self.maxSpeedSlider.maximumValue = 15;
    self.maxSpeedSlider.continuous = YES;
    self.maxSpeedSlider.value = self.waypointMission.maxFlightSpeed;
    self.maxSpeedLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"Max Speed: %0.1fm/s", @""), self.maxSpeedSlider.value];
    [self.maxSpeedSlider addTarget:self action:@selector(maxSpeedSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.maxSpeedStepper.minimumValue = 2;
    self.maxSpeedStepper.maximumValue = 15;
    self.maxSpeedStepper.value = self.waypointMission.maxFlightSpeed;
    self.maxSpeedStepper.continuous = YES;
    [self.maxSpeedStepper addTarget:self action:@selector(maxSpeedStepperValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.flightPathMode.selectedSegmentIndex = self.waypointMission.flightPathMode;
    [self.flightPathMode addTarget:self action:@selector(flightPathModeValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    if (self.flightPathMode.selectedSegmentIndex == 1) {
        self.curveLabel.enabled = 1;
        self.curveSlider.enabled = 1;
        self.curveStepper.enabled = 1;
        self.curveStepper.alpha = 1;
    }
    else {
        self.curveLabel.enabled = 0;
        self.curveSlider.enabled = 0;
        self.curveStepper.enabled = 0;
        self.curveStepper.alpha = 0.5;
    }
    
    self.actionSegmentedControl.selectedSegmentIndex = self.waypointMission.finishedAction;
    self.headingSegmentedControl.selectedSegmentIndex = self.waypointMission.headingMode;

    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.frame.size;
    self.rotateGimbalPitchSwitch.on = self.waypointMission.rotateGimbalPitch;
    self.navigationTitle.title = NSLocalizedString(@"Waypoint Mission Configuration", @"");
    self.view.alpha = 1;
}

- (void) speedSliderValueChanged: (UISlider *) speedSlider {
    }

- (void)speedStepperValueChanged:(UIStepper *)speedStepper {
    }

- (void) maxSpeedSliderValueChanged: (UISlider *) maxSpeedSlider {
    self.maxSpeedLabel.text = [NSString  localizedStringWithFormat: NSLocalizedString(@"Max Speed: %0.1fm/s", @""), maxSpeedSlider.value];
    self.maxSpeedStepper.value = maxSpeedSlider.value;
}

- (void) maxSpeedStepperValueChanged: (UIStepper *) maxSpeedStepper {
    
}

- (void)flightPathModeValueChanged:(UISegmentedControl *)segment {
    
}
- (void)curveSliderValueChanged:(UISlider *)slider {
    }

- (void)curveStepperValueChanged:(UIStepper *)stepper {
    
}

- (IBAction)rotateGimbalPitchSwitchAction:(id)sender {
}

- (IBAction)finishBtnAction:(id)sender {

    self.view.alpha = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
