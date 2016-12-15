//
//  CameraViewController.m
//  FlyDJI
//
//  Created by zhangzhe on 16/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CameraViewController.h"

@interface CameraViewController() <UIPopoverPresentationControllerDelegate>

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[VideoPreviewer instance] setView:self.view];
    [[VideoPreviewer instance] start];
    [[VideoPreviewer instance] setEnableHardwareDecode:YES];
    //[self addPinchGesture];
    //[self addTapGesture];
    BOOL gridline = [[NSUserDefaults standardUserDefaults] boolForKey:@"Gridline"];
    if (gridline)
       [self addGridlineOverlay];
    BOOL diagonal = [[NSUserDefaults standardUserDefaults] boolForKey:@"Diagonal"];
    if (diagonal)
        [self addDiagonalOverlay];

    //[self.cameraView setImage:[UIImage imageNamed:@"test"]];
    self.isoLabel.text = @"ISO 0";
    self.fLabel.text = @"F 0";
    self.ssLabel.text = @"SS 0.0";
    self.evLabel.text = @"EV 0.0";

    [self.view bringSubviewToFront:self.recordBtn];
    [self.view sendSubviewToBack:self.stopRecordBtn];
    self.stopRecordBtn.imageView.alpha = 0;
    //[self.stopRecordBtn setImage:nil forState:UIControlStateNormal];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[VideoPreviewer instance] resume];
    //[self addTapGesture];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[VideoPreviewer instance] pause];
}

- (void)dealloc {
    [[VideoPreviewer instance] unSetView];
    [self.view removeFromSuperview];
    self.view = nil;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
}

- (IBAction)recordBtnAction:(id)sender {
}

- (IBAction)stopRecordBtnAction:(id)sender {
 
}

- (void)modifyRecordBtn:(BOOL)isRecording {
}

