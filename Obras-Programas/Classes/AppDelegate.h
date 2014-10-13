
// Programador: Abdiel Soto, Pedro Contreras
// Origen: Edicomex
// Fecha inicio: Septiemnre 2014
// Fecha ultima modificación: 23/08/2014
// Descripción:
// Dependencias:

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "M13ProgressHUD.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) M13ProgressHUD *HUD;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// CoreData
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
//
- (void)showActivityIndicator:(M13ProgressViewAction)action whithMessage:(NSString *)message delay:(BOOL)option;
- (void)notShowActivityIndicator:(M13ProgressViewAction)action whithMessage:(NSString *)message delay:(int)seconds;
@end

