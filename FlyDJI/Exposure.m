//
//  ExposureViewController.m
//  FlyDJI
//
//  Created by zhangzhe on 26/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Exposure.h"

@interface Exposure() {
    NSArray *isoArray;
    NSArray *ssArray;
    NSArray *apertArray;
    NSArray *evArray;
}

@end
@implementation Exposure

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;
}

- (void)initUI {
    self->isoArray = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Auto", @""), @"100", @"200", @"400", @"800", @"1600", @"3200", @"6400", @"12800", @"25600", nil];
    self->ssArray = [[NSArray alloc] initWithObjects:@"1/8000", @"1/6400", @"1/5000", @"1/4000", @"1/3200", @"1/2500", @"1/2000", @"1/1600", @"1/1250", @"1/1000", @"1/800", @"1/640", @"1/500", @"1/400", @"1/320", @"1/240", @"1/200", @"1/160", @"1/120", @"1/100", @"1/80", @"1/60", @"1/50", @"1/40", @"1/30", @"1/25", @"1/20", @"1/15", @"1/12.5", @"1/10", @"1/8", @"1/6.25", @"1/5", @"1/4", @"1/3", @"1/2.5", @"1/2", @"1/1.67", @"1/1.25", @"1.0", @"2.0", @"2.5", @"3.0", @"3.2", @"4.0", @"5.0", @"6.0", @"7.0", @"8.0", @"9.0", @"10.0", @"13.0", @"15.0", @"20.0", @"25.0", @"30.0", nil];
    self->apertArray = [[NSArray alloc] initWithObjects:@"F1.7", @"F1.8", @"F2", @"F2.2", @"F2.5", @"F2.8", @"F3.2", @"F3.5", @"F4", @"F4.5", @"F5", @"F5.6", @"F6.3", @"F7.1", @"F8", @"F8", @"F10", @"F11", @"F13", @"F14", @"F16", @"F18", @"F20", @"F22", nil];
    
    self->evArray = [[NSArray alloc] initWithObjects:@"-5.0", @"-4.7", @"-4.3", @"-4.0", @"-3.7", @"-3.3", @"-3.0", @"-2.7", @"-2.3", @"-2.0", @"-1.7", @"-1.3", @"-1.0", @"-0.7", @"-0.3", @"0", @"+0.3", @"+0.7", @"+1.0", @"+1.3", @"+1.7", @"+2.0", @"+2.3", @"+2.7", @"+3.0", @"+3.3", @"+3.7", @"+4.0", @"+4.3", @"+4.7", @"+5.0", nil];
     
    self.camera = [Utility fetchCamera];
    [self.camera getExposureModeWithCompletion:^(DJICameraExposureMode mode, NSError * _Nullable error) {
        if (error) {
            //NSLog(@"camera error");
        }
        else {
            if (mode == DJICameraExposureModeManual) {
                self.isAuto.on = NO;
            }
            else {
                self.isAuto.on = YES;
            }
            [self isAutoAction:self.isAuto];
        }
    }];
    self.isoSlider.minimumValue = 0;
    self.isoSlider.maximumValue = self->isoArray.count - 1;
    self.isoSlider.continuous = YES;
    [self.camera getISOWithCompletion:^(DJICameraISO iso, NSError * _Nullable error) {
        //NSLog(@"iso: %d", (int)iso);
        if (!error){
            self.isoSlider.value = iso;
            self.isoLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"ISO: %@", @"Show ISO"), [isoArray objectAtIndex:iso]];
        }
        else
            self.isoLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"ISO: %@", @"Show ISO"), @"N/A"];
    }];
    
    self.shutterspeedSlider.minimumValue = 0;
    self.shutterspeedSlider.maximumValue = ssArray.count - 1;
    [self.camera getShutterSpeedWithCompletion:^(DJICameraShutterSpeed shutterSpeed, NSError * _Nullable error) {
        if (!error){
            //NSLog(@"ss: %d", (int)shutterSpeed);
            self.shutterspeedSlider.value = shutterSpeed;
            self.shutterspeedLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"Shutter Speed: %@", "Show Shutter Speed"), [ssArray objectAtIndex:shutterSpeed]];
        }
        else
            self.shutterspeedLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"Shutter Speed: %@", "Show Shutter Speed"), @"N/A"];
    }];
    
    self.apertureSlider.minimumValue = 0;
    self.apertureSlider.maximumValue = apertArray.count - 1;
    [self.camera getApertureWithCompletion:^(DJICameraAperture aperture, NSError * _Nullable error) {
        //NSLog(@"apert: %d", (int)aperture);
        if (!error) {
            if (aperture < apertArray.count) {
                self.apertureSlider.value = aperture;
                self.apertureLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"Aperture: %@", "Show Aperture"), [apertArray objectAtIndex:aperture]];
                self.apertureSlider.enabled = YES;
            }
            else {
                self.apertureLabel.text = [NSString localizedStringWithFormat:NSLocalizedString(@"Aperture: %@", "Show Aperture"), @"N/A"];
                self.apertureSlider.enabled = NO;
            }
        }
        else
            self.apertureLabel.text = [NSString localizedStringWithFormat:NSLocalizedString(@"Aperture: %@", "Show Aperture"), @"N/A"];
    }];
    
    self.evSlider.minimumValue = 0;
    self.evSlider.maximumValue = evArray.count - 1;
    [self.camera getExposureCompensationWithCompletion:^(DJICameraExposureCompensation exposureCompensation, NSError * _Nullable error) {
        if (!error) {
            self.evSlider.value = exposureCompensation - 1;
            if (self.isAuto.on == YES)
                self.evLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"EV: %@", "Show EV"), [evArray objectAtIndex:exposureCompensation - 1]];
            else
                self.evLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"EV: %@", "Show EV"), @"N/A"];
        }
        else
            self.evLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"EV: %@", "Show EV"), @"N/A"];
    }];
}

