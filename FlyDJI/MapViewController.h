//
//  MapViewController.h
//  FlyDJI
//
//  Created by zhangzhe on 16/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef MapViewController_h
#define MapViewController_h
#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import "PoiAnnotation.h"
#import "AircraftAnnotation.h"
#import "AircraftCamera.h"
#import "HomeAnnotation.h"
#import "WaypointAnnotation.h"
#import "Utility.h"
#import "LocationConverter.h"
#import "MACurveline.h"

@class MapViewController;
@protocol MapViewControllerDelegate <NSObject>

- (void)waypointConfigMapViewController:(int)index;

- (void)poiConfigMapViewController:(int)index;

- (void)updateWaypointMapVC:(int)index;

- (void)setStateLabel:(bool)isWhite;

@end

@interface MapViewController : UIViewController

//@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MAMapView *mapView;
@property (strong, nonatomic) MAPolyline *path;
@property (strong, nonatomic) NSMutableArray *curvePolylines;
@property (strong, nonatomic) MACircle *circle;

@property (weak, nonatomic) IBOutlet UIView *mapParamView;
@property (weak, nonatomic) id<MapViewControllerDelegate>delegate;

@property (assign, nonatomic) CLLocationCoordinate2D userLocation;
@property (assign, nonatomic) CLLocationCoordinate2D droneLocation;

@property (strong, nonatomic) NSMutableArray *waypointAnnotations;
@property (strong, nonatomic) NSMutableArray *poipointAnnotations;

@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UIButton *switchBtn;
@property (weak, nonatomic) IBOutlet UIButton *compassBtn;


@property (strong, nonatomic) AircraftAnnotation *aircraftAnnotation;
@property (strong, nonatomic) AircraftCamera *aircraftCamera;
@property (strong, nonatomic) HomeAnnotation *homeAnnotation;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) DJIWaypointMission *waypointMission;


- (IBAction)switchBtnAction:(id)sender;
- (IBAction)focusBtnAction:(id)sender;

- (void)addWaypointAnnotation:(CLLocationCoordinate2D)coordinate waypointMission:(DJIWaypointMission *)waypointMission isCurve:(int)isCurve percent:(int)percent;

- (void)addPoipointAnnotation:(CLLocationCoordinate2D)coordinate;

- (void)replacePoipointAnnotation:(CLLocationCoordinate2D)coordinate;

- (void)removeWaypointAnnotation:(int)index;

- (void)removePoipointAnnotation:(int)index;

- (void)removeAllpointsAnnotations;

- (void)updateAircraftLocation:(CLLocationCoordinate2D)location;

- (void)updateHomeLocation:(CLLocationCoordinate2D)location;

- (void)updateAircraftHeading:(float)heading;

- (void)updateCameraHeading: (float)heading;

- (void)updateCircle:(float)radius;

- (void)updateCurve:(int)index isCurve:(BOOL)isCurve coor1:(CLLocationCoordinate2D)coor1 coor2:(CLLocationCoordinate2D)coor2 coorC:(CLLocationCoordinate2D)coorC;
@end

#endif /* MapViewController_h */
