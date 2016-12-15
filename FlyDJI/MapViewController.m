//
//  MapViewController.m
//  FlyDJI
//
//  Created by zhangzhe on 16/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MapViewController.h"


@interface MapViewController()<MAMapViewDelegate, CLLocationManagerDelegate>



@end

@implementation MapViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];

    self.mapView.frame = self.view.bounds;
    self.mapView.delegate = self;
    BOOL isStandard = [[NSUserDefaults standardUserDefaults] boolForKey:@"MapType"];
    self.mapView.mapType = isStandard;
    //[self.delegate setStateLabel:isStandard];
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
    self.userLocation = kCLLocationCoordinate2DInvalid;
    self.droneLocation = kCLLocationCoordinate2DInvalid;
    self.waypointAnnotations = [[NSMutableArray alloc] init];
    self.poipointAnnotations = [[NSMutableArray alloc] init];
    self.curvePolylines = [[NSMutableArray alloc] init];
    self.mapView.showsScale = NO;
    self.mapView.showsUserLocation = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    //_mapView.showsCompass= YES; // 设置成NO表示关闭指南针；YES表示显示指南针
    _mapView.compassOrigin= CGPointMake(self.compassBtn.frame.origin.x, self.compassBtn.frame.origin.y + 1); //设置指南针位置
    [_mapView setCompassImage:[UIImage imageNamed:@"Compass"]];
    [self.view sendSubviewToBack:self.compassBtn];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    
}

- (IBAction)switchBtnAction:(id)sender {
    if (self.mapView.mapType == MKMapTypeSatellite) {
        self.mapView.mapType = MKMapTypeStandard;
        [self.delegate setStateLabel:NO];
    }
    else {
        self.mapView.mapType = MKMapTypeSatellite;
        [self.delegate setStateLabel:YES];
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:self.mapView.mapType forKey:@"MapType"];
}

- (IBAction)focusBtnAction:(id)sender {
    if (CLLocationCoordinate2DIsValid(self.droneLocation)) {
        MACoordinateRegion region = {0};
        region.center = [LocationConverter wgs84ToGcj02:self.droneLocation];
        region.span.latitudeDelta = 0.001;
        region.span.longitudeDelta = 0.001;
        [self.mapView setRegion:region animated:YES];
    }
}

- (void)updatePath{

}

- (float)addCurve:(BOOL)isCurve percent:(int)percent index:(int)index point1:(CLLocationCoordinate2D)p1 {
    return 0;
}

- (void)updateCurve:(int)index isCurve:(BOOL)isCurve coor1:(CLLocationCoordinate2D)coor1 coor2:(CLLocationCoordinate2D)coor2 coorC:(CLLocationCoordinate2D)coorC {
}


