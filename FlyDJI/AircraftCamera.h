//
//  AircraftCamera.h
//  FlyDJI
//
//  Created by zhangzhe on 20/10/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef AircraftCamera_h
#define AircraftCamera_h

#import <MAMapKit/MAMapKit.h>
#import "AircraftCameraView.h"

@interface AircraftCamera : NSObject<MAAnnotation>

@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) AircraftCameraView *cameraView;

-(id) initWithCoordiante:(CLLocationCoordinate2D)coordinate;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

-(void) updateHeading:(float)heading;

@end

#endif /* AircraftCamera_h */