/*
- (void)addPinchGesture {
    self.pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(startTrack:)];
    [self.view addGestureRecognizer:self.pinchGestureRecognizer];
}

- (void)removePinchGesture {
    [self.view removeGestureRecognizer:self.pinchGestureRecognizer];
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.count == 1 && self.isTrackAvailable) {
        if (self.rectOverlay == nil)
            [self addOverlayRect];
        [self.delegate stopTrack];
        UITouch *touch = [touches anyObject];
        self.startTouchPoint = [touch locationInView:self.view];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.count == 1 && self.isTrackAvailable) {
        UITouch *touch = [touches anyObject];
        CGPoint p2 = [touch locationInView:self.view];
        CGPoint p1 = self.startTouchPoint;
        int x = MIN(p1.x, p2.x);
        int y = MIN(p1.y, p2.y);
        int width = fabs(p1.x - p2.x);
        int height = fabs(p1.y - p2.y);
        self.rect = CGRectMake(x, y, width, height);
        if (self.rect.size.width > 10 || self.rect.size.height > 10)
            [self moveRect:self.rect];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.count == 1 && self.isTrackAvailable) {
        [self.delegate startTrack:self.rect];
    }
}

- (void)addTapGesture {
    self.tapGestureReconizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startFocus:)];
    self.tapGestureReconizer.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:self.tapGestureReconizer];
}

- (void)removeTapGesture {
    [self.view removeGestureRecognizer:self.tapGestureReconizer];
}



- (void) startFocus:(UITapGestureRecognizer *)tapGestureRecognizer {
}
-(void)addOverlayRect {
    self.rectOverlay=[CAShapeLayer layer];
    self.rectOverlay.fillColor= [[UIColor colorWithRed:78/255.0 green:115/255.0 blue:230/255.0 alpha:0.3] CGColor];
    self.rectOverlay.lineWidth = 2.0f;
    self.rectOverlay.lineCap = kCALineCapRound;
    self.rectOverlay.strokeColor = [[UIColor colorWithRed:78/255.0 green:115/255.0 blue:230/255.0 alpha:1] CGColor];
    [self.view.layer addSublayer:self.rectOverlay];
}

- (void)removeOverlayRect {
    [self.rectOverlay removeFromSuperlayer];
    self.rectOverlay = nil;
}
-(void)moveRect:(CGRect)rect {
    
    UIBezierPath * rectPath=[UIBezierPath bezierPath];
    
    //Rectangle coordinates
    CGPoint view1Center=rect.origin;
    CGPoint view4Center=CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGPoint view2Center=CGPointMake(view4Center.x, view1Center.y);
    CGPoint view3Center=CGPointMake(view1Center.x, view4Center.y);
    
    //Rectangle drawing
    [rectPath moveToPoint:view1Center];
    [rectPath addLineToPoint:view2Center];
    [rectPath addLineToPoint:view4Center];
    [rectPath addLineToPoint:view3Center];
    [rectPath addLineToPoint:view1Center];
    
    self.rectOverlay.path=rectPath.CGPath;
}

- (void)addGridlineOverlay {
    self.gridOverlay = [CAShapeLayer layer];
    //self.gridOverlay.fillColor = [UIColor colorWithWhite:0.5 alpha:1].CGColor;
    self.gridOverlay.lineWidth = 1.5f;
    self.gridOverlay.lineCap = kCALineCapRound;
    self.gridOverlay.strokeColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
    [self.view.layer addSublayer:self.gridOverlay];
    [self addGridlinePath];
}

- (void)addGridlinePath{
    UIBezierPath *gridPath = [UIBezierPath bezierPath];
    
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    CGPoint left1 = CGPointMake(0, height/3);
    CGPoint left2 = CGPointMake(0, height*2/3);
    CGPoint right1 = CGPointMake(width, height/3);
    CGPoint right2 = CGPointMake(width, height*2/3);
    CGPoint up1 = CGPointMake(width/3, 0);
    CGPoint up2 = CGPointMake(width*2/3, 0);
    CGPoint bottom1 = CGPointMake(width/3, height);
    CGPoint bottom2 = CGPointMake(width*2/3, height);
    
    [gridPath moveToPoint:left1];
    [gridPath addLineToPoint:right1];
    [gridPath moveToPoint:left2];
    [gridPath addLineToPoint:right2];
    [gridPath moveToPoint:up1];
    [gridPath addLineToPoint:bottom1];
    [gridPath moveToPoint:up2];
    [gridPath addLineToPoint:bottom2];
    self.gridOverlay.path = gridPath.CGPath;
}

- (void)removeGridlineOverlay {
    [self.gridOverlay removeFromSuperlayer];
}

- (void)addDiagonalOverlay {
    self.diagonalOverlay = [CAShapeLayer layer];
    //self.gridOverlay.fillColor = [UIColor colorWithWhite:0.5 alpha:1].CGColor;
    self.diagonalOverlay.lineWidth = 1.5f;
    self.diagonalOverlay.lineCap = kCALineCapRound;
    self.diagonalOverlay.strokeColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
    [self.view.layer addSublayer:self.diagonalOverlay];
    [self addDiagonalPath];
}

- (void)addDiagonalPath {
    UIBezierPath *diagonalPath = [UIBezierPath bezierPath];
    
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    CGPoint leftup = CGPointMake(0, 0);
    CGPoint leftbottom = CGPointMake(0, height);
    CGPoint rightup = CGPointMake(width,0);
    CGPoint rightbottom = CGPointMake(width, height);

    
    [diagonalPath moveToPoint:leftup];
    [diagonalPath addLineToPoint:rightbottom];
    [diagonalPath moveToPoint:leftbottom];
    [diagonalPath addLineToPoint:rightup];
    self.diagonalOverlay.path = diagonalPath.CGPath;
}

- (void)removeDiagonalOverlay {
    [self.diagonalOverlay removeFromSuperlayer];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"Config"]) {
        segue.destinationViewController.popoverPresentationController.delegate = self;
        segue.destinationViewController.preferredContentSize = CGSizeMake(200, 250);
    }
    segue.destinationViewController.popoverPresentationController.backgroundColor = [UIColor clearColor];
    [self.delegate hideConfigViews];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
    // This method is called in iOS 8.3 or later regardless of trait collection, in which case use the original presentation style (UIModalPresentationNone signals no adaptation)
    return UIModalPresentationNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
