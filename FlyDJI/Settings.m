//
//  Settings.m
//  FlyDJI
//
//  Created by zhangzhe on 27/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Settings.h"

@interface Settings() <FailSafeDelegate, ChannelsDelegate, PreviewQualityDelegate, GimbalModeDelegate, C1Delegate, C2Delegate> {
    NSArray *viewControllerNames;
    DJIFlightController *flightController;
    DJIRemoteController *remoteController;
    DJILBAirLink *lbAirLink;
    DJICamera *camera;
    DJIGimbal *gimbal;
}

@end
@implementation Settings

- (void)viewDidLoad {
    [super viewDidLoad];
    self->viewControllerNames = [[NSArray alloc] initWithObjects:@"Version", @"Help", @"FailSafe", @"Channels",  @"PreviewQuality", @"GimbalMode", @"GoHomeAltitude", @"TurnOnFrontLEDS", @"GimbalExtenstion", @"VisionPositioningSystem", @"Gridline",  @"Diagonal", @"HardwareDecode", @"C1", @"C2", @"FormatSDCard", nil];
    self.navigationItem.title = NSLocalizedString(@"Settings", @"");
    flightController = [Utility fetchFlightController];
    remoteController = [Utility fetchRemoteController];
    lbAirLink = [Utility fetchLBAirLink];
    camera = [Utility fetchCamera];
    gimbal = [Utility fetchGimbal];
    [self setValues];
}

- (void)setValues {
    [self getFailSafeValue];
    [self getChannelsValue];
    [self getGoHomeAltitudeValue];
    [self getPreviewQualityValue];
    [self getTurnOnFrontLEDsValue];
    [self getVisionSystemValue];
    [self getGridlineValue];
    [self getDiagonalValue];
    [self getGimbalWorkModeValue];
    [self getGimbalExtensionValue];
    [self getHardwareDecodeValue];
    [self getC1C2Value];
    [self setAccessoryItems];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *string = [viewControllerNames objectAtIndex:indexPath.row];
    
    UIViewController *viewController = [[NSClassFromString(string) alloc] init];
    if (viewController == nil)
        return;
    viewController.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = NSLocalizedString(@"Back", @"");
    self.navigationItem.backBarButtonItem = barButton;
    if ([viewController isKindOfClass:[FailSafe class]]) {
        FailSafe *controller = (FailSafe *)viewController;
        controller.delegate = self;
        controller.index = self.failSafeIndex;
    }
    if ([viewController isKindOfClass:[PreviewQuality class]]) {
        PreviewQuality *controller = (PreviewQuality *)viewController;
        controller.delegate = self;
        controller.index = self.previewQualityIndex;
    }
    if ([viewController isKindOfClass:[Channels class]]) {
        Channels *controller = (Channels *)viewController;
        controller.delegate = self;
        controller.index = self.channelsIndex;
    }
    if ([viewController isKindOfClass:[GimbalMode class]]) {
        GimbalMode *controller = (GimbalMode *)viewController;
        controller.delegate = self;
        controller.index = self.gimbalModeIndex;
    }
    if ([viewController isKindOfClass:[C1 class]]) {
        C1 *controller = (C1 *)viewController;
        controller.delegate = self;
        controller.index = self.C1Index;
    }
    if ([viewController isKindOfClass:[C2 class]]) {
        C2 *controller = (C2 *)viewController;
        controller.delegate = self;
        controller.index = self.C2Index;
    }
    
    [self.navigationController pushViewController:viewController animated:NO];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Introduction Video", @"") message:NSLocalizedString(@"Click Okay to watch introduction video for FlyDJI", @"")  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"") style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Okay", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.bilibili.com/video/av7153957/"]];
        }];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        //NSLog(@"%@", title);
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return 0;
    else
        return 30.0;
}


- (void)getFailSafeValue {
    }

- (void)setFailSafeValue: (NSInteger)index {
    
    
}

- (void)getChannelsValue {
    }

- (void)setChannelsValue: (NSInteger)index {
    
}

- (void)getPreviewQualityValue {
    }

- (void)setPreviewQualityValue: (NSInteger)index {
    }



- (void)getGoHomeAltitudeValue {
    
}

- (void)getTurnOnFrontLEDsValue {
    
}

- (void)getGimbalExtensionValue {
    
}

- (void)getVisionSystemValue {
    
}

- (void)getGridlineValue {
    BOOL on = [[NSUserDefaults standardUserDefaults] boolForKey:@"Gridline"];
    self.gridlineSwitch.on = on;
    //[self gridlineAction:self.gridlineSwitch];
}

- (void)getDiagonalValue {
    BOOL on = [[NSUserDefaults standardUserDefaults] boolForKey:@"Diagonal"];
    self.diagonalSwitch.on = on;
    //[self diagonalAction:self.diagonalSwitch];
}

- (void)getGimbalWorkModeValue {
    }

- (void)setGimbalModeValue: (NSInteger)index {
    }

- (void)getHardwareDecodeValue {
    
}

- (void)getC1C2Value {
    }
- (void)setC1Value: (NSInteger)index {
    }

- (void)setC2Value: (NSInteger)index {
    }
- (void)setAccessoryItems {
    [self.goHomeAltitudeField setKeyboardType:UIKeyboardTypePhonePad];
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Done", @"") style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    self.goHomeAltitudeField.inputAccessoryView = numberToolbar;
}
- (void)doneWithNumberPad {
    [self.goHomeAltitudeField endEditing:YES];
}


- (IBAction)goHomeAltitudeAction:(UITextField *)sender {

}
- (IBAction)frontLEDSwitchAction:(UISwitch *)sender {

}
- (IBAction)formatSDCardAction:(UIButton *)sender {

}

- (IBAction)gimbalExtensionAction:(UISwitch *)sender {

}

- (IBAction)visionPositionSystemAction:(UISwitch *)sender {

}

- (IBAction)gridlineAction:(UISwitch *)sender {
    [self.delegate setGridlineSettingDelegate:sender.isOn];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:sender.isOn forKey:@"Gridline"];
}

- (IBAction)hardwareDecodeAction:(UISwitch *)sender {
}

- (IBAction)diagonalAction:(UISwitch *)sender {
    [self.delegate setDiagonalSettingDelegate:sender.isOn];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:sender.isOn forKey:@"Diagonal"];
}


@end
