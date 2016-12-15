//
//  HomeAnnotationView.m
//  FlyDJI
//
//  Created by zhangzhe on 11/11/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import "HomeAnnotationView.h"

@implementation HomeAnnotationView

- (instancetype)initWithAnnotation:(id <MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.enabled = NO;
        self.draggable = NO;
        self.image = [UIImage imageNamed:@"Home.png"];
    }
    
    return self;
}

@end
