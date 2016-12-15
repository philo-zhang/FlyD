//
//  PreviewQuality.h
//  Butterfly
//
//  Created by zhangzhe on 30/8/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef PreviewQuality_h
#define PreviewQuality_h

#import <UIKit/UIKit.h>

@class PreviewQuality;
@protocol PreviewQualityDelegate <NSObject>

- (void)setPreviewQualityValue: (NSInteger)index;

@end

@interface PreviewQuality : UITableViewController

@property (strong, nonatomic) id<PreviewQualityDelegate> delegate;
@property NSInteger index;

@end

#endif /* PreviewQuality_h */
