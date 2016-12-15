//
//  GimbalMode.h
//  FlyDJI
//
//  Created by zhangzhe on 20/10/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef GimbalMode_h
#define GimbalMode_h

#import <UIKit/UIKit.h>

@class GimbalMode;
@protocol GimbalModeDelegate <NSObject>

- (void)setGimbalModeValue: (NSInteger)index;

@end
@interface GimbalMode : UITableViewController

@property (strong, nonatomic) id<GimbalModeDelegate> delegate;
@property NSInteger index;

@end

#endif /* GimbalMode_h */
