
// Programador: Abdiel Soto
// Origen: EdicoMex
// Fecha inicio: Septiembre
// Fecha ultima modificación: 18/09/2014
// Descripción: Clase que muestra los elementos por de la lista en un TableView dentro de la clase UIPopover

#import <UIKit/UIKit.h>

//Protocolo que nos permite identificar cuando un elemento de la lista se ha seleccionado
@protocol PopupListTableViewControllerDelegate <NSObject>

-(void)selectedRow:(NSString *)string;

@end

@interface PopupListTableViewController : UITableViewController

//Se almancenas los datos de la lista
@property (nonatomic, strong) NSArray *data;
//delegado
@property (nonatomic, weak)id<PopupListTableViewControllerDelegate> delegate;

-(id)initWithData:(NSArray *)array;


@end
