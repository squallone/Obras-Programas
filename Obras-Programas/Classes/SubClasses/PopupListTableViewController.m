
// Programador: Abdiel Soto
// Origen: EdicoMex
// Fecha inicio: Septiembre
// Fecha ultima modificación: 18/09/2014
// Descripción: Clase que muestra los elementos por de la lista en un TableView dentro de la clase UIPopover

#import "PopupListTableViewController.h"
#import "DetailTableViewController.h"
#import "Estado.h"
#import "Inaugurador.h"
#import "Impacto.h"
#import "Clasificacion.h"
#import "Dependencia.h"
#import "TipoObraPrograma.h"
#import "Inversion.h"
#import "Inaugurador.h"
#import "DBHelper.h"

typedef NS_OPTIONS(NSInteger, TypeSelection)
{
    t_DeleteAllNoTodo  = 0,
    t_Disable_Todo          = 1,
    t_Enable_Todo           = 2
};


const NSInteger rowHeight = 45;

@interface PopupListTableViewController ()

@property (nonatomic, strong) NSArray *dataToMark;
@property  CGSize size;
@property TypeSelection typeSelection;
@property TypeSelection cleanSelection;

@end

@implementation PopupListTableViewController

-(id)initWithData:(NSArray *)datasource isMenu:(BOOL)option markData:(NSArray *)loadData searchField:(MainSearchFields)field{
    
    if ([super initWithStyle:UITableViewStylePlain] !=nil) {
        
        /* Initialize instance variables */
        _typeSelection = t_Enable_Todo;
        self.dataSource     = datasource;
        self.dataToMark     = [loadData count] > 0 ? loadData : [NSArray new];
        
        self.dataSelected   = [NSMutableArray arrayWithArray:self.dataToMark];
        self.isMenu         = option;
        self.field          = field;
        
        self.clearsSelectionOnViewWillAppear = NO;
        self.tableView.allowsMultipleSelection = _isMenu ? NO : YES;
        
        NSInteger rowsCount = [self.dataSource count];
        NSInteger totalRowsHeight = (rowsCount * rowHeight);
        self.tableView.backgroundColor = [UIColor clearColor];
        //Calcula el ancho que debe tener la vista buscando que ancho de cada string se espera que sea
        
        CGFloat largestLabelWidth = 0;
        for (id objectModel in self.dataSource) {
            
            NSString *strValue = [self textToDisplay:objectModel];
            //Verifica el tamaño del texto usado la fuente del textLabel por defecto del UITableViewCell
            
            CGSize labelSize = [strValue sizeWithAttributes:
                           @{NSFontAttributeName:
                                 [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0]}];
            
            if (labelSize.width > largestLabelWidth) {
                largestLabelWidth = labelSize.width;
            }
        }
        
        //Agrega un pequeño padding al ancho
        CGFloat popoverWidth = largestLabelWidth + 50;
        popoverWidth = _isMenu || _field == e_Inaugurada || _field == e_Suscpetible ? popoverWidth + 50 : popoverWidth;
        _size = CGSizeMake(popoverWidth, totalRowsHeight);
        
        //Establece la propiedad para decirle al contenedor del popover que tan grande sera su vista
        self.preferredContentSize = _size;
        self.tableView.frame = CGRectMake(0, 0, _size.width, _size.height);

    }
    
    return self;
}

#pragma mark - View Lifecycle


- (void)viewDidLoad {
    
    [super viewDidLoad];
}

-(CGSize)preferredContentSize
{
    return _size;
}

-(void)viewWillAppear:(BOOL)animated{

    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];

}

-(void)viewDidDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    if ([_delegate respondsToSelector:@selector(popupListView:dataForMultipleSelectedRows:)]) {
        [_delegate popupListView:self dataForMultipleSelectedRows:_dataSelected];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _isMenu ? self.dataSource.count : self.dataSource.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id objecModel = nil;
    NSString *value = @"";

    if (_isMenu) {
       objecModel  = [self.dataSource objectAtIndex:indexPath.row];
    }else if (indexPath.row != 0) {
            objecModel  = [self.dataSource objectAtIndex:indexPath.row-1];
    }
    value = [self textToDisplay:objecModel];

    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld", (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    if (_isMenu) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"busquedas-icon"];
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"favorito-icon"];
        }else if (indexPath.row == 2){
            cell.imageView.image = [UIImage imageNamed:@"info"];
        }
        cell.textLabel.text = value;
        
    }else{
        if (indexPath.row != 0) {
            cell.textLabel.text = value;
            if (_typeSelection == t_DeleteAllNoTodo) {
                cell.accessoryType = UITableViewCellAccessoryNone;

            }
            for (id objectModel in _dataToMark) {
                NSString *valueToCheck = [self textToDisplay:objectModel];
                
                if ([valueToCheck isEqualToString:value]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                }
            }
        }else{
            cell.textLabel.text = @"TODO";
            if (_dataToMark.count==0) {
                if (_typeSelection == t_Enable_Todo) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }else if (_typeSelection == t_Disable_Todo) {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
        }
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Si la seleccion no es menu, agregamos nuevos elementos de busqueda para almacenarlos
    if (!_isMenu) {

        if (indexPath.row !=0) {
            _typeSelection = t_Disable_Todo;

            [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
            [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
            
            id dataForSelectedRow = [self.dataSource objectAtIndex:indexPath.row-1];
            
            if ([_delegate respondsToSelector:@selector(popupListView:dataForSingleSelectedRow:)]) {
                [_delegate popupListView:self dataForSingleSelectedRow:dataForSelectedRow];
            }
            [_dataSelected addObject:dataForSelectedRow];
        }else{
            //Cuando la selección es todo
            [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] setAccessoryType:UITableViewCellAccessoryCheckmark];

            for (int i= 0; i<self.dataSource.count; i++) {
                if (i!=0) {
                    [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
                }
            }
            _cleanSelection = t_DeleteAllNoTodo;
            _typeSelection = t_Enable_Todo;
            [self.dataSelected removeAllObjects];
        }
     
    }else{
        NSArray *dataSource = [NSArray array];
        MenuOptions option;
        if (indexPath.row == 0) {
            dataSource =  [DBHelper getAllQueriesSaved];
            option = o_Consultas;
            if (dataSource.count == 0) {
                [[[UIAlertView alloc]initWithTitle:@"No hay consultas"
                                           message:@"Aún no tienes consultas guardadas"
                                          delegate:nil
                                 cancelButtonTitle:@"Aceptar"
                                 otherButtonTitles:nil, nil]show];
                return;
            }        }else if (indexPath.row == 1){
            dataSource =  [DBHelper getAllObras];
            option = o_Favoritos;
            if (dataSource.count == 0) {
                [[[UIAlertView alloc]initWithTitle:@"No hay registros"
                                           message:@"Aún no tienes registros guardados"
                                          delegate:nil
                                 cancelButtonTitle:@"Aceptar"
                                 otherButtonTitles:nil, nil]show];
                return;
            }

        }else{
            return;
        }
        
        DetailTableViewController *detailViewController = [[DetailTableViewController alloc]initWithDataSource:dataSource menuOption:option];
        [self.navigationController pushViewController:detailViewController animated:YES];   
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_isMenu) {
        if (indexPath.row !=0) {
            id dataForSelectedRow = [self.dataSource objectAtIndex:indexPath.row-1];
            [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
            [_dataSelected removeObject:dataForSelectedRow];
        }
    }
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
    }else if (_field == e_Inaugurada || _field == e_Suscpetible){
        value = (NSString *)objectModel;
    }
    
    return value;
}

@end
