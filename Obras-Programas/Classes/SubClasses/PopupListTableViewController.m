
// Programador: Abdiel Soto
// Origen: EdicoMex
// Fecha inicio: Septiembre
// Fecha ultima modificación: 18/09/2014
// Descripción: Clase que muestra los elementos por de la lista en un TableView dentro de la clase UIPopover

#import "PopupListTableViewController.h"

@interface PopupListTableViewController ()

@end

@implementation PopupListTableViewController

-(id)initWithData:(NSArray *)array{
    
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        self.data = array;
        
        self.clearsSelectionOnViewWillAppear = NO;
        NSInteger rowsCount = [_data count];
        NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSInteger totalRowsHeight = rowsCount *singleRowHeight;
        
        //Calcula el ancho que debe tener la vista buscando que ancho de cada string se espera que sea
        CGFloat largestLabelWidth = 0;
        for (NSString *categoryName in _data) {
            //Verifica el tamaño del texto usado la fuente del textLabel por defecto del UITableViewCell
            CGSize labelSize = [categoryName sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
            if (labelSize.width > largestLabelWidth) {
                largestLabelWidth = labelSize.width;
            }
        }
        
        //Agrega un pequeño padding al ancho
        CGFloat popoverWidth = largestLabelWidth + 100;
        
        //Establece la propiedad para decirle al contenedor del popover que tan grande sera su vista
        self.contentSizeForViewInPopover = CGSizeMake(700, totalRowsHeight);
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *dataForSelectedRow = [self.data objectAtIndex:indexPath.row];
    
    if (_delegate !=nil) {
        //Se envia el elmento seleccionado
        [_delegate selectedRow:dataForSelectedRow];
    }
}


@end
