
// Programador: Abdiel Soto, Pedro Contreras
// Origen: Edicomex
// Fecha inicio: Septiemnre 2014
// Fecha ultima modificación: 12/09/2014
// Descripción:
// Dependencias:

#import "AppDelegate.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "M13ProgressViewRing.h"

@interface AppDelegate ()

@end

@implementation AppDelegate{
    
    M13ProgressViewAction viewActionActivityIndicator;
    NSString *startMessage;
    NSString *endMessage;
    int secondsDelayHideActivity;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [self setupHUD];
    
    return YES;
}

-(void)setupHUD{
    
    //ProgressHUD
    [self.window makeKeyAndVisible];

    self.HUD = [[M13ProgressHUD alloc] initWithProgressView:[[M13ProgressViewRing alloc] init]];
    self.HUD.progressViewSize = CGSizeMake(60.0, 60.0);
    //UIWindow *window = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
    self.HUD.status = kHUDMsgLoading;

    self.HUD.shouldAutorotate = YES;
    [self.HUD setIndeterminate:YES];
    [self.window addSubview:self.HUD];
    
    NSArray *versionArray = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
    if ([[versionArray objectAtIndex:0] intValue] < 8.0) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    }
}

#pragma mark Handle Activity Indicator

//Mostrar indicador con mensaje

-(void)showActivityIndicator:(M13ProgressViewAction)action whithMessage:(NSString *)message delay:(BOOL)option{
    
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    [self.HUD setStatus:message];
    [self.HUD show:YES];
    /*
     // Create a Grand Central Dispatch (GCD) queue to process data in a background thread.
     dispatch_queue_t myprocess_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
     
     // Start the thread
     
     dispatch_async(myprocess_queue, ^{
     // place your calculation code here that you want run in the background thread.
     
     // all the UI work is done in the main thread, so if you need to update the UI, you will need to create another dispatch_async, this time on the main queue.
     dispatch_async(dispatch_get_main_queue(), ^{
     
     // Any UI update code goes here like progress bars
     
     });  // end of main queue code block
     }); // end of your big process.
     // finally close the dispatch queue
     */
}

-(void)notShowActivityIndicator:(M13ProgressViewAction)action whithMessage:(NSString *)message delay:(int)seconds{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    self.HUD.status = message;
    [self.HUD performAction:action animated:NO];
    viewActionActivityIndicator = action;
    
    if (seconds != 0)
        [self performSelector:@selector(resetAI) withObject:nil afterDelay:self.HUD.animationDuration + seconds];
    else
        [self performSelector:@selector(resetAI) withObject:nil afterDelay:0.25];
}

-(void)resetAI{
    
    [self.HUD hide:YES];
    [self.HUD performAction:M13ProgressViewActionNone animated:NO];
    self.HUD.status = kHUDMsgLoading;
}
#pragma mark Set Up Orientation to Activity Indicator

-(void)detectOrientation{
    
    if (kIs_iPad) {
        
        if ([[UIDevice currentDevice] orientation]==UIDeviceOrientationLandscapeLeft) {
            self.HUD.transform = CGAffineTransformMakeRotation(M_PI_2); // 90 degress
        }
        if ([[UIDevice currentDevice] orientation]==UIDeviceOrientationLandscapeRight) {
            self.HUD.transform = CGAffineTransformMakeRotation(0.0); // 270 degrees
            
        }
        if ([[UIDevice currentDevice] orientation]==UIDeviceOrientationPortraitUpsideDown) {
            self.HUD.transform = CGAffineTransformMakeRotation(M_PI); // 270 degrees
            
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.HUD setIndeterminate:YES];
    self.HUD.status = kHUDMsgLoading;
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self.HUD setIndeterminate:YES];
    self.HUD.status = kHUDMsgLoading;
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.HUD setIndeterminate:YES];
    self.HUD.status = kHUDMsgLoading;
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

@end
