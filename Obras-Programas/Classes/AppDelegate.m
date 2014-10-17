
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
    [self.HUD setMaskType:M13ProgressHUDMaskTypeNone];
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
    [self.HUD performAction:M13ProgressViewActionNone animated:YES];
    self.HUD.status = kHUDMsgLoading;
    [self.HUD setIndeterminate:YES];
}
#pragma mark Set Up Orientation to Activity Indicator

-(void)detectOrientation{
    
    if (kIs_iPad) {
        
        if ([[UIDevice currentDevice] orientation]==UIDeviceOrientationLandscapeLeft) {
            self.HUD.transform = CGAffineTransformMakeRotation(M_PI_2); // 90 degress
        }
        if ([[UIDevice currentDevice] orientation]==UIDeviceOrientationLandscapeRight) {
            self.HUD.transform = CGAffineTransformMakeRotation(M_PI + M_PI_2); // 270 degrees
            
        }
    }}

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

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.xsone.Obras-Programas" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Obras-Programas" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Obras-Programas.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
@end
