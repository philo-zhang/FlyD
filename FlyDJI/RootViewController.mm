//
//  RootViewController.m
//  FlyDJI
//
//  Created by zhangzhe on 15/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import "RootViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>





@interface RootViewController() <MapViewControllerDelegate, CameraViewControllerDelegate, DJIBaseProductDelegate, DJISDKManagerDelegate, DJIBatteryDelegate, DJICameraDelegate, DJIFlightControllerDelegate, DJILBAirLinkDelegate, DJIRemoteControllerDelegate, DJIMissionManagerDelegate, DJIGimbalDelegate,FunctionCollectionViewControllerDelegate, WaypointViewControllerDelegate, WaypointMissionConfigViewControllerDelegate, WaypointConfigViewControllerDelegate, WaypointPoiConfigViewControllerDelegate,  UIPopoverPresentationControllerDelegate, SettingsDelegate> {
    int functionIndex;
    //NSArray *isoArray;
    NSArray *fArray;
    NSArray *ssArray;
    NSArray *evArray;
    DJIGimbalWorkMode gimbalWorkMode;
}



@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerApp];
    [self initConfig];
    [self initCameraAndMap];
    [self initJoystick];
    [self initVisualTrackConfig];
    [self initStates];
    //[self initWaypointMission];
}

- (void) initConfig {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"hasBeenLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasBeenLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"WaypointGimbalPitch"];
        [[NSUserDefaults standardUserDefaults] setInteger:4 forKey:@"HotpointStartPoint"];
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"HotpointHeading"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HotpointGimbal"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"GpsFocusHeading"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"GpsFocusJoystick"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"JoystickCoor"];
        [[NSUserDefaults standardUserDefaults] setInteger:50 forKey:@"WaypointHeight"];
    }
}
/*--------------------------------------------------------------------------
 Camera view and Map view (init): Init camera and map views
 -------------------------------------------------------------------------*/
- (void)initCameraAndMap {
    /*
    self.stateView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.stateView.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    self.stateView.layer.shadowRadius = 8.0f;
    self.stateView.layer.shadowOpacity = 0.5;
     */
    self.cameraViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Camera"];
    [self.cameraViewController.view setFrame:CGRectMake(self.view.frame.size.width * 2/3, self.view.frame.size.height * 2/3, self.view.frame.size.width * 1/3, self.view.frame.size.height * 1/3)];
    self.tapGestureCamera = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewAction:)];
    [self.cameraViewController.view addGestureRecognizer:self.tapGestureCamera];
    self.cameraViewController.delegate = self;
    [self.view addSubview:self.cameraViewController.view];
    
    self.mapViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Map"];
    self.tapGestureMap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapViewAction:)];
    [self.mapViewController.view addGestureRecognizer:self.tapGestureMap];
    self.mapViewController.delegate = self;
    [self.view addSubview:self.mapViewController.view];
    [self.view sendSubviewToBack:self.mapViewController.view];
    
    self.startFlyBtn.alpha = 0;
    self.stopFlyBtn.alpha = 0;
    self.joystickBtn.alpha = 0;
    self.centerLabel.alpha = 0;
    [self imageViewAction:nil];
    self->functionIndex = -1;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopMission) name:@"Enter Background" object:nil];
    [self setStateLabel:YES];
}

- (void)stopMission {
    if (self->functionIndex >= 3) {
        [self.view bringSubviewToFront:self.startFlyBtn];
        [self.view sendSubviewToBack:self.stopFlyBtn];
        self.startFlyBtn.alpha = 1;
        self.stopFlyBtn.alpha = 0;
    }
}

- (void)startMission {
    [self.view bringSubviewToFront:self.stopFlyBtn];
    [self.view sendSubviewToBack:self.startFlyBtn];
    self.stopFlyBtn.alpha = 1;
    self.startFlyBtn.alpha = 0;
}
- (void)initJoystick {

}

- (void)initVisualTrackConfig {

}

