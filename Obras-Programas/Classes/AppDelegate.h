
// Programador: Abdiel Soto, Pedro Contreras
// Origen: Edicomex
// Fecha inicio: Septiemnre 2014
// Fecha ultima modificación: 23/08/2014
// Descripción:
// Dependencias:

#import <UIKit/UIKit.h>
#import "M13ProgressHUD.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) M13ProgressHUD *HUD;


- (void)showActivityIndicator:(M13ProgressViewAction)action whithMessage:(NSString *)message delay:(BOOL)option;
- (void)notShowActivityIndicator:(M13ProgressViewAction)action whithMessage:(NSString *)message delay:(int)seconds;
@end

