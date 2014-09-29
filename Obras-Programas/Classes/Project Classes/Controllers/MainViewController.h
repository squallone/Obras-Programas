
// Programador: Abdiel Soto, Pedro Contreras
// Origen: Edicomex
// Fecha inicio: Septiemnre 2014
// Fecha ultima modificación: 23/08/2014
// Descripción:
// Dependencias:

#import <UIKit/UIKit.h>
#import "PopupListTableViewController.h"
#import "JSONHTTPClient.h"

@interface MainViewController : UIViewController <UISearchBarDelegate, UITabBarControllerDelegate, UITableViewDelegate, PopupListTableViewControllerDelegate, JSONHTTPClientDelegate>

/* Ordena la busqueda */

- (IBAction)sortSearch:(id)sender;

/* Esconde la vista donde se muestra el TableView */

- (IBAction)hideSearchList:(id)sender;

/* Muestra las obras concluidas, proyectadas, en proceso, y los programas totales*/

- (IBAction)displayTypesOfProgramasWorks:(id)sender;

/* Muestra las dependencias */

- (IBAction)displayDependencies:(id)sender;

/* Muestra los esyados */

- (IBAction)displayStates:(id)sender;

/* Muestra los municipios */

- (IBAction)displayCities:(id)sender;

/* Muestra los tipos de impacto */

- (IBAction)displayTypeOfImpacts:(id)sender;

- (IBAction)displayClasifications:(id)sender;
@end
