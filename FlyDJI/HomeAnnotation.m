//
//  HomeAnnotation.m
//  FlyDJI
//
//  Created by zhangzhe on 11/11/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import "HomeAnnotation.h"

@implementation HomeAnnotation

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


@end

