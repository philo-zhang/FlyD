//
//  CameraConfigViewController.h
//  FlyDJI
//
//  Created by zhangzhe on 26/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef CameraConfigViewController_h
#define CameraConfigViewController_h

#import <UIKit/UIKit.h>
#import "DJISDK/DJISDK.h"
#import "VideoResolution.h"
#import "VideoFormat.h"
#import "PhotoFormat.h"
#import "PhotoRatio.h"
#import "Exposure.h"
#import "Utility.h"

@interface CameraConfigViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *photoRatio;
@property (weak, nonatomic) IBOutlet UILabel *photoFormat;
@property (weak, nonatomic) IBOutlet UILabel *videoResolution;
@property (weak, nonatomic) IBOutlet UILabel *videoFormat;
@property (weak, nonatomic) IBOutlet UILabel *exposure;

@property NSInteger photoRatioIndex;
@property NSInteger photoFormatIndex;
@property NSInteger videoResolutionIndex;
@property NSInteger videoFormatIndex;
@property BOOL isExposureAuto;


@end
#endif /* CameraConfigViewController_h */
