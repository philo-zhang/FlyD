//
//  AircraftCamera.m
//  FlyDJI
//
//  Created by zhangzhe on 20/10/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import "AircraftCamera.h"

@implementation AircraftCamera

-(id) initWithCoordiante:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
    }
    
    return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _coordinate = newCoordinate;
}

- (void)updateHeading:(float)heading {
    if (self.cameraView) {
        [self.cameraView updateHeading:heading];
    }
}
@end

