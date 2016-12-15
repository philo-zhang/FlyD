//
//  AircraftCameraView.m
//  FlyDJI
//
//  Created by zhangzhe on 20/10/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import "AircraftCameraView.h"

@implementation AircraftCameraView

- (instancetype)initWithAnnotation:(id <MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.enabled = NO;
        self.draggable = NO;
        self.image = [UIImage imageNamed:@"CameraOrientation.png"];
        //self.centerOffset = CGPointMake(0, -10);
    }
    
    return self;
}

-(void) updateHeading:(float)heading
{
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, -10), CGAffineTransformMakeRotation(heading));
}

@end