- (void)enableVirtualStick {
}

- (IBAction)startBtnAction:(id)sender {
}

- (IBAction)stopBtnAction:(id)sender {

}

- (IBAction)joystickBtnAction:(id)sender {
   
}

/*--------------------------------------------------------------------------
 Waypoint Mission (init): Init waypoint view
 -------------------------------------------------------------------------*/
- (void)initWaypointMission {
    
    self.waypointViewController = [[WaypointViewController alloc] initWithNibName:@"Waypoint" bundle:[NSBundle mainBundle]];
    [self.waypointViewController.view setFrame:CGRectMake(20, (self.view.frame.size.height - self.waypointViewController.view.frame.size.height) / 2, self.waypointViewController.view.frame.size.width, self.waypointViewController.view.frame.size.height)];
    self.waypointViewController.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    self.waypointViewController.view.opaque = NO;
    self.waypointViewController.delegate = self;
    [self.view addSubview:self.waypointViewController.view];
    
    self.waypointMissionConfigViewController = [[WaypointMissionConfigViewController alloc] initWithNibName:@"WaypointMissionConfig" bundle:[NSBundle mainBundle]];
    [self.waypointMissionConfigViewController.view setFrame:CGRectMake((self.view.frame.size.width - self.waypointMissionConfigViewController.view.frame.size.width) / 2, MAX((self.view.frame.size.height - self.waypointMissionConfigViewController.view.frame.size.height)/2, 50), self.waypointMissionConfigViewController.view.frame.size.width, MIN(self.view.frame.size.height - 100, self.waypointMissionConfigViewController.view.frame.size.height))];
    self.waypointMissionConfigViewController.view.alpha = 0;
    self.waypointMissionConfigViewController.delegate = self;
    self.waypointMissionConfigViewController.view.layer.cornerRadius = 10;
    self.waypointMissionConfigViewController.view.layer.masksToBounds = YES;
    [self.view addSubview:self.waypointMissionConfigViewController.view];
    
    self.waypointConfigViewController = [[WaypointConfigViewController alloc] initWithNibName:@"WaypointConfig" bundle:[NSBundle mainBundle]];
    [self.waypointConfigViewController.view setFrame:CGRectMake((self.view.frame.size.width - self.waypointConfigViewController.view.frame.size.width) / 2, MAX((self.view.frame.size.height - self.waypointConfigViewController.view.frame.size.height)/2, 50), self.waypointConfigViewController.view.frame.size.width, MIN(self.view.frame.size.height - 100, self.waypointConfigViewController.view.frame.size.height))];
    self.waypointConfigViewController.view.alpha = 0;
    self.waypointConfigViewController.delegate = self;
    self.waypointConfigViewController.view.layer.cornerRadius = 10;
    self.waypointConfigViewController.view.layer.masksToBounds = YES;
    [self.view addSubview:self.waypointConfigViewController.view];
    
    self.waypointPoiConfigViewController = [[WaypointPoiConfigViewController alloc] initWithNibName:@"WaypointPoiConfig" bundle:[NSBundle mainBundle]];
    [self.waypointPoiConfigViewController.view setFrame:CGRectMake((self.view.frame.size.width - self.waypointPoiConfigViewController.view.frame.size.width) / 2, (self.view.frame.size.height - self.waypointPoiConfigViewController.view.frame.size.height) / 2, self.waypointPoiConfigViewController.view.frame.size.width, self.waypointPoiConfigViewController.view.frame.size.height)];
    self.waypointPoiConfigViewController.view.alpha = 0;
    self.waypointPoiConfigViewController.delegate = self;
    self.waypointPoiConfigViewController.view.layer.cornerRadius = 10;
    self.waypointPoiConfigViewController.view.layer.masksToBounds = YES;
    [self.view addSubview:self.waypointPoiConfigViewController.view];
    [self mapViewAction:nil];
    [self.missionBtn setTitle:NSLocalizedString(@"WAYPOINT", @"") forState:UIControlStateNormal];
    [self.missionBtn setImage:nil forState:UIControlStateNormal];
    self.startFlyBtn.alpha = 0;
    self.stopFlyBtn.alpha = 0;
    self.joystickBtn.alpha = 0;
    self.centerLabel.alpha = 0.5;
}

