//
//  Channels.h
//  Butterfly
//
//  Created by zhangzhe on 30/8/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef Channels_h
#define Channels_h

#import <UIKit/UIKit.h>

@class Channels;
@protocol ChannelsDelegate <NSObject>

- (void)setChannelsValue: (NSInteger)index;

@end

@interface Channels : UITableViewController

@property (strong, nonatomic) id<ChannelsDelegate> delegate;
@property NSInteger index;

@end

#endif /* Channels_h */
