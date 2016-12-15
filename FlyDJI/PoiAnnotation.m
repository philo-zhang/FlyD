//
//  PoiAnnotation.m
//  Butterfly
//
//  Created by zhangzhe on 27/8/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import "PoiAnnotation.h"

@implementation PoiAnnotation

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
