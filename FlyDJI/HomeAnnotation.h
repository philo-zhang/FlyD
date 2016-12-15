//
//  HomeAnnotation.h
//  FlyDJI
//
//  Created by zhangzhe on 11/11/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef HomeAnnotation_h
#define HomeAnnotation_h


#import <MAMapKit/MAMapKit.h>
#import "HomeAnnotationView.h"

@interface HomeAnnotation : NSObject<MAAnnotation>

@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) HomeAnnotationView* annotationView;

-(id) initWithCoordiante:(CLLocationCoordinate2D)coordinate;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end

#endif /* HomeAnnotation_h */