- (void)dealloc {
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.delegate setExposureValue:self.isAuto.on];
}

- (IBAction)isAutoAction:(UISwitch *)sender {
    WeakRef(weakself);
    if (sender.on) {
        [self.camera setExposureMode:DJICameraExposureModeProgram withCompletion:^(NSError * _Nullable error) {
            if (error) {
                //NSLog(@"set exposure mode error");
            }
            else {
                weakself.isoSlider.enabled = NO;
                weakself.isoLabel.enabled = NO;
                weakself.shutterspeedSlider.enabled = NO;
                weakself.shutterspeedLabel.enabled = NO;
                weakself.apertureSlider.enabled = NO;
                weakself.apertureLabel.enabled = NO;
                weakself.evSlider.enabled = YES;
                weakself.evLabel.enabled = YES;
            }
        }];
    }
    else {
        [self.camera setExposureMode:DJICameraExposureModeManual withCompletion:^(NSError * _Nullable error) {
            if (error) {
                //NSLog(@"set exposure mode error");
            }
            else {
                weakself.isoSlider.enabled = YES;
                weakself.isoLabel.enabled = YES;
                weakself.shutterspeedSlider.enabled = YES;
                weakself.shutterspeedLabel.enabled = YES;
                weakself.apertureSlider.enabled = YES;
                weakself.apertureLabel.enabled = YES;
                weakself.evSlider.enabled = NO;
                weakself.evLabel.enabled = YES;
            }
        }];
    }
}

- (IBAction)isoAction:(UISlider *)sender {
    WeakRef(weakself);
    [self.camera setISO:(int)sender.value withCompletion:^(NSError * _Nullable error) {
        if (!error)
            weakself.isoLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"ISO: %@", @"Show ISO"), [isoArray objectAtIndex:(int)sender.value]];
    }];
}

- (IBAction)shutterspeedAction:(UISlider *)sender {
    WeakRef(weakself);
    [self.camera setShutterSpeed:(int)sender.value withCompletion:^(NSError * _Nullable error) {
        if (!error)
            weakself.shutterspeedLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"Shutter Speed: %@", @"Show Shutter Speed"), [ssArray objectAtIndex:(int)sender.value]];
    }];
}

- (IBAction)apertureAction:(UISlider *)sender {
    WeakRef(weakself);
    [self.camera setAperture:(int)sender.value withCompletion:^(NSError * _Nullable error) {
        if (!error)
            weakself.apertureLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"Aperture: %@", @"Show Aperture"), [apertArray objectAtIndex:(int)sender.value]];
    }];
}

- (IBAction)evAction:(UISlider *)sender {
    WeakRef(weakself);
    [self.camera setExposureCompensation:(int)sender.value+1 withCompletion:^(NSError * _Nullable error) {
        if (!error)
            weakself.evLabel.text = [NSString  localizedStringWithFormat:NSLocalizedString(@"EV: %@", @"Show EV"), [evArray objectAtIndex:(int)sender.value]];
    }];
}
@end
