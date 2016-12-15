//
//  ISO.h
//  Butterfly
//
//  Created by zhangzhe on 29/8/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef ISO_h
#define ISO_h
#import <UIKit/UIKit.h>

@class ISO;
@protocol ISODelegate <NSObject>

- (void)setISOValue: (NSInteger)index;

@end

@interface ISO : UITableViewController

@property (strong, nonatomic) id<ISODelegate> delegate;
@property NSInteger index;

@end

#endif /* ISO_h */
