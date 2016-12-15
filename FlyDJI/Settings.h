//
//  Settings.h
//  FlyDJI
//
//  Created by zhangzhe on 27/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef Settings_h
#define Settings_h

#import <UIKit/UIKit.h>
#import "DJISDK/DJISDK.h"
#import "FailSafe.h"
#import "PreviewQuality.h"
#import "Channels.h"
#import "GimbalMode.h"
#import "C1.h"
#import "C2.h"
#import "Utility.h"

@class Settigns;
@protocol SettingsDelegate <NSObject>

- (int)getGimbalWorkModeSettingDelegate;
- (void)setGridlineSettingDelegate:(BOOL)isOn;
- (void)setDiagonalSettingDelegate:(BOOL)isOn;

@end

@interface Settings : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *table;
//@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UILabel *failSafeLabel;
@property (weak, nonatomic) IBOutlet UITextField *goHomeAltitudeField;
@property (weak, nonatomic) IBOutlet UISwitch *frontLEDSwitch;
@property (weak, nonatomic) IBOutlet UILabel *channelsLabel;
@property (weak, nonatomic) IBOutlet UILabel *previewQualityLabel;
@property (weak, nonatomic) IBOutlet UIButton *formatSDCardBtn;
@property (weak, nonatomic) IBOutlet UISwitch *gimbalExtensionSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *visionSystemSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *gridlineSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *diagonalSwitch;
@property (weak, nonatomic) IBOutlet UILabel *gimbalModeLabel;

@property (weak, nonatomic) IBOutlet UISwitch *hardwareDecodeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *C1Label;
@property (weak, nonatomic) IBOutlet UILabel *C2Label;

@property (weak, nonatomic) id<SettingsDelegate>delegate;

@property NSInteger failSafeIndex;
@property NSInteger channelsIndex;
@property NSInteger previewQualityIndex;
@property NSInteger gimbalModeIndex;
@property NSInteger C1Index;
@property NSInteger C2Index;

- (IBAction)goHomeAltitudeAction:(UITextField *)sender;
- (IBAction)frontLEDSwitchAction:(UISwitch *)sender;
- (IBAction)formatSDCardAction:(UIButton *)sender;
- (IBAction)gimbalExtensionAction:(UISwitch *)sender;
- (IBAction)visionPositionSystemAction:(UISwitch *)sender;
- (IBAction)gridlineAction:(UISwitch *)sender;
- (IBAction)hardwareDecodeAction:(UISwitch *)sender;
- (IBAction)diagonalAction:(UISwitch *)sender;

@end

#endif /* Settings_h */
