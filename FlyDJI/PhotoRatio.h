//
//  PhotoRatio.h
//  Butterfly
//
//  Created by zhangzhe on 29/8/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef PhotoRatio_h
#define PhotoRatio_h
#import <UIKit/UIKit.h>

@class PhotoRatio;
@protocol PhotoRatioDelegate <NSObject>

- (void)setPhotoRatioValue: (NSInteger)index;

@end
@interface PhotoRatio : UITableViewController

@property (strong, nonatomic) id<PhotoRatioDelegate> delegate;
@property NSInteger index;

@end

#endif /* PhotoRatio_h */