- (void)removeWaypointMission {
    [self clearAllPointsWaypointDelegate];
    [self.waypointViewController.view removeFromSuperview];
    self.waypointViewController = nil;
    [self.waypointMissionConfigViewController.view removeFromSuperview];
    self.waypointMissionConfigViewController = nil;
    [self.waypointConfigViewController.view removeFromSuperview];
    self.waypointConfigViewController = nil;
    [self.waypointPoiConfigViewController.view removeFromSuperview];
    self.waypointPoiConfigViewController.view = nil;
    self.centerLabel.alpha = 0;
}

- (void)initGpsOribtMission {
    
}

- (void)removeGpsOrbitMission {
    
}

- (void)initGpsFocusMission {
    }

- (void)removeGpsFocusMission {
    }

- (void)initVisualTrackMission {
    
}

- (void)removeVisualTrackMission {
    
}

- (void)initVisualFocusMission {
    }

- (void)removeVisualFocusMission {
    
}

- (void)initMotionFocusMission {
    }

- (void)removeMotionFocusMission {
    

}
/*--------------------------------------------------------------------------
 System states (init): Init system states
 -------------------------------------------------------------------------*/
- (void)initStates {
    /*
    NSUInteger size = 16;
    UIFont * font = [UIFont boldSystemFontOfSize:size];
    NSDictionary * attributes = @{NSFontAttributeName: font};
    [self.missionBtn setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.settingsBtn setTitleTextAttributes:attributes forState:UIControlStateNormal];
     */
    self.satelliteLabel.text = @"N/A";
    self.batteryLabel.text = @"N/A";
    self.remoteControllerLabel.text = @"N/A";
    self.sdCardLabel.text = @"N/A";
    self.remoteBatteryLabel.text = @"N/A";
    self.heightLabel.text = @"H:N/A";
    self.distanceLabel.text = @"D:N/A";
    self.hSpeedLabel.text = @"H.S.:N/A";
    self.vSpeedLabel.text = @"V.S.:N/A";
    self.systemState.text = NSLocalizedString(@"DISCONNECTED", @"");
    self.systemState.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    //self.systemState.title = NSLocalizedString(@"DISCONNECTED", @"");
    //[self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]}];
    
    //isoArray = [[NSArray alloc] initWithObjects:@"Auto", @"100", @"200", @"400", @"800", @"1600", @"3200", @"6400", @"12800", @"25600", nil];
    
    fArray = [[NSArray alloc] initWithObjects:@"1.7", @"1.8", @"2", @"2.2", @"2.5", @"2.8", @"3.2", @"3.5", @"4", @"4.5", @"5", @"5.6", @"6.3", @"7.1", @"8", @"9", @"10", @"11", @"13", @"14", @"16", @"18", @"20", @"22", nil];
    
    ssArray = [[NSArray alloc] initWithObjects:@"1/8000", @"1/6400", @"1/5000", @"1/4000", @"1/3200", @"1/2500", @"1/2000", @"1/1600", @"1/1250", @"1/1000", @"1/800", @"1/640", @"1/500", @"1/400", @"1/320", @"1/240", @"1/200", @"1/160", @"1/120", @"1/100", @"1/80", @"1/60", @"1/50", @"1/40", @"1/30", @"1/25", @"1/20", @"1/15", @"1/12.5", @"1/10", @"1/8", @"1/6.25", @"1/5", @"1/4", @"1/3", @"1/2.5", @"1/2", @"1/1.67", @"1.25", @"1.0", @"1.3", @"1.6", @"2.0", @"2.5", @"3.0", @"3.2", @"4.0", @"5.0", @"6.0", @"7.0", @"8.0", @"9.0", @"10.0", @"13.0", @"15.0", @"20.0", @"25.0", @"30.0", nil];
    
    evArray = [[NSArray alloc] initWithObjects:@"N/A", @"-5.0", @"-4.7", @"-4.3", @"-4.0", @"-3.7", @"-3.3", @"-3.0", @"-2.7", @"-2.3", @"-2.0", @"-1.7", @"-1.3", @"-1.0", @"-0.7", @"-0.3", @"0.0", @"+0.3", @"+0.7", @"+1.0", @"+1.3", @"+1.7", @"+2.0", @"+2.3", @"+2.7", @"+3.0", @"+3.3", @"+3.7", @"+4.0", @"+4.3", @"+4.7", @"+5.0", nil];
}

