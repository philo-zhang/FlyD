//
//  FailSafe.h
//  Butterfly
//
//  Created by zhangzhe on 29/8/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef FailSafe_h
#define FailSafe_h

#import <UIKit/UIKit.h>

@class FailSafe;
@protocol FailSafeDelegate <NSObject>

- (void)setFailSafeValue: (NSInteger)index;

@end
@interface FailSafe : UITableViewController

@property (strong, nonatomic) id<FailSafeDelegate> delegate;
@property NSInteger index;

@end

#endif /* FailSafe_h */
