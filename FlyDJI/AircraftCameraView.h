//
//  AircraftCameraView.h
//  FlyDJI
//
//  Created by zhangzhe on 20/10/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef AircraftCameraView_h
#define AircraftCameraView_h
#import <MAMapKit/MAMapKit.h>

@interface AircraftCameraView : MAAnnotationView

-(void) updateHeading:(float)heading;

@end

#endif /* AircraftCameraView_h */