/*--------------------------------------------------------------------------
 DJI (Register): Register DJI SDK
 -------------------------------------------------------------------------*/
- (void)registerApp
{
    NSString* appKey = @"71ed31a8248551821c5c1a5a";
    [DJISDKManager registerApp:appKey withDelegate:self];
    
    NSString *mapKey = @"9b81df0465865df0dbb9be21ea01d997";
    [AMapServices sharedServices].apiKey = mapKey;
}


/*--------------------------------------------------------------------------
 DJI SDK (connect): connect to DJI SDK
 -------------------------------------------------------------------------*/
- (void)sdkManagerDidRegisterAppWithError:(NSError *_Nullable)error
{
    if (error){
        [Utility showAlert:self title:@"Register APP" message:[error localizedDescription]];
    }
    else{
        [DJISDKManager startConnectionToProduct];
        //[DJISDKManager enterDebugModeWithDebugId:@"192.168.1.101"];
        //[DJISDKManager enterDebugModeWithDebugId:@"169.254.152.169"];
        //[DJISDKManager enterDebugModeWithDebugId:@"192.168.1.12"];
    }
}

/*--------------------------------------------------------------------------
 DJI SDK Delegate (new product): Config new product
 -------------------------------------------------------------------------*/
- (void)sdkManagerProductDidChangeFrom:(DJIBaseProduct* _Nullable) oldProduct to:(DJIBaseProduct* _Nullable) newProduct
{
    if ([DJISDKManager product]) {
        //self.systemState.title = NSLocalizedString(@"CONNECTED", @"");
        self.systemState.text = NSLocalizedString(@"CONNECTED", @"");
        self.systemState.textColor = [UIColor colorWithRed:28/255.0 green:65/255.0 blue:219/255.0 alpha:1];
        //[self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:0.5 blue:0 alpha:1]}];
        DJIBaseProduct *product = [DJISDKManager product];
        product.delegate = self;
        DJIFlightController* flightController = [Utility fetchFlightController];
        if (flightController) {
            flightController.delegate = self;
        }
        DJIBattery *batteryController = [Utility fetchBattery];
        if (batteryController) {
            batteryController.delegate = self;
        }
        DJICamera *cameraController = [Utility fetchCamera];
        if (cameraController) {
            cameraController.delegate = self;
        }
        DJILBAirLink *lbAirlick = [Utility fetchLBAirLink];
        if (lbAirlick) {
            lbAirlick.delegate = self;
        }
        DJIRemoteController *remoteController = [Utility fetchRemoteController];
        if (remoteController) {
            remoteController.delegate = self;
        }
        DJIGimbal *gimbal = [Utility fetchGimbal];
        if (gimbal) {
            gimbal.delegate = self;
        }
    }
}
- (void)componentWithKey:(NSString *)key changedFrom:(DJIBaseComponent *)oldComponent to:(DJIBaseComponent *)newComponent {
    }

