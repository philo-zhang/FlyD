//
//  PreviewResolution.h
//  Butterfly
//
//  Created by zhangzhe on 29/8/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef PreviewResolution_h
#define PreviewResolution_h

#import <UIKit/UIKit.h>

@class VideoResolution;
@protocol VideoResolutionDelegate <NSObject>

- (void)setVideoResolutionValue: (NSInteger)index;

@end

@interface VideoResolution : UITableViewController

@property NSInteger index;
@property (nonatomic, strong) id<VideoResolutionDelegate> delegate;


@end

#endif /* PreviewResolution_h */
