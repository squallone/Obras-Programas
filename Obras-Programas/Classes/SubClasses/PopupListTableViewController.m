
// Programador: Abdiel Soto
// Origen: EdicoMex
// Fecha inicio: Septiembre
// Fecha ultima modificación: 18/09/2014
// Descripción: Clase que muestra los elementos por de la lista en un TableView dentro de la clase UIPopover

#import "PopupListTableViewController.h"
#import "Estado.h"
#import "Inaugurador.h"
#import "Impacto.h"
#import "Clasificacion.h"
#import "Dependencia.h"
#import "TipoObraPrograma.h"
#import "Inversion.h"

const NSInteger rowHeight = 45;

@interface PopupListTableViewController ()

@property (nonatomic, strong) NSArray *dataToMark;

@end

@implementation PopupListTableViewController

-(id)initWithData:(NSArray *)datasource isMenu:(BOOL)option markData:(NSArray *)loadData searchField:(MainSearchFields)field{
    
    if ([super initWithStyle:UITableViewStylePlain] !=nil) {
        
        /* Initialize instance variables */
        
        self.dataSource     = datasource;        
        self.dataToMark     = [loadData count] > 0 ? loadData : [NSArray new];
        
        self.dataSelected   = [NSMutableArray arrayWithArray:self.dataToMark];
        self.isMenu         = option;
        self.field          = field;
        
        self.clearsSelectionOnViewWillAppear = NO;
        self.tableView.allowsMultipleSelection = _isMenu ? NO : YES;
        
        NSInteger rowsCount = [self.dataSource count];
        NSInteger totalRowsHeight = rowsCount * rowHeight + 5;
        
        //Calcula el ancho que debe tener la vista buscando que ancho de cada string se espera que sea
        
        CGFloat largestLabelWidth = 0;
        for (id objectModel in self.dataSource) {
            
            NSString *strValue = [self textToDisplay:objectModel];
            //Verifica el tamaño del texto usado la fuente del textLabel por defecto del UITableViewCell
            
            CGSize labelSize = [strValue sizeWithAttributes:
                           @{NSFontAttributeName:
                                 [UIFont systemFontOfSize:20.0f]}];
            
            if (labelSize.width > largestLabelWidth) {
                largestLabelWidth = labelSize.width;
            }
        }
        
        //Agrega un pequeño padding al ancho
        CGFloat popoverWidth = largestLabelWidth + 100;
        
        //Establece la propiedad para decirle al contenedor del popover que tan grande sera su vista
        self.preferredContentSize = CGSizeMake(popoverWidth, totalRowsHeight);
    }
    
    return self;
}

#pragma mark - View Lifecycle


- (void)viewDidLoad {
    
    [super viewDidLoad];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    if ([_delegate respondsToSelector:@selector(popupListView:dataForMultipleSelectedRows:)]) {
        [_delegate popupListView:self dataForMultipleSelectedRows:_dataSelected];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id objecModel = [self.dataSource objectAtIndex:indexPath.row];
    NSString *value = @"";
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        value = [self textToDisplay:objecModel];
        
        if (_isMenu) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"favoritos"];
        }else{
            for (id objectModel in _dataToMark) {
                    NSString *valueToCheck = [self textToDisplay:objectModel];
                
                if ([valueToCheck isEqualToString:value]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                }
            }
        }
        
        cell.textLabel.text = value;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Si la seleccion no es menu, agregamos nuevos elementos de busqueda para almacenarlos
    if (!_isMenu) {
        [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        
       id dataForSelectedRow = [self.dataSource objectAtIndex:indexPath.row];
        
        if ([_delegate respondsToSelector:@selector(popupListView:dataForSingleSelectedRow:)]) {
            [_delegate popupListView:self dataForSingleSelectedRow:dataForSelectedRow];
        }
        [_dataSelected addObject:dataForSelectedRow];
    }
    
    NSLog(@"Insert %@", _dataSelected);
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_isMenu) {
       id dataForSelectedRow = [self.dataSource objectAtIndex:indexPath.row];
        
        [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
        [_dataSelected removeObjectIdenticalTo:dataForSelectedRow];
    }
    NSLog(@"Insert %@", _dataSelected);
    
}

-(NSString *)textToDisplay:(id)objectModel{
    
    NSString *value = @"";

    if (_isMenu) {
        
        value = objectModel;
        
    }else if (_field == e_Estado) {
        
        Estado *state = (Estado *)objectModel;
        value = state.nombreEstado;
        
    }else if (_field == e_Nombre_Inaugura){
        
        Inaugurador *inaugurator = (Inaugurador *)objectModel;
        value = inaugurator.nombreCargoInaugura;
        
    }else if (_field == e_Impacto){
        
        Impacto *impact = (Impacto *)objectModel;
        value = impact.nombreImpacto;
    }else if (_field == e_Clasificacion){
        
        Clasificacion *clasification = (Clasificacion *)objectModel;
        value = clasification.nombreTipoClasificacion;
        
    }else if (_field == e_Dependencia){
        
        Dependencia *dependency = (Dependencia *)objectModel;
        value = dependency.nombreDependencia;
    }else if (_field == e_Tipo_Inversion){
        
        Inversion *invesment = (Inversion *)objectModel;
        value = invesment.nombre;
    }else if (_field == e_Tipo){
        
        TipoObraPrograma *tipo = (TipoObraPrograma *)objectModel;
        value = tipo.nombreTipoObra;
    }
    
    return value;
}

@end
