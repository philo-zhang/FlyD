//
//  CameraViewController.h
//  FlyDJI
//
//  Created by zhangzhe on 16/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef CameraViewController_h
#define CameraViewController_h

#import <UIKit/UIKit.h>
#import <VideoPreviewer/VideoPreviewer.h>
#include <AudioToolbox/AudioToolbox.h>
#import "CameraConfigViewController.h"

@class CameraViewController;
@protocol CameraViewControllerDelegate <NSObject>

- (void)startTrack:(CGRect)rect;
- (void)stopTrack;
- (void)hideConfigViews;

@end

@interface CameraViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *cameraParamView;
@property (weak, nonatomic) IBOutlet UILabel *isoLabel;
@property (weak, nonatomic) IBOutlet UILabel *fLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssLabel;
@property (weak, nonatomic) IBOutlet UILabel *evLabel;

@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopRecordBtn;

@property (weak, nonatomic) IBOutlet UIButton *settingsBtn;
@property CAShapeLayer *rectOverlay;
@property CAShapeLayer *gridOverlay;
@property CAShapeLayer *diagonalOverlay;

//@property (strong, nonatomic) UIPinchGestureRecognizer *pinchGestureRecognizer;
//@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property CGPoint startTouchPoint;
@property bool isTrackAvailable;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureReconizer;

@property (weak, nonatomic) id<CameraViewControllerDelegate>delegate;

@property BOOL isRecording;

@property CGRect rect;

- (IBAction)recordBtnAction:(id)sender;
- (IBAction)stopRecordBtnAction:(id)sender;

- (void)modifyRecordBtn:(BOOL)isRecording;

//- (void)addPinchGesture;
//- (void)removePinchGesture;
- (void)addTapGesture;
- (void)removeTapGesture;
-(void)addOverlayRect;
- (void)removeOverlayRect;
- (void)addGridlineOverlay;
- (void)addGridlinePath;
- (void)removeGridlineOverlay;
- (void)addDiagonalOverlay;
- (void)addDiagonalPath;
- (void)removeDiagonalOverlay;

- (void)moveRect:(CGRect)rect;

@end

#endif /* CameraViewController_h */
