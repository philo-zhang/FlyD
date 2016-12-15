//
//  WaypointAddAction.m
//  Butterfly
//
//  Created by zhangzhe on 10/8/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaypointConfigViewController.h"
#import "Utility.h"

@interface WaypointConfigViewController()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>



@end
@implementation WaypointConfigViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
    self.actionTable.delegate = self;
    self.actionTable.dataSource = self;
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;
}

- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [self deregisterFromKeyboardNotifications];
    [super viewWillDisappear:animated];
}


- (void)waypointConfigInit:(DJIWaypointMission *)waypointMission poiArray:(NSArray *)poiArray waypointIndex:(int)index poiIndex:(int *)poiIndex isGimbalPoi:(BOOL *)isGimbalPoi{
    self.waypointMission = waypointMission;
    self.waypoint = [waypointMission getWaypointAtIndex:index];
    self.poiArray = poiArray;
    self.waypointIndex = index;
    self.poiIndex = poiIndex;
    self.isGimbalPoi = isGimbalPoi;
    
    self.navigation.title = [NSString  localizedStringWithFormat:NSLocalizedString(@"Waypoint %d Configuration", @""), index+1];
    
    self.altitudeSlider.minimumValue = -200;
    self.altitudeSlider.maximumValue = 500;
    self.altitudeSlider.value = self.waypoint.altitude;
    self.altitudeLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"Altitude: %dm", @""),(int)self.waypoint.altitude];
    
    self.altitudeStepper.minimumValue = -200;
    self.altitudeStepper.maximumValue = 500;
    self.altitudeStepper.value = self.waypoint.altitude;
    
    if (waypointMission.flightPathMode == DJIWaypointMissionFlightPathNormal ||
        index == 0 || index == [waypointMission waypointCount] - 1) {
        self.cornerLabel.enabled = NO;
        self.cornerSlider.enabled = NO;
        self.cornerStepper.enabled = NO;
        self.cornerStepper.alpha = 0.5;
        self.cornerLabel.text = [NSString localizedStringWithFormat: NSLocalizedString(@"Corner: %dm",@""), 0];
    }
    else {
        self.cornerLabel.enabled = YES;
        self.cornerSlider.enabled = YES;
        self.cornerStepper.enabled = YES;
        self.cornerStepper.alpha = 1;
        DJIWaypoint *waypoint1 = [waypointMission getWaypointAtIndex:index-1];
        CLLocation *location1 = [[CLLocation alloc] initWithLatitude:waypoint1.coordinate.latitude longitude:waypoint1.coordinate.longitude];
        DJIWaypoint *waypoint2 = [waypointMission getWaypointAtIndex:index];
        CLLocation *location2 = [[CLLocation alloc] initWithLatitude:waypoint2.coordinate.latitude longitude:waypoint2.coordinate.longitude];
        DJIWaypoint *waypoint3 = [waypointMission getWaypointAtIndex:index+1];
        CLLocation *location3 = [[CLLocation alloc] initWithLatitude:waypoint3.coordinate.latitude longitude:waypoint3.coordinate.longitude];
        float distance1 = [location1 distanceFromLocation:location2];
        float distance2 = [location2 distanceFromLocation:location3];
        self.distance1 = distance1;
        self.distance2 = distance2;
        float distance = MIN(distance1, distance2);
        self.cornerSlider.minimumValue = 0.2;
        self.cornerSlider.maximumValue = distance;
        self.cornerLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"Corner: %dm", @""), (int)self.waypoint.cornerRadiusInMeters];
        self.cornerSlider.value = self.waypoint.cornerRadiusInMeters;
        self.cornerStepper.minimumValue = 0.2;
        self.cornerStepper.maximumValue = distance;
        self.cornerStepper.value = self.waypoint.cornerRadiusInMeters;
    }
    
    self.headingLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"Heading: %d\u00b0", @""), (int)self.waypoint.heading];
    self.headingSlider.minimumValue = -180;
    self.headingSlider.maximumValue = 180;
    self.headingSlider.value = self.waypoint.heading;
    
    self.headingStepper.minimumValue = -180;
    self.headingStepper.maximumValue = 180;
    self.headingStepper.value = self.waypoint.heading;
    
    if (waypointMission.headingMode != DJIWaypointMissionHeadingUsingWaypointHeading) {
        self.headingSlider.enabled = 0;
        self.headingStepper.enabled = 0;
        self.headingLabel.enabled = 0;
        self.headingStepper.alpha = 0.5;
    }
    else {
        self.headingLabel.enabled = 1;
        self.headingSlider.enabled = 1;
        self.headingStepper.enabled = 1;
        self.headingStepper.alpha = 1;
    }

    if (self.poiIndex[index] == 0) {
        [self.poiButton setTitle:NSLocalizedString(@"None", @"") forState:UIControlStateNormal];
    }
    else {
        [self.poiButton setTitle:[NSString  localizedStringWithFormat:@"%d", self.poiIndex[index]] forState:UIControlStateNormal];
    }
    if (self.waypointMission.headingMode != DJIWaypointMissionHeadingUsingWaypointHeading) {
        self.poiLabel.enabled = 0;
        self.poiButton.enabled = 0;
        self.poiButton.alpha = 0.5;
        [self.poiButton setTitle:NSLocalizedString(@"None", @"") forState:UIControlStateNormal];
        self.isGimbalPoi[self.waypointIndex] = 0;
    }
    else {
        self.poiButton.enabled = 1;
        self.poiLabel.enabled = 1;
        self.poiButton.alpha = 1;
    }
    
    self.gimbalPitchMode.selectedSegmentIndex = self.isGimbalPoi[self.waypointIndex];
    
    self.gimbalPitchSlider.minimumValue = -90;
    self.gimbalPitchSlider.maximumValue = 0;
    self.gimbalPitchSlider.value = self.waypoint.gimbalPitch;
    self.gimbalPitchStepper.minimumValue = -90;
    self.gimbalPitchStepper.maximumValue = 0;
    self.gimbalPitchStepper.value = self.waypoint.gimbalPitch;
    self.gimbalPitchLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"Gimbal Pitch: %d\u00b0", @""), (int)self.gimbalPitchSlider.value];
    
    if (waypointMission.rotateGimbalPitch == 0) {
        self.gimbalPitchLabel.enabled = 0;
        self.gimbalPitchMode.enabled = 0;
        self.gimbalPitchSlider.enabled = 0;
        self.gimbalPitchStepper.enabled = 0;
        self.gimbalPitchStepper.alpha = 0.5;
    }
    else {
        self.gimbalPitchLabel.enabled = 1;
        self.gimbalPitchMode.enabled = 1;
        if (self.gimbalPitchMode.selectedSegmentIndex == 0) {
            self.gimbalPitchSlider.enabled = 1;
            self.gimbalPitchStepper.enabled = 1;
            self.gimbalPitchStepper.enabled = 1;
            self.gimbalPitchStepper.alpha = 1;
        }
        else {
            self.gimbalPitchSlider.enabled = 0;
            self.gimbalPitchStepper.enabled = 0;
            self.gimbalPitchStepper.enabled = 0.5;
            self.gimbalPitchStepper.alpha = 0.5;
        }
    }
    if (waypointMission.flightPathMode == DJIWaypointMissionFlightPathCurved) {
        self.ActionBtn.enabled = 0;
        self.actionTable.alpha = 0.5;
    }
    else {
        self.actionTable.alpha = 1;
        self.ActionBtn.enabled = 1;
    }
    [self.actionTable reloadData];
    self.view.alpha = 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    //NSLog(@"count: %lu", (unsigned long)self.waypoint.waypointActions.count);
    return self.waypoint.waypointActions.count;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor colorWithWhite:1 alpha:0];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    [header.textLabel setTextColor:[UIColor whiteColor]];
    [header.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    return NSLocalizedString(@"Actions", @"");
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    DJIWaypointAction *waypointAction = [self.waypoint.waypointActions objectAtIndex:indexPath.row
                                        ];
    if (waypointAction.actionType == DJIWaypointActionTypeStay) {
        [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        cell.textLabel.text = NSLocalizedString(@"Stay for", @"");
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake((int)self.view.frame.size.width - 100, 5, 45, 20)];
        textField.text = [NSString  localizedStringWithFormat:@"%d", (int)waypointAction.actionParam/1000];
        [textField setBorderStyle:UITextBorderStyleRoundedRect];
        textField.font = [UIFont systemFontOfSize:14];
        [textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleDefault;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Done", @"") style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        textField.inputAccessoryView = numberToolbar;
        
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [textField addTarget:self action:@selector(textFieldDidStartChange:) forControlEvents:UIControlEventEditingDidBegin];
        textField.restorationIdentifier = [NSString localizedStringWithFormat:@"%d", (int)indexPath.row];
        [cell.contentView addSubview:textField];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((int)self.view.frame.size.width - 50, 5, 15, 20)];
        label.text = @"s";
        //label.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label];
    }
    else if (waypointAction.actionType == DJIWaypointActionTypeShootPhoto) {
        cell.textLabel.text = NSLocalizedString(@"Shoot Photo", @"");
        [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    }
    else if (waypointAction.actionType == DJIWaypointActionTypeStartRecord) {
        cell.textLabel.text = NSLocalizedString(@"Start Record", @"");
        [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    else if (waypointAction.actionType == DJIWaypointActionTypeStopRecord) {
        cell.textLabel.text = NSLocalizedString(@"Stop Record", @"");
        [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    else if (waypointAction.actionType == DJIWaypointActionTypeRotateAircraft) {
        [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        cell.textLabel.text = NSLocalizedString(@"Rotate Aircraft", @"");
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake((int)self.view.frame.size.width - 100, 5, 45, 20)];
        textField.text = [NSString  localizedStringWithFormat:@"%d", waypointAction.actionParam];
        [textField setBorderStyle:UITextBorderStyleRoundedRect];
        textField.font = [UIFont systemFontOfSize:14];
        [textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleDefault;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Done", @"") style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        textField.inputAccessoryView = numberToolbar;

        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
        [textField addTarget:self action:@selector(textFieldDidStartChange:) forControlEvents:UIControlEventEditingDidBegin];
        textField.restorationIdentifier = [NSString  localizedStringWithFormat:@"%d", (int)indexPath.row];
        [cell.contentView addSubview:textField];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((int)self.view.frame.size.width - 50, 5, 15, 20)];
        label.text = @"\u00B0";
        //label.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label];
    }
    else if (waypointAction.actionType == DJIWaypointActionTypeRotateGimbalPitch) {
        cell.textLabel.text = NSLocalizedString(@"Rotate Gimbal Pitch", @"");
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake((int)self.view.frame.size.width - 100, 5, 45, 20)];
        textField.text = [NSString  localizedStringWithFormat:@"%d", waypointAction.actionParam];
        [textField setBorderStyle:UITextBorderStyleRoundedRect];
        textField.font = [UIFont systemFontOfSize:14];
        [textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleDefault;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Done", @"") style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        textField.inputAccessoryView = numberToolbar;

        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
        [textField addTarget:self action:@selector(textFieldDidStartChange:) forControlEvents:UIControlEventEditingDidBegin];
        textField.restorationIdentifier = [NSString  localizedStringWithFormat:@"%d", (int)indexPath.row];
        [cell.contentView addSubview:textField];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((int)self.view.frame.size.width - 50, 5, 15, 20)];
        label.text = @"\u00B0";
        //label.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label];
    }
    //cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.waypoint removeActionAtIndex:(int)indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)textFieldDidChange: (UITextField *)textField {
    NSInteger index = [textField.restorationIdentifier integerValue];
    DJIWaypointAction *waypointAction = [self.waypoint.waypointActions objectAtIndex:index];
    if (waypointAction.actionType == DJIWaypointActionTypeStay) {
        waypointAction.actionParam = (int)[textField.text floatValue] * 1000;
    }
    else
        waypointAction.actionParam = [textField.text integerValue];
}

- (void)textFieldDidStartChange:(UITextField *)textField {
    self.textField = textField;
}

-(void)doneWithNumberPad{
    [self.view endEditing:YES];
}

         
- (IBAction)altitudeSliderChanged:(UISlider *)sender {

}

- (IBAction)altitudeStepperChanged:(UIStepper *)sender {

}

- (IBAction)cornerSliderChanged:(UISlider *)sender {

}

- (IBAction)cornerStepperChanged:(UIStepper *)sender {
    }

- (IBAction)headingSliderChanged:(UISlider *)sender {
    
}

- (IBAction)headingStepperChanged:(UIStepper *)sender {
    
}

- (IBAction)rotationModeChanged:(UISegmentedControl *)sender {
    //self.waypoint.turnMode = sender.selectedSegmentIndex;
}

- (IBAction)poiBtnAction:(UIButton *)sender {
    

}


- (IBAction)gimbalPitchModeChanged:(UISegmentedControl *)sender {
    }

- (IBAction)gimbalPitchSliderChanged:(UISlider *)sender {
    
}

- (IBAction)gimbalPitchStepperChanged:(UIStepper *)sender {
}



- (IBAction)addAction:(UIButton *)sender {
    
}



- (IBAction)removeAction:(id)sender {

}

- (IBAction)doneAction:(id)sender {
    self.view.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
