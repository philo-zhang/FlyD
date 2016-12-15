//
//  Utilities.m
//  Butterfly
//
//  Created by zhangzhe on 1/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import "Utility.h"

/*
inline void ShowMessage(NSString *title, NSString *message, id target, NSString *cancleBtnTitle)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:target cancelButtonTitle:cancleBtnTitle otherButtonTitles:nil];
        [alert show];
    });
}
*/

@implementation Utility

+ (void)showAlert:(id)target title:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    //NSLog(@"%@", title);
    [target presentViewController:alert animated:YES completion:nil];
}

+ (DJIFlightController *)fetchFlightController {
    if (![DJISDKManager product]) {
        return nil;
    }
    
    if ([[DJISDKManager product] isKindOfClass:[DJIAircraft class]]) {
        return ((DJIAircraft*)[DJISDKManager product]).flightController;
    }
    
    return nil;
}

// DJI fetch Battery
+ (DJIBattery *)fetchBattery {
    if (![DJISDKManager product]) {
        return nil;
    }
    if ([[DJISDKManager product] isKindOfClass:[DJIAircraft class]]) {
        return ((DJIAircraft*)[DJISDKManager product]).battery;
    }
    if ([[DJISDKManager product] isKindOfClass:[DJIHandheld class]]) {
        return ((DJIHandheld*)[DJISDKManager product]).battery;
    }
    return nil;
}

+ (DJICamera *)fetchCamera {
    if (![DJISDKManager product]) {
        return nil;
    }
    if ([[DJISDKManager product] isKindOfClass:[DJIAircraft class]]) {
        return ((DJIAircraft *)[DJISDKManager product]).camera;
    }
    else if ([[DJISDKManager product] isKindOfClass:[DJIHandheld class]]) {
        return ((DJIHandheld*)[DJISDKManager product]).camera;
    }
    return nil;
}

+ (DJIGimbal *) fetchGimbal {
    if (![DJISDKManager product]) {
        return nil;
    }
    if ([[DJISDKManager product] isKindOfClass:[DJIAircraft class]]) {
        return ((DJIAircraft*)[DJISDKManager product]).gimbal;
    }
    else if ([[DJISDKManager product] isKindOfClass:[DJIHandheld class]]) {
        return ((DJIHandheld*)[DJISDKManager product]).gimbal;
    }
    return nil;
}


+ (DJILBAirLink*) fetchLBAirLink {
    if (![DJISDKManager product]) {
        return nil;
    }
    
    if ([[DJISDKManager product] isKindOfClass:[DJIAircraft class]]) {
        DJIAirLink *Airlink = ((DJIAircraft *)[DJISDKManager product]).airLink;
        if (Airlink.isLBAirLinkSupported) {
            return Airlink.lbAirLink;
        }
        else {
            return nil;
        }
    }
    if ([[DJISDKManager product] isKindOfClass:[DJIHandheld class]]) {
        DJIAirLink *Airlink = ((DJIHandheld *)[DJISDKManager product]).airLink;
        if (Airlink.isLBAirLinkSupported) {
            return Airlink.lbAirLink;
        }
        else {
            return nil;
        }
    }
    
    return nil;
}

+ (DJIRemoteController *)fetchRemoteController {
    if (![DJISDKManager product]) {
        return nil;
    }
    if ([[DJISDKManager product] isKindOfClass:[DJIAircraft class]]) {
        return ((DJIAircraft*)[DJISDKManager product]).remoteController;
    }
    return nil;
}

+ (float)angleFromCoordinate:(CLLocationCoordinate2D)first
                toCoordinate:(CLLocationCoordinate2D)second {
    
    float deltaLongitude = second.longitude - first.longitude;
    float deltaLatitude = second.latitude - first.latitude;
    if (deltaLatitude == 0) {
        if (deltaLongitude > 0)
            return M_PI / 2;
        else
            return M_PI * 3 / 2;
    }
    float angle = atan(deltaLongitude / deltaLatitude);
    
    if (deltaLongitude > 0 && deltaLatitude > 0)
        angle = angle;
    else if (deltaLongitude > 0 && deltaLatitude < 0)
        angle = M_PI + angle;
    else if (deltaLongitude < 0 && deltaLatitude < 0)
        angle = angle - M_PI;
    else
        angle = angle;
    return angle;
}


@end

