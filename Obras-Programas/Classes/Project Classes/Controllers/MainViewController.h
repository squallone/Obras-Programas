
// Programador: Abdiel Soto, Pedro Contreras
// Origen: Edicomex
// Fecha inicio: Septiemnre 2014
// Fecha ultima modificación: 23/08/2014
// Descripción:
// Dependencias:

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PopupListTableViewController.h"
#import "JSONHTTPClient.h"
#import "PMCalendar.h"
#import "SWTableViewCell.h"
#import "MNMBottomPullToRefreshManager.h"

@interface MainViewController : UIViewController <UISearchBarDelegate, UITabBarControllerDelegate, UITableViewDelegate, PopupListTableViewControllerDelegate, JSONHTTPClientDelegate, PMCalendarControllerDelegate, MKMapViewDelegate, SWTableViewCellDelegate, UITextFieldDelegate, MNMBottomPullToRefreshManagerClient>

- (IBAction)performQuery:(id)sender;

- (IBAction)performSaveQuery:(id)sender;

- (IBAction)displayMoreOptions:(id)sender;

/* Ordena la busqueda */

- (IBAction)sortSearch:(id)sender;


/* Esconde la vista donde se muestra el TableView */

- (IBAction)hideSearchList:(id)sender;

- (IBAction)hideReporteView:(id)sender;

/* Muestra las dependencias */

- (IBAction)displayDependencies:(id)sender;

/* Muestra los esyados */

- (IBAction)displayStates:(id)sender;

/* Muestra los municipios */

- (IBAction)displayCities:(id)sender;

/* Muestra los tipos de impacto */

- (IBAction)displayTypeOfImpacts:(id)sender;

/* Muestra los tipos de clasificaciones */

- (IBAction)displayClasifications:(id)sender;

/* Muestra los tipos de inversiones */

- (IBAction)displayTypeOfInvesments:(id)sender;

/* Muestra calendario */

- (IBAction)displayCalendar:(id)sender;

- (IBAction)displayInaugurators:(id)sender;

- (IBAction)displayReportByDependency:(id)sender;

- (IBAction)displayReportByState:(id)sender;

- (IBAction)displayInauguradaOptions:(id)sender;

- (IBAction)displaySusceptibleOptions:(id)sender;

@end
