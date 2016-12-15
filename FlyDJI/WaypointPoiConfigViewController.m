//
//  WaypointPoiConfig.m
//  FlyDJI
//
//  Created by zhangzhe on 18/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaypointPoiConfigViewController.h"

@interface WaypointPoiConfigViewController()





@end

@implementation WaypointPoiConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.slider.minimumValue = -200;
    self.slider.maximumValue = 500;
    self.stepper.minimumValue = -200;
    self.stepper.maximumValue = 500;
}

- (void)poiConfigInit:(NSMutableArray *)poiArray index:(int)poiIndex {

    self.view.alpha = 1;
}
- (void)dealloc {
}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    
}

- (IBAction)stepperValueChanged:(UIStepper *)sender {
    }

- (IBAction)removeAction:(id)sender {
    [self.delegate removePoipoint:self];
    self.view.alpha = 0;
}

- (IBAction)doneAction:(id)sender {
    self.view.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
