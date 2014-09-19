
// Programador: Abdiel Soto, Pedro Contreras
// Origen: Edicomex
// Fecha inicio: Septiemnre 2014
// Fecha ultima modificación: 23/08/2014
// Descripción:
// Dependencias:

#import <UIKit/UIKit.h>
#import "PopupListTableViewController.h"

@interface MainViewController : UIViewController <UISearchBarDelegate, UITabBarControllerDelegate, UITableViewDelegate, PopupListTableViewControllerDelegate>

- (IBAction)displayDependencies:(id)sender;
- (IBAction)sortSearch:(id)sender;
- (IBAction)hideSearchList:(id)sender;



@end
