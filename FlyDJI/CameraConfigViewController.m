//
//  CameraConfigViewController.m
//  FlyDJI
//
//  Created by zhangzhe on 26/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CameraConfigViewController.h"

@interface CameraConfigViewController () <VideoResolutionDelegate, VideoFormatDelegate, PhotoFormatDelegate, PhotoRatioDelegate, ExposureDelegate> {
    NSArray *viewControllerNames;
}


@end

@implementation CameraConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self->viewControllerNames = [[NSArray alloc] initWithObjects:@"PhotoRatio", @"PhotoFormat", @"VideoResolution", @"VideoFormat", @"Exposure", nil];
    self.navigationItem.title = NSLocalizedString(@"Camera Parameters", @"");
    [self setValues];
}

- (void)dealloc {
}

- (void)setValues {
    [self getPhotoRatioValue];
    [self getPhotoFormatValue];
    [self getVideoResolutionValue];
    [self getVideoFormatValue];
    [self getExposureValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *string = [viewControllerNames objectAtIndex:indexPath.row];
    
    UIViewController *viewController;
    if ([string  isEqual: @"Exposure"])
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:string];
    else
        viewController = [[NSClassFromString(string) alloc] init];
    if (viewController == nil)
        return;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = NSLocalizedString(@"Back", @"");
    self.navigationItem.backBarButtonItem = barButton;
    if ([viewController isKindOfClass:[PhotoFormat class]]) {
        PhotoFormat *controller = (PhotoFormat *)viewController;
        controller.delegate = self;
        controller.index = self.photoFormatIndex;
    }
    if ([viewController isKindOfClass:[PhotoRatio class]]) {
        PhotoRatio *controller = (PhotoRatio *)viewController;
        controller.delegate = self;
        controller.index = self.photoRatioIndex;
    }
    if ([viewController isKindOfClass:[VideoResolution class]]) {
        VideoResolution *controller = (VideoResolution *)viewController;
        controller.delegate = self;
        controller.index = self.videoResolutionIndex;
    }
    if ([viewController isKindOfClass:[VideoFormat class]]) {
        VideoFormat *controller = (VideoFormat *)viewController;
        controller.delegate = self;
        controller.index = self.videoFormatIndex;
    }
    if ([viewController isKindOfClass:[Exposure class]]) {
        Exposure *controller = (Exposure *)viewController;
        controller.delegate = self;
    }
    viewController.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    [self.navigationController pushViewController:viewController animated:NO];
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return 0;
    else
        return 30.0;
}

- (void)getPhotoRatioValue {
}

- (void)setPhotoRatioValue: (NSInteger)index {
}

- (void)getPhotoFormatValue {

}

- (void)setPhotoFormatValue: (NSInteger)index {
}

- (void)getVideoResolutionValue {
}

- (void)setVideoResolutionValue:(NSInteger)index {
 }

- (void)getVideoFormatValue {
}

- (void)setVideoFormatValue: (NSInteger)index {
 }

- (void)getExposureValue {
}

- (void)setExposureValue: (BOOL)isAutoOn {
}
@end
