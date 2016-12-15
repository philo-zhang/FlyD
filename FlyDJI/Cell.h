//
//  Cell.h
//  ButterflyTrack
//
//  Created by zhangzhe on 5/8/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef Cell_h
#define Cell_h
#import <UIKit/UIKit.h>

@interface Cell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@end

#endif /* Cell_h */
