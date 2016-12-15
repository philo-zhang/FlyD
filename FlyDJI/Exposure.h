//
//  ExposureViewController.h
//  FlyDJI
//
//  Created by zhangzhe on 26/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef ExposureViewController_h
#define ExposureViewController_h

#import <UIKit/UIKit.h>
#import <DJISDK/DJISDK.h>
#import "Utility.h"

@class Exposure;
@protocol ExposureDelegate <NSObject>

- (void)setExposureValue:(BOOL)isAutoOn;

@end
@interface Exposure : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) DJICamera *camera;

@property (weak, nonatomic) IBOutlet UISwitch *isAuto;
@property (weak, nonatomic) IBOutlet UILabel *isoLabel;
@property (weak, nonatomic) IBOutlet UISlider *isoSlider;
@property (weak, nonatomic) IBOutlet UILabel *shutterspeedLabel;
@property (weak, nonatomic) IBOutlet UISlider *shutterspeedSlider;
@property (weak, nonatomic) IBOutlet UILabel *apertureLabel;
@property (weak, nonatomic) IBOutlet UISlider *apertureSlider;
@property (weak, nonatomic) IBOutlet UILabel *evLabel;
@property (weak, nonatomic) IBOutlet UISlider *evSlider;
@property (weak, nonatomic) id<ExposureDelegate>delegate;

- (IBAction)isAutoAction:(UISwitch *)sender;
- (IBAction)isoAction:(UISlider *)sender;
- (IBAction)shutterspeedAction:(UISlider *)sender;
- (IBAction)apertureAction:(UISlider *)sender;
- (IBAction)evAction:(UISlider *)sender;

@end

#endif /* ExposureViewController_h */
