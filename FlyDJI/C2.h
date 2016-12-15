//
//  C2.h
//  FlyDJI
//
//  Created by zhangzhe on 20/10/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef C2_h
#define C2_h

#import <UIKit/UIKit.h>

@class C2;
@protocol C2Delegate <NSObject>

- (void)setC2Value: (NSInteger)index;

@end
@interface C2 : UITableViewController

@property (strong, nonatomic) id<C2Delegate> delegate;
@property NSInteger index;

@end

#endif /* C2_h */
