//
//  PoiAnnotation.h
//  Butterfly
//
//  Created by zhangzhe on 27/8/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef PoiAnnotation_h
#define PoiAnnotation_h

#import <MAMapKit/MAMapKit.h>
#import "PoiAnnotationView.h"

@interface PoiAnnotation : NSObject<MAAnnotation>

@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) PoiAnnotationView* annotationView;
@property int index;
@property int height;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

- (void)updateIndex:(int)index;
- (void)updateHeight:(int)height;

@end

#endif /* PoiAnnotation_h */
