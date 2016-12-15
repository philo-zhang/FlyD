//
//  WaypointAnnotationView.m
//  FlyDJI
//
//  Created by zhangzhe on 5/10/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaypointAnnotationView.h"

@implementation WaypointAnnotationView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier index:(int)index height:(int)height{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    self.image = [UIImage imageNamed:@"WaypointPoint.png"];
    self.centerOffset = CGPointMake(0, -20);
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0,self.frame.size.height/2-5,self.frame.size.width,15)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor whiteColor];
    self.label.text = [NSString  localizedStringWithFormat:@"%d", index];
    self.label.font = [UIFont systemFontOfSize:13];
    self.height = [[UILabel alloc] initWithFrame:CGRectMake(0,5,self.frame.size.width,15)];
    self.height.textAlignment = NSTextAlignmentCenter;
    self.height.textColor = [UIColor greenColor];
    self.height.text = [NSString  localizedStringWithFormat:@"%dm", height];
    self.height.font = [UIFont systemFontOfSize:8];
    [self addSubview:self.label];
    [self addSubview:self.height];
    return self;
}

- (void)updateIndex:(int)index {
    self.label.text = [NSString  localizedStringWithFormat:@"%d", index];
}

- (void)updateHeight:(int)height {
    self.height.text = [NSString localizedStringWithFormat:@"%dm",height];
}

@end
