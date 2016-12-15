//
//  FunctionCollectionViewController.h
//  FlyDJI
//
//  Created by zhangzhe on 16/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef FunctionCollectionViewController_h
#define FunctionCollectionViewController_h

#import <UIKit/UIKit.h>
#import "Cell.h"

@class FunctionCollectionViewController;
@protocol FunctionCollectionViewControllerDelegate <NSObject>

- (void) cellViewSelected:(int)index;

@end

@interface FunctionCollectionViewController : UICollectionViewController

@property (weak, nonatomic) id<FunctionCollectionViewControllerDelegate> delegate;

@end

#endif /* FunctionCollectionViewController_h */
