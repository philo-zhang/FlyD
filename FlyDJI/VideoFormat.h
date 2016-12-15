//
//  VideoFormat.h
//  Butterfly
//
//  Created by zhangzhe on 29/8/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef VideoFormat_h
#define VideoFormat_h
#import <UIKit/UIKit.h>

@class VideoFormat;
@protocol VideoFormatDelegate <NSObject>

- (void)setVideoFormatValue: (NSInteger)index;

@end

@interface VideoFormat: UITableViewController

@property (strong, nonatomic) id<VideoFormatDelegate> delegate;
@property NSInteger index;

@end

#endif /* VideoFormat_h */
