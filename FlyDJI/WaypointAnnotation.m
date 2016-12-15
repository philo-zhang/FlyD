//
//  WaypointAnnotation.m
//  FlyDJI
//
//  Created by zhangzhe on 5/10/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaypointAnnotation.h"

@implementation WaypointAnnotation

-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate
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

- (void)updateIndex:(int)index {
    self.index = index;
    if (self.annotationView)
        [self.annotationView updateIndex:index];
}

- (void)updateHeight:(int)height {
    self.height = height;
    if (self.annotationView)
        [self.annotationView updateHeight:height];
}

@end
