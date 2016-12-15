//
//  WaypointPoiConfig.h
//  FlyDJI
//
//  Created by zhangzhe on 18/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef WaypointPoiConfig_h
#define WaypointPoiConfig_h

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@class WaypointPoiConfigViewController;
@protocol WaypointPoiConfigViewControllerDelegate <NSObject>

- (void)removePoipoint:(WaypointPoiConfigViewController *)waypointPoiConfigViewController;
- (void)donePoipoint:(WaypointPoiConfigViewController *)waypointPoiConfigViewController;
- (void)modifyPoiHeight:(int)index height:(int)height;

@end

@interface WaypointPoiConfigViewController : UIViewController

@property (weak, nonatomic) id<WaypointPoiConfigViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UINavigationItem *navigationTitle;
@property (weak, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@property (strong, nonatomic) NSMutableArray *poiArray;
@property int poiIndex;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)stepperValueChanged:(id)sender;
- (IBAction)removeAction:(id)sender;
- (IBAction)doneAction:(id)sender;

- (void)poiConfigInit:(NSArray *)poiArray index:(int)poiIndex;

@end
#endif /* WaypointPoiConfig_h */
