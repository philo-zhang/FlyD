//
//  C1.h
//  FlyDJI
//
//  Created by zhangzhe on 20/10/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef C1_h
#define C1_h
#import <UIKit/UIKit.h>

@class C1;
@protocol C1Delegate <NSObject>

- (void)setC1Value: (NSInteger)index;

@end
@interface C1 : UITableViewController

@property (strong, nonatomic) id<C1Delegate> delegate;
@property NSInteger index;

@end

#endif /* C1_h */
