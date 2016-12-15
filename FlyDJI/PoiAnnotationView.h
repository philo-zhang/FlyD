//
//  PoiAnnotationView.h
//  FlyDJI
//
//  Created by zhangzhe on 1/10/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef PoiAnnotationView_h
#define PoiAnnotationView_h

#import "MAMapKit/MAMapKit.h"

@interface PoiAnnotationView : MAAnnotationView

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UILabel *height;

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier index:(int)index height:(int)height;
- (void)updateIndex:(int)index;
- (void)updateHeight:(int)height;
@end
#endif /* PoiAnnotationView_h */