- (void)product:(DJIBaseProduct *)product connectivityChanged:(BOOL)isConnected {
    if (isConnected && product) {
        //self.systemState.title = NSLocalizedString(@"CONNECTED", @"");
        self.systemState.text = NSLocalizedString(@"CONNECTED", @"");
        self.systemState.textColor = [UIColor colorWithRed:28/255.0 green:65/255.0 blue:219/255.0 alpha:1];
        //[self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:0.5 blue:1 alpha:1]}];
    }
    else {
        //self.systemState.title = NSLocalizedString(@"DISCONNECTED", @"");
        self.systemState.text = NSLocalizedString(@"DISCONNECTED", @"");
        self.systemState.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        //[self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]}];
    }
}

/*--------------------------------------------------------------------------
 DJI Battery Delegate (state): Update battery states
 -------------------------------------------------------------------------*/
- (void)battery:(DJIBattery *_Nonnull)battery didUpdateState:(DJIBatteryState *_Nonnull)batteryState{
    self.batteryLabel.text = [NSString  localizedStringWithFormat:@"%d%%",(int)batteryState.batteryEnergyRemainingPercent];
}

/*--------------------------------------------------------------------------
 DJI Camera SD Card (state): update camera SD card states
 -------------------------------------------------------------------------*/
- (void)camera:(DJICamera *_Nonnull)camera didUpdateSDCardState:(DJICameraSDCardState * _Nonnull)sdCardState {
    self.sdCardLabel.text = [NSString  localizedStringWithFormat:@"%dG",(int)sdCardState.remainingSpaceInMegaBytes/1000];
}

- (void)camera:(DJICamera *_Nonnull)camera didUpdateCurrentExposureParameters:(DJICameraExposureParameters)params {
    self.cameraViewController.isoLabel.text = [NSString  localizedStringWithFormat:@"ISO %d", (int)params.iso];
    if (params.aperture < self->fArray.count)
        self.cameraViewController.fLabel.text = [NSString  localizedStringWithFormat:@"F %@", fArray[params.aperture]];
    else
        self.cameraViewController.fLabel.text = @"F N/A";
    self.cameraViewController.ssLabel.text = [NSString  localizedStringWithFormat:@"SS %@", ssArray[params.shutterSpeed]];
    self.cameraViewController.evLabel.text = [NSString  localizedStringWithFormat:@"EV %@", evArray[params.exposureCompensation]];
}

- (void)camera:(DJICamera *)camera didUpdateSystemState:(DJICameraSystemState *)systemState {
    if (self.cameraViewController.isRecording != systemState.isRecording)
        [self.cameraViewController modifyRecordBtn:systemState.isRecording];
    self.cameraViewController.isRecording = systemState.isRecording;
}



/*--------------------------------------------------------------------------
 DJI Camera (data): set data to videopreviewer
 -------------------------------------------------------------------------*/
-(void)camera:(DJICamera *)camera didReceiveVideoData:(uint8_t *)videoBuffer length:(size_t)size
{
    [[VideoPreviewer instance] push:videoBuffer length:(int)size];
}

- (void)gimbal:(DJIGimbal *)gimbal didUpdateGimbalState:(DJIGimbalState *)gimbalState {
    }
- (void)remoteController:(DJIRemoteController *_Nonnull)rc didUpdateBatteryState:(DJIRCBatteryInfo)batteryInfo {
    self.remoteBatteryLabel.text = [NSString stringWithFormat:@"%d%%", batteryInfo.remainingEnergyInPercent];
}
- (void)remoteController:(DJIRemoteController *_Nonnull)rc didUpdateHardwareState:(DJIRCHardwareState)state {
    }

/*--------------------------------------------------------------------------
 DJI flight controller (state): update flight controller states
 -------------------------------------------------------------------------*/
- (void)flightController:(DJIFlightController *)fc didUpdateSystemState:(DJIFlightControllerCurrentState *)state
{
    }


- (void)lbAirLink:(DJILBAirLink *_Nonnull)lbAirLink didUpdateRemoteControllerSignalInformation:(NSArray *_Nonnull)antennas {
    DJISignalInformation *signalInfo = [antennas objectAtIndex:0];
    self.remoteControllerLabel.text = [NSString  localizedStringWithFormat:@"%d%%", signalInfo.percent];
}
- (void)startTrack:(CGRect)rect {
    }

