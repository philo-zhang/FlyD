//
//  FunctionCollectionViewController.m
//  FlyDJI
//
//  Created by zhangzhe on 16/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionCollectionViewController.h"

NSString *kcellID = @"CellID";

@interface FunctionCollectionViewController() {
    NSArray *collectionNameArray;
    NSArray *imageNameArray;
}
@end

@implementation FunctionCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self->collectionNameArray = [[NSArray alloc] initWithObjects:
                                 NSLocalizedString(@"Waypoint", @""),
                                 NSLocalizedString(@"Orbit", @""),
                                 NSLocalizedString(@"Focus", @""),
                                 NSLocalizedString(@"Visual Track", @""),
                                 NSLocalizedString(@"Visual Focus", @""),
                                 NSLocalizedString(@"Motion Focus", @""),
                                 nil];
    self->imageNameArray = [[NSArray alloc] initWithObjects:
                                 @"WaypointMission.png",
                                 @"GpsOrbit.png",
                                 @"GpsFocus.png",
                                 @"VisualTrack.png",
                                 @"VisualFocus.png",
                                 @"MotionFocus.png",
                                 nil];
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
}

- (void)dealloc {
    self->collectionNameArray = nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView: (UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellID forIndexPath:indexPath];
    NSString *string = [self->collectionNameArray objectAtIndex:indexPath.row];
    cell.cellLabel.text = string;
    //cell.cellLabel.font = [UIFont fontWithName:@"System" size:12];
    string = [self->imageNameArray objectAtIndex:indexPath.row];
    cell.Image.image = [UIImage imageNamed:string];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate cellViewSelected:(int)indexPath.row];
    [self dismissViewControllerAnimated:YES completion:^{}];
};

@end
