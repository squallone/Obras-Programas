
// Programador: Abdiel Soto
// Origen: EdicoMex
// Fecha inicio: Septiembre
// Fecha ultima modificación: 18/09/2014
// Descripción: Clase que muestra los elementos por de la lista en un TableView dentro de la clase UIPopover

#import <UIKit/UIKit.h>

//Protocolo que nos permite identificar cuando un elemento de la lista se ha seleccionado
@protocol PopupListTableViewControllerDelegate;

@interface PopupListTableViewController : UITableViewController

//Se almancenas los datos de la lista
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSMutableArray *dataSelected;
@property (nonatomic, assign) MainSearchFields field;


@property BOOL isMenu;
//delegado
@property (nonatomic, weak)id<PopupListTableViewControllerDelegate> delegate;

-(id)initWithData:(NSArray *)datasource isMenu:(BOOL)option markData:(NSArray *)loadData searchField:(MainSearchFields)field;

@end

@protocol PopupListTableViewControllerDelegate <NSObject>

@optional

-(void)popupListView:(PopupListTableViewController *)popupListTableView dataForSingleSelectedRow:(NSString *)string;
-(void)popupListView:(PopupListTableViewController *)popupListTableView dataForMultipleSelectedRows:(NSArray *)data rowPressed:(BOOL)option;

@end