- (void)stopTrack {
   }
/*----------------------------------------------------------------------------
 Click on CameraView: Exchange the position of camera view and map view
------------------------------------------------------------------------------*/
- (void)imageViewAction: (UITapGestureRecognizer *)gestureRecognizer {
    [UIView animateWithDuration:1 animations:^{
        self.mapViewController.view.frame = CGRectMake(self.view.frame.size.width * 2/3, self.view.frame.size.height * 2/3, self.view.frame.size.width * 1/3, self.view.frame.size.height * 1/3);
        self.cameraViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    self.mapViewController.mapParamView.alpha = 0;
    self.mapViewController.focusBtn.alpha = 0;
    self.mapViewController.switchBtn.alpha = 0;
    self.mapViewController.mapView.showsCompass = NO;
    self.mapViewController.mapView.zoomEnabled = false;
    self.mapViewController.mapView.scrollEnabled = false;
    self.mapViewController.mapView.userInteractionEnabled = false;
    self.cameraViewController.cameraParamView.alpha = 1;
    self.cameraViewController.settingsBtn.alpha = 1;
    self.cameraViewController.recordBtn.alpha = 1;
    self.cameraViewController.stopRecordBtn.alpha = 1;
    [self.cameraViewController addDiagonalPath];
    [self.cameraViewController addGridlinePath];
    [self.cameraViewController.view removeGestureRecognizer:self.tapGestureCamera];
    [self.cameraViewController addTapGesture];
    self.waypointViewController.view.alpha = 0;
    [self.view sendSubviewToBack:self.cameraViewController.view];
    self.centerLabel.alpha = 0;
    [self setStateLabel:YES];
}

/*----------------------------------------------------------------------------
 Click on MapView: Exchange the position of camera view and map view
 ------------------------------------------------------------------------------*/
- (void)mapViewAction: (UITapGestureRecognizer *)gestureRecognizer {
    [UIView animateWithDuration:1 animations:^{
        self.cameraViewController.view.frame = CGRectMake(self.view.frame.size.width * 2/3, self.view.frame.size.height * 2/3, self.view.frame.size.width * 1/3, self.view.frame.size.height * 1/3);
        self.mapViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    self.cameraViewController.cameraParamView.alpha = 0;
    self.cameraViewController.settingsBtn.alpha = 0;
    self.cameraViewController.recordBtn.alpha = 0;
    self.cameraViewController.stopRecordBtn.alpha = 0;
    [self.cameraViewController addDiagonalPath];
    [self.cameraViewController addGridlinePath];
    [self.cameraViewController.view addGestureRecognizer:self.tapGestureCamera];
    [self.cameraViewController removeTapGesture];
    self.mapViewController.mapParamView.alpha = 1;
    self.mapViewController.focusBtn.alpha = 1;
    self.mapViewController.switchBtn.alpha = 1;
    self.mapViewController.mapView.showsCompass = YES;
    self.mapViewController.mapView.zoomEnabled = true;
    self.mapViewController.mapView.scrollEnabled = true;
    self.mapViewController.mapView.userInteractionEnabled = true;
    self.waypointViewController.view.alpha = 1;
    [self.view sendSubviewToBack:self.mapViewController.view];
    if (self->functionIndex < 3 && self->functionIndex > -1)
        self.centerLabel.alpha = 0.5;
    if (self.mapViewController.mapView.mapType == MAMapTypeStandard)
        [self setStateLabel:NO];
    else
        [self setStateLabel:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"Functions"]) {
        segue.destinationViewController.popoverPresentationController.delegate = self;
        segue.destinationViewController.preferredContentSize = CGSizeMake(320, 270);
        self.functionViewController = (FunctionCollectionViewController *)segue.destinationViewController;
        self.functionViewController.delegate = self;
    }
    if ([segue.identifier isEqual: @"Settings"]) {
        segue.destinationViewController.popoverPresentationController.delegate = self;
        segue.destinationViewController.preferredContentSize = CGSizeMake(350, 400);
        UINavigationController *navigationVC = (UINavigationController *)segue.destinationViewController;
        self.settingVC = (Settings *)navigationVC.viewControllers[0];
        self.settingVC.delegate = self;
    }
    segue.destinationViewController.popoverPresentationController.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [self hideConfigViews];
}
- (void)hideConfigViews {
    switch (self->functionIndex) {
        case 0:
            self.waypointConfigViewController.view.alpha = 0;
            self.waypointPoiConfigViewController.view.alpha = 0;
            self.waypointMissionConfigViewController.view.alpha = 0;
            break;
        default:
            break;
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
    // This method is called in iOS 8.3 or later regardless of trait collection, in which case use the original presentation style (UIModalPresentationNone signals no adaptation)
    return UIModalPresentationNone;
}

/*
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}
*/
/*----------------------------------------------------------------------------
 Click on function view controller cell <delegate>: Configure the selected misssion
 ------------------------------------------------------------------------------*/
- (void)cellViewSelected:(int)index {
    if (self->functionIndex == index)
        return;
    switch (self->functionIndex) {
        case 0:
            [self removeWaypointMission];
            break;
        default:
            break;
    }
    switch (index) {
        case 0:
            [self initWaypointMission];
            break;
        default:
            break;
    }
    self->functionIndex = index;

}
- (void)flightPathModeWaypointMissionConfigVCDelegate:(BOOL)isCurve {
}

- (void)headingWaypointMissionConfigVCDelegate:(int)poiIndex {
    }
/*--------------------------------------------------------------------------
 Waypoint Delegate(add newpoint): Add newpoint (waypoint or poi)
 -------------------------------------------------------------------------*/
- (CLLocationCoordinate2D)newpointWaypointDelegate:(BOOL)isWaypoint {
    CGPoint point = self.mapViewController.mapView.center;
    CLLocationCoordinate2D coordinate = [self.mapViewController.mapView convertPoint:point toCoordinateFromView:self.mapViewController.mapView];
    if (isWaypoint) {
        BOOL isCurve = [[NSUserDefaults standardUserDefaults] boolForKey:@"WaypointCurve"];
        NSInteger curvePercent = [[NSUserDefaults standardUserDefaults] integerForKey:@"WaypointDefaultCurvePercent"];
        [self.mapViewController addWaypointAnnotation:coordinate waypointMission:self.waypointViewController.waypointMission isCurve:isCurve percent:(int)curvePercent];
    }
    else {
        [self.mapViewController addPoipointAnnotation:coordinate];
    }
    coordinate = [LocationConverter gcj02ToWgs84:coordinate];
    return coordinate;
}

- (void)updateWaypointHeadingAndGimbal:(DJIWaypoint *)waypoint poilocation:(CLLocation *)poi {
    
}
/*--------------------------------------------------------------------------
 Waypoint Delegate(clear all points): Clear all points including waypoints and pois.
 -------------------------------------------------------------------------*/
- (void)clearAllPointsWaypointDelegate {
    [self.mapViewController removeAllpointsAnnotations];
}


/*--------------------------------------------------------------------------
 Waypoint Delegate(config): Configure waypoint mission
 -------------------------------------------------------------------------*/
- (void)configWaypointMissionDelegate {
    [self.waypointMissionConfigViewController waypointMissionConfigInit:self.waypointViewController];
    self.waypointConfigViewController.view.alpha = 0;
    self.waypointPoiConfigViewController.view.alpha = 0;
}

/*--------------------------------------------------------------------------
 MapView Delegate(config): Configure waypoint
 -------------------------------------------------------------------------*/
- (void)waypointConfigMapViewController:(int)index {
    [self.waypointConfigViewController waypointConfigInit:self.waypointViewController.waypointMission poiArray:self.waypointViewController.poiArray waypointIndex:index poiIndex:self.waypointViewController.poiIndexArray isGimbalPoi:self.waypointViewController.isGimbalPoiArray];
    self.waypointMissionConfigViewController.view.alpha = 0;
    self.waypointPoiConfigViewController.view.alpha = 0;
}

- (void)updateWaypointMapVC:(int)index {
}
/*--------------------------------------------------------------------------
 Poi Config Delegate(init): init poi config
 -------------------------------------------------------------------------*/
- (void)poiConfigMapViewController:(int)index {
    switch (self->functionIndex) {
        case 0:
            [self.waypointPoiConfigViewController poiConfigInit:self.waypointViewController.poiArray index:index];
            self.waypointMissionConfigViewController.view.alpha = 0;
            self.waypointConfigViewController.view.alpha = 0;
            break;
        default:
            break;
    }
}
/*--------------------------------------------------------------------------
 WaypointConfig Delegate(remove): remove waypoint
 -------------------------------------------------------------------------*/
- (void)removeWaypoint:(WaypointConfigViewController *)waypointConfigViewController {
    
}

-(void)cornerRadiusChanged:(int)index coor1:(CLLocationCoordinate2D)coor1 coor2:(CLLocationCoordinate2D)coor2 coorC:(CLLocationCoordinate2D)coorC {
}

- (void)modifyHeight:(int)index height:(int)height {
}
/*--------------------------------------------------------------------------
 WaypointPoiConfig Delegate(remove): remove poipoint
 -------------------------------------------------------------------------*/
- (void)removePoipoint:(WaypointPoiConfigViewController *)waypointPoiConfigViewController {

}

- (void)modifyPoiHeight:(int)index height:(int)height {

}

/*--------------------------------------------------------------------------
 WaypointPoiConfig Delegate(done): remove poipoint
 -------------------------------------------------------------------------*/
- (void)donePoipoint:(WaypointPoiConfigViewController *)waypointPoiConfigViewController {
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setGridlineSettingDelegate:(BOOL)isOn {
    if (isOn)
        [self.cameraViewController addGridlineOverlay];
    else
        [self.cameraViewController removeGridlineOverlay];
}
- (void)setDiagonalSettingDelegate:(BOOL)isOn {
    if (isOn)
        [self.cameraViewController addDiagonalOverlay];
    else
        [self.cameraViewController removeDiagonalOverlay];
}

- (void)printYawAngle:(float)yawAngle {
    self.testLabel.text = [NSString stringWithFormat:@"%f", yawAngle];
}

- (void)setStateLabel:(bool)isWhite {
    if (isWhite) {
        self.heightLabel.textColor = [UIColor whiteColor];
        self.distanceLabel.textColor = [UIColor whiteColor];
        self.hSpeedLabel.textColor = [UIColor whiteColor];
        self.vSpeedLabel.textColor = [UIColor whiteColor];
        self.heightLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.distanceLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.hSpeedLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.vSpeedLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        //self.heightLabel.shadowColor = [UIColor blueColor];
        //self.distanceLabel.shadowColor = [UIColor blueColor];
        //self.hSpeedLabel.shadowColor = [UIColor blueColor];
        //self.vSpeedLabel.shadowColor = [UIColor blueColor];
    }
    else {
        self.heightLabel.textColor = [UIColor blackColor];
        self.distanceLabel.textColor = [UIColor blackColor];
        self.hSpeedLabel.textColor = [UIColor blackColor];
        self.vSpeedLabel.textColor = [UIColor blackColor];
        self.heightLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        self.distanceLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        self.hSpeedLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        self.vSpeedLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        //self.heightLabel.shadowColor = [UIColor whiteColor];
        //self.distanceLabel.shadowColor = [UIColor whiteColor];
        //self.hSpeedLabel.shadowColor = [UIColor whiteColor];
        //self.vSpeedLabel.shadowColor = [UIColor whiteColor];
    }
}
@end
