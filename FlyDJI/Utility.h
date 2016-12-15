//
//  Utilities.h
//  Butterfly
//
//  Created by zhangzhe on 1/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef Utilities_h
#define Utilities_h
#import <UIKit/UIKit.h>
#import <DJISDK/DJISDK.h>

#define WeakRef(__obj) __weak typeof(self) __obj = self
#define WeakReturn(__obj) if(__obj ==nil)return;

#define DEGREE(x) ((x)*180.0/M_PI)
#define RADIAN(x) ((x)*M_PI/180.0)

//extern void ShowMessage(NSString *title, NSString *message, id target, NSString *cancleBtnTitle);


@interface Utility : NSObject

+ (void)showAlert:(id)target title:(NSString *)title message:(NSString *)message;

+ (DJIFlightController *)fetchFlightController;

+ (DJIBattery *)fetchBattery;

+ (DJICamera *)fetchCamera;

+ (DJIGimbal *)fetchGimbal;

+ (DJILBAirLink*) fetchLBAirLink;

+ (DJIRemoteController *)fetchRemoteController;

+ (float)angleFromCoordinate:(CLLocationCoordinate2D)first
                toCoordinate:(CLLocationCoordinate2D)second;

@end

#endif /* Utilities_h */
