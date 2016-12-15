//
//  WaypointAnnotation.h
//  FlyDJI
//
//  Created by zhangzhe on 5/10/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef WaypointAnnotation_h
#define WaypointAnnotation_h

#import <MAMapKit/MAMapKit.h>
#import "WaypointAnnotationView.h"

@interface WaypointAnnotation : NSObject<MAAnnotation>

@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) WaypointAnnotationView* annotationView;
@property int index;
@property int height;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

- (void)updateIndex:(int)index;

- (void)updateHeight:(int)height;

@end

#endif /* WaypointAnnotation_h */