- (void)addWaypointAnnotation:(CLLocationCoordinate2D)coordinate waypointMission:(DJIWaypointMission *)waypointMission isCurve:(int)isCurve percent:(int)percent{
    self.waypointMission = waypointMission;
    percent /= 2;
    WaypointAnnotation* annotation = [[WaypointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    //annotation.title = [NSString  localizedStringWithFormat:@"%d", (int)self.waypointAnnotations.count];
    [self.waypointAnnotations addObject:annotation];
    [self.mapView addAnnotation:annotation];

    [self.mapView removeOverlay:self.path];
    [self updatePath];
    [self.mapView addOverlay:self.path];
}

- (void)addPoipointAnnotation:(CLLocationCoordinate2D)coordinate {
    PoiAnnotation *annotation = [[PoiAnnotation alloc] initWithCoordinate:coordinate];
    [self.poipointAnnotations addObject:annotation];
    [self.mapView addAnnotation:annotation];
}

- (void)replacePoipointAnnotation:(CLLocationCoordinate2D)coordinate {
    
}

- (void)removeWaypointAnnotation:(int)index {
}
- (void)removePoipointAnnotation:(int)index {
}
- (void)removeAllpointsAnnotations {
    [self.waypointAnnotations removeAllObjects];
    [self.poipointAnnotations removeAllObjects];
    NSArray *annos = [NSArray arrayWithArray:self.mapView.annotations];
    for (int i = 0; i < annos.count; i++) {
        id<MAAnnotation> ann = [annos objectAtIndex:i];
        if (![ann isEqual:self.aircraftAnnotation] && ![ann isEqual:self.aircraftCamera] && ![ann isEqual:self.homeAnnotation]) {
            [self.mapView removeAnnotation:ann];
        }
        
    }
    [self.curvePolylines removeAllObjects];
    [self.mapView removeOverlays:[self.mapView overlays]];
    self.circle = nil;
}



- (void)waypointConfig: (UITapGestureRecognizer *)tapGesture {
    
    MAAnnotationView *pinView = (MAAnnotationView *)tapGesture.view;
    MAPointAnnotation *annotation = pinView.annotation;
    int index = (int)[self.waypointAnnotations indexOfObject:annotation];
    [self.delegate waypointConfigMapViewController:index];
}

- (void)poiConfig: (UITapGestureRecognizer *)tapGesture {
    MAPinAnnotationView *pinView = (MAPinAnnotationView *)tapGesture.view;
    MAPointAnnotation *annotation = pinView.annotation;
    int index = (int)[self.poipointAnnotations indexOfObject:annotation];
    [self.delegate poiConfigMapViewController:index];
}
#pragma mark - CLLocationManagerDelegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[WaypointAnnotation class]]) {
        NSInteger height = [[NSUserDefaults standardUserDefaults] integerForKey:@"WaypointHeight"];
        if (height == 0)
            height = 50;
        WaypointAnnotationView *waypointView = [[WaypointAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Waypoint_Annotation" index:(int)[self.waypointAnnotations indexOfObject:annotation] + 1 height:(int)height];
        ((WaypointAnnotation*)annotation).annotationView = waypointView;
        waypointView.draggable = YES;
        //waypointView.pinColor = MAPinAnnotationColorPurple;
        //waypointView.animatesDrop = YES;
        //waypointView.canShowCallout = NO;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(waypointConfig:)];
        [waypointView addGestureRecognizer:tapGesture];
        return waypointView;
        
    }else if ([annotation isKindOfClass:[AircraftAnnotation class]])
    {
        AircraftAnnotationView* annoView = [[AircraftAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Aircraft_Annotation"];
        ((AircraftAnnotation*)annotation).annotationView = annoView;
        return annoView;
    }
    else if ([annotation isKindOfClass:[PoiAnnotation class]]) {
        NSInteger height = [[NSUserDefaults standardUserDefaults] integerForKey:@"PoiHeight"];
        PoiAnnotationView *poiView = [[PoiAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Poi_Annotation" index:(int)[self.poipointAnnotations indexOfObject:annotation] + 1 height:(int)height];
        ((PoiAnnotation*) annotation).annotationView = poiView;
        //poiView.pinColor = MAPinAnnotationColorRed;
        //poiView.animatesDrop = YES;
        //poiView.canShowCallout = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(poiConfig:)];
        [poiView addGestureRecognizer:tapGesture];
        return poiView;
    }
    else if ([annotation isKindOfClass:[AircraftCamera class]])
    {
        AircraftCameraView* annoView = [[AircraftCameraView alloc] initWithAnnotation:annotation reuseIdentifier:@"Aircraft_Camera"];
        ((AircraftCamera*)annotation).cameraView = annoView;
        return annoView;
    }
    else if ([annotation isKindOfClass:[HomeAnnotation class]]) {
        HomeAnnotationView *annoView = [[HomeAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Home_Annotation"];
        ((HomeAnnotation*)annotation).annotationView = annoView;
        return annoView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState {
    
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACurveline class]]) {
        MAPolylineRenderer *aRender = [[MAPolylineRenderer alloc] initWithOverlay:overlay];
        aRender.strokeColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        aRender.lineWidth = 4;
        //aRender.lineDashPhase = 10;
        return aRender;
    }
    else if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineRenderer *aRenderer = [[MAPolylineRenderer alloc] initWithOverlay:overlay];
        
        //aRenderer.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        aRenderer.strokeColor = [[UIColor yellowColor] colorWithAlphaComponent:1];
        aRenderer.lineWidth = 4;
        return aRenderer;
    }
    else if ([overlay isKindOfClass:[MACircle class]]) {
        MACircleRenderer *aRenderer = [[MACircleRenderer alloc] initWithOverlay:overlay];
        
        //aRenderer.fillColor = [UIColor colorWithRed:78/255.0 green:115/255.0 blue:230/255.0 alpha:0.3];
        //aRenderer.strokeColor = [UIColor colorWithRed:78/255.0 green:115/255.0 blue:230/255.0 alpha:1];
        aRenderer.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
        aRenderer.strokeColor = [[UIColor yellowColor] colorWithAlphaComponent:1];
        aRenderer.lineWidth = 4;
        return aRenderer;
    }
    return  nil;
}


- (void)updateAircraftLocation:(CLLocationCoordinate2D)location {
    CLLocationCoordinate2D gcj02coordinate = [LocationConverter wgs84ToGcj02:location];
    if (self.aircraftAnnotation == nil) {
        self.aircraftAnnotation = [[AircraftAnnotation alloc] initWithCoordiante:gcj02coordinate];
        [self.mapView addAnnotation:self.aircraftAnnotation];
        [self focusBtnAction:nil];
        self.mapView.showsUserLocation = NO;
    }
    if (self.aircraftCamera == nil) {
        self.aircraftCamera = [[AircraftCamera alloc] initWithCoordiante:gcj02coordinate];
        [self.mapView addAnnotation:self.aircraftCamera];
    }
    
    [self.aircraftAnnotation setCoordinate:gcj02coordinate];
    [self.aircraftCamera setCoordinate:gcj02coordinate];
}

- (void)updateHomeLocation:(CLLocationCoordinate2D)location {
    CLLocationCoordinate2D gcj02coordinate = [LocationConverter wgs84ToGcj02:location];
    if (self.homeAnnotation == nil) {
        self.homeAnnotation = [[HomeAnnotation alloc] initWithCoordiante:gcj02coordinate];
        [self.mapView addAnnotation:self.homeAnnotation];
    }
    
    [self.homeAnnotation setCoordinate:gcj02coordinate];
}

- (void)updateAircraftHeading:(float)heading
{
    if (self.aircraftAnnotation) {
        [self.aircraftAnnotation updateHeading:heading];
    }
}

- (void)updateCameraHeading: (float)heading {
    if (self.aircraftCamera) {
        [self.aircraftCamera updateHeading:heading];
    }
}
- (void)updateCircle:(float)radius {
    PoiAnnotation *centerPoi = self.poipointAnnotations[0];
    if (centerPoi == nil)
        self.circle = nil;
    else {
        self.circle = nil;
        self.circle = [MACircle circleWithCenterCoordinate:centerPoi.coordinate radius:radius];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
