//
//  PhotoFormat.h
//  Butterfly
//
//  Created by zhangzhe on 29/8/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef PhotoFormat_h
#define PhotoFormat_h
#import <UIKit/UIKit.h>

@class PhotoFormat;
@protocol PhotoFormatDelegate <NSObject>

- (void)setPhotoFormatValue: (NSInteger)index;

@end

@interface PhotoFormat : UITableViewController

@property (strong, nonatomic) id<PhotoFormatDelegate> delegate;
@property NSInteger index;

@end

#endif /* PhotoFormat_h */
