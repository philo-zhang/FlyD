//
//  DJIAircraftAnnotationView.h
//  DJISdkDemo
//
//  Created by Ares on 15/4/27.
//  Copyright (c) 2015年 DJI. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface AircraftAnnotationView : MAAnnotationView

-(void) updateHeading:(float)heading;

@end
