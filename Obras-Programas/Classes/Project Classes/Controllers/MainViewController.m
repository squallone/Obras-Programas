
// Programador: Abdiel Soto, Pedro Contreras
// Origen: Edicomex
// Fecha inicio: Septiemnre 2014
// Fecha ultima modificación: 23/08/2014
// Descripción:
// Dependencias:

#import "MainViewController.h"
#import "NSUserDefaults+RMSaveCustomObject.h"
#import "UIColor+Colores.h"
#import "ObraProgramaCell.h"
#import "Estado.h"
#import "Impacto.h"
#import "Inaugurador.h"
#import "Clasificacion.h"
#import "Dependencia.h"
#import "Inversion.h"
#import "TipoObraPrograma.h"
#import "Obra.h"
#import "MDSpreadView.h"

#define METERS_PER_MILE 1609.344

@interface MainViewController () <MDSpreadViewDataSource, MDSpreadViewDelegate>

#pragma mark - IBOutLets

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (weak, nonatomic) IBOutlet MDSpreadView *spreadView;
@property (weak, nonatomic) IBOutlet UIView *reportView;


@property (weak, nonatomic) IBOutlet UIButton *btnQuery;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveQuery;
@property (weak, nonatomic) IBOutlet UIButton *btndependency;
@property (weak, nonatomic) IBOutlet UIButton *btnStates;
@property (weak, nonatomic) IBOutlet UIButton *btnImpact;
@property (weak, nonatomic) IBOutlet UIButton *btnClasification;
@property (weak, nonatomic) IBOutlet UIButton *btnInaugurated;
@property (weak, nonatomic) IBOutlet UIButton *btnTypeInvestment;
@property (weak, nonatomic) IBOutlet UIButton *btnStartDate;
@property (weak, nonatomic) IBOutlet UIButton *btnEndDate;

@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;


@property (strong, nonatomic) UIBarButtonItem *menuBarBtn;
@property (strong, nonatomic) UIButton *btnWorksPrograms;

#pragma mark - Reporte 

@property (nonatomic, strong) NSArray *titleFields;

#pragma mark - Calendar

@property (nonatomic, strong) PMCalendarController *pmCC;
@property (nonatomic, strong) NSDateFormatter *dateFormatterGeneral;
@property (nonatomic, strong) NSDateFormatter *dateFormatterShort;
@property BOOL isStartDate;

#pragma mark - PopUp Lis

@property (nonatomic, strong) PopupListTableViewController *popUpTableView;
@property (nonatomic, strong) UIPopoverController *popOverView;

#pragma mark - SearchBar

@property (nonatomic, strong) UISearchBar *searchBar;

#pragma mark - Data

@property (nonatomic, strong) NSArray *menuData;
@property (nonatomic, strong) NSArray *dependencyData;
@property (nonatomic, strong) NSArray *statesData;
@property (nonatomic, strong) NSArray *impactsData;
@property (nonatomic, strong) NSArray *inauguratorData;
@property (nonatomic, strong) NSArray *clasificationsData;
@property (nonatomic, strong) NSArray *invesmentsData;
@property (nonatomic, strong) NSArray *worksProgramsData;

@property (nonatomic, strong) NSArray *worksResultData;
@property (nonatomic, strong) NSArray *programasResultData;

@property (nonatomic, strong) NSArray *tableViewData;

#pragma mark - Data Saved For Selections

@property (nonatomic, strong) NSArray *dependenciesSavedData;
@property (nonatomic, strong) NSArray *statesSavedData;
@property (nonatomic, strong) NSArray *impactsSavedData;
@property (nonatomic, strong) NSArray *inauguratorSavedData;
@property (nonatomic, strong) NSArray *clasificationsSavedData;
@property (nonatomic, strong) NSArray *invesmentsSavedData;
@property (nonatomic, strong) NSArray *worksProgramsSavedData;

#pragma mark - Animations

@property (nonatomic, strong) CATransition *transition;

#pragma mark - General

@property (nonatomic, assign) MainSearchFields searchField;
@property (nonatomic, strong) JSONHTTPClient *jsonClient;


@end

@implementation MainViewController

#pragma mark - View Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [TSMessage setDefaultViewController:self];
    _mapView.delegate = self;

    /* Date Formatters */
    
    _dateFormatterShort = [[NSDateFormatter alloc]init];
    [_dateFormatterShort setDateFormat:@"dd/MM/yy"];

    /* Setting up Views */
    [self setupUI];
    /* Hide TableView */
    [self hideSearchList:nil];
    [self hideReporteView:nil];

    /*  Menu items */
    
    _menuData       = @[@"Busquedas recientes", @"Favoritos", @"Acerca de"];
    _titleFields    = @[@"Nombre", @"Obras", @"Inversión"];
    
    /* Load Saved Selections */
    
    _dependenciesSavedData      = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreDependencies];
    _statesSavedData            = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreStates];
    _impactsSavedData           = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreImpact];
    _clasificationsSavedData    = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreClasification];
    _invesmentsSavedData        = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreInvesments];
    _worksProgramsSavedData     = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreTypeWorkOrProgram];

    //Si hay datos en los campos de busqueda, cambios el backgroundColor del boton
    
    [self changeBackgroundColorForNumberOfSelections:_dependenciesSavedData andTypeOfFieldButton:e_Dependencia];
    [self changeBackgroundColorForNumberOfSelections:_statesSavedData andTypeOfFieldButton:e_Estado];
    [self changeBackgroundColorForNumberOfSelections:_impactsSavedData andTypeOfFieldButton:e_Impacto];
    [self changeBackgroundColorForNumberOfSelections:_clasificationsSavedData andTypeOfFieldButton:e_Clasificacion];
    [self changeBackgroundColorForNumberOfSelections:_invesmentsSavedData andTypeOfFieldButton:e_Tipo_Inversion];
}

-(void)viewDidAppear:(BOOL)animated{
    /* Request */
    [self requestToWebServices];
}

#pragma mark Server Requests (JSON)

-(void)requestToWebServices{
    
    _jsonClient = [JSONHTTPClient sharedJSONAPIClient];
    _jsonClient.delegate = self;
    
    [_jsonClient performPOSTRequestWithParameters:nil toServlet:kServletEstados withOptions:nil];
    [_jsonClient performPOSTRequestWithParameters:nil toServlet:kServletInauguradores withOptions:nil];
    [_jsonClient performPOSTRequestWithParameters:nil toServlet:kServletImpactos withOptions:nil];
    [_jsonClient performPOSTRequestWithParameters:nil toServlet:kServletConsultarClasificacion withOptions:nil];
    [_jsonClient performPOSTRequestWithParameters:nil toServlet:kServletConsultarDependencias withOptions:nil];
    [_jsonClient performPOSTRequestWithParameters:nil toServlet:kServletConsultarInversiones withOptions:nil];
    [_jsonClient performPOSTRequestWithParameters:nil toServlet:kServletConsultarTipoObraPrograma withOptions:nil];
    
}
#pragma mark - User Interface Customization (View)

/*  Setting the User Interface */

-(void)setupUI{
    
    _btnWorksPrograms = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btnWorksPrograms addTarget:self action:@selector(displayTypesOfProgramasWorks) forControlEvents:UIControlEventTouchUpInside];
    _btnWorksPrograms.frame = CGRectMake(0, 0, 120, 44);
    _btnWorksPrograms.tintColor = [UIColor darkGrayColor];
    _btnWorksPrograms.titleLabel.font = [UIFont systemFontOfSize:17];
    //Imagen
    [_btnWorksPrograms setImage:[UIImage imageNamed:@"arrowDown"] forState:UIControlStateNormal];
    [_btnWorksPrograms setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, 0)];
    [_btnWorksPrograms setTitle:@"Tipo" forState:UIControlStateNormal];
    
    self.navigationItem.titleView = _btnWorksPrograms;
 
    /* Init animation */
    
    _transition = [CATransition animation];
    _transition.duration = 0.3;
    _transition.type = kCATransitionPush;
    [_transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    /* Corner nav buttons bar */
    
    float cornerRadius      = 12.0f;
    float borderWidth       = 1.0f;
    UIColor *borderColor    = [UIColor clearColor];
    
    _btnQuery.layer.cornerRadius        = cornerRadius;
    _btnQuery.layer.borderWidth         = borderWidth;
    _btnQuery.layer.borderColor         = borderColor.CGColor;
    _btnSaveQuery.layer.cornerRadius    = cornerRadius;
    _btnSaveQuery.layer.borderWidth     = borderWidth;
    _btnSaveQuery.layer.borderColor     = borderColor.CGColor;
    
    /* Search bar implementation starts*/
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    _searchBar.placeholder = @"Busqueda rapida";
    _searchBar.delegate = self;
    _searchBar.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *searchBarBtn = [[UIBarButtonItem alloc] initWithCustomView:_searchBar];
    
    /* Menu Navigation bar buttom implementation */
    
    UIImage  *menuImage = [UIImage imageNamed:@"btn_menu"];
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    menuButton.bounds = CGRectMake( 0, 0, menuImage.size.width, menuImage.size.height );
    [menuButton setImage:menuImage forState:UIControlStateNormal];
    _menuBarBtn = [[UIBarButtonItem alloc] initWithCustomView:menuButton];

    /* Add Navigation bar buttom  */

    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:_menuBarBtn, searchBarBtn, nil];

    /* Navigation bar buttom implementation */

    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    UIBarButtonItem *logoBar = [[UIBarButtonItem alloc]initWithCustomView:logoImageView];
    
    self.navigationItem.rightBarButtonItem = logoBar;
}


#pragma mark JSONHTTPClient Delegate

/* JSON Estados */

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToTypesOfWorksAndPrograms:(id)response{
    
    _worksProgramsData = response;
}

/* JSON Estados */

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToStates:(id)response{
    
    _statesData = response;
}

/* JSON Inauguradores */

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToInaugurators:(id)response{
    
    _inauguratorData = response;
}

/* JSON Impactos */

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToImpacts:(id)response{
    
    _impactsData = response;
}

/* JSON Clasificaciones */

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToClasifications:(id)response{
    
    _clasificationsData = response;
}

/* JSON Depedencias */

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToDependencies:(id)response{
    
    _dependencyData = response;
}

/* JSON Tipo de inversiones */

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToTypesOfInvesments:(id)response{
    
    _invesmentsData = response;
}

/* JSON Error */

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didFailResponseWithError:(NSError *)error{
    
    NSLog(@"Error : %@", [error localizedDescription]);
}


#pragma mark - Resultado Busquedas

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseSearchWorks:(id)response{
    
    _tableViewData = response;
    
    [self.tableView reloadData];
    
    /* Animaciones para el TableView */
    if (_tableView.isHidden) {
        _tableView.hidden = NO;
        _transition.subtype = kCATransitionFromLeft;
        [_tableView.layer addAnimation:_transition forKey:nil];
    }
    
    /* Animaciones para el Report View */

    if (_reportView.isHidden) {
        _reportView.hidden = NO;
        _transition.subtype = kCATransitionFromRight;
        [_reportView.layer addAnimation:_transition forKey:nil];
    }

    /* Muestra los pines en el mapa */
    [self displayPinsMapView];
    
    _spreadView.delegate = self;
    _spreadView.dataSource = self;
    [_spreadView reloadData];
    
    [kAppDelegate notShowActivityIndicator:M13ProgressViewActionNone whithMessage:kHUDMsgLoading delay:1.0];
}



#pragma mark - MKMapDelegate

//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
//    
//    MKAnnotationView *mypin = (MKAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier: [annotation title]];
//    if (mypin == nil) {
//        mypin = [[MKAnnotationView alloc]  initWithAnnotation: annotation reuseIdentifier: [annotation title]];
//    } else {
//        mypin.annotation = annotation;
//        //pin = [[[MKPinAnnotationView alloc]  initWithAnnotation: annotation reuseIdentifier: [annotation title]] autorelease];
//        
//    }
//    
//    mypin.tintColor = [UIColor greenColor];
//    mypin.backgroundColor = [UIColor redColor];
//    //UIButton *goToDetail = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    //mypin.rightCalloutAccessoryView = myBtn;
//    mypin.draggable = NO;
//    mypin.highlighted = YES;
//    //mypin.animatesDrop = TRUE;
//    mypin.canShowCallout = YES;
//    return mypin;
//}
//
//
//- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
//calloutAccessoryControlTapped:(UIControl *)control
//{
//    
//    NSLog(@"%@",view.annotation.title);
//    NSLog(@"%@",view.annotation.subtitle);}
//
//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
//    NSLog(@"Entro 1");
//}

#pragma mark - Methods of action (Selectors - IBOulet)

/* Display the menu items */

-(void)showMenu{
    
    [self displayItemsOnButton:_menuBarBtn
                   withDataSource:_menuData
        withDataToShowCheckBox:nil
                  isBarButtonItem:YES
                           isMenu:YES
                      searchField:_searchField];
}

/* Button that allows to sort a search */

- (IBAction)sortSearch:(id)sender {
    
 
}

- (void)displayTypesOfProgramasWorks {
    
    [self displayItemsOnButton:_btnWorksPrograms
                withDataSource:_worksProgramsData
        withDataToShowCheckBox:_worksProgramsSavedData
               isBarButtonItem:NO
                        isMenu:NO
                   searchField:e_Tipo];

}

/* Muestra las dependencias */

- (IBAction)displayDependencies:(id)sender {
    
    [self displayItemsOnButton:_btndependency
                   withDataSource:_dependencyData
         withDataToShowCheckBox:_dependenciesSavedData
                  isBarButtonItem:NO
                           isMenu:NO
                      searchField:e_Dependencia];
}

/* Muestra los estados */

- (IBAction)displayStates:(id)sender {
    
    [self displayItemsOnButton:_btnStates
                withDataSource:_statesData
        withDataToShowCheckBox:_statesSavedData
               isBarButtonItem:NO
                        isMenu:NO
                   searchField:e_Estado];

}

/* Muestra los municpios */


- (IBAction)displayCities:(id)sender {
    
    
}

/* Muestra los impactos */

- (IBAction)displayTypeOfImpacts:(id)sender {
    
    [self displayItemsOnButton:_btnImpact
                withDataSource:_impactsData
        withDataToShowCheckBox:_impactsSavedData
               isBarButtonItem:NO
                        isMenu:NO
                   searchField:e_Impacto];
}

/* Muestra las clasificaciones */

- (IBAction)displayClasifications:(id)sender {
    
    [self displayItemsOnButton:_btnClasification
                withDataSource:_clasificationsData
        withDataToShowCheckBox:_clasificationsSavedData
               isBarButtonItem:NO
                        isMenu:NO
                   searchField:e_Clasificacion];
}

- (IBAction)displayTypeOfInvesments:(id)sender {
    
    
    [self displayItemsOnButton:_btnTypeInvestment
                withDataSource:_invesmentsData
        withDataToShowCheckBox:_invesmentsSavedData
               isBarButtonItem:NO
                        isMenu:NO
                   searchField:e_Tipo_Inversion];
}


- (IBAction)displayCalendar:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    _isStartDate = button.tag == 0 ? YES : NO;
    
    if ([self.pmCC isCalendarVisible])  [self.pmCC dismissCalendarAnimated:NO];

    [self initializeCalendar];
    
    [self.pmCC presentCalendarFromView:sender
              permittedArrowDirections:PMCalendarArrowDirectionAny
                             isPopover:YES
                              animated:YES];
    
}


-(void)initializeCalendar{
    
    self.pmCC = [[PMCalendarController alloc] initWithThemeName:@"default"];
    self.pmCC.delegate = self;
    self.pmCC.mondayFirstDayOfWeek = NO;
    self.pmCC.period = [PMPeriod oneDayPeriodWithDate:[NSDate date]];
    [self calendarController:self.pmCC didChangePeriod:self.pmCC.period];

}


#pragma mark - Realizar consulta


/* Realizar consulta */

- (IBAction)perfomQuery:(id)sender {
    
    NSDictionary *parameters = [self buildServletParameters];
    NSLog(@"%@", parameters);
    [kAppDelegate showActivityIndicator:M13ProgressViewActionNone whithMessage:kHUDMsgLoading delay:0];
    
    [_jsonClient performPOSTRequestWithParameters:parameters toServlet:kServletBuscar withOptions:@"obras"];
    
    
}

#pragma mark - Guardar Consulta

/* Guardar Consulta */

- (IBAction)performSaveQuery:(id)sender {
    
    [[[UIAlertView alloc]initWithTitle:@"Guardar consulta" message:@"¿Deseas guardar la consulta?" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil]show];
}

#pragma mark - Servlet Parameters

-(NSDictionary *)buildServletParameters{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *parameterValue = @"";
    
    /* Depedencias */
    
    if (_dependenciesSavedData.count > 0) {
        
        for (int i=0; i<[_dependenciesSavedData count]; i++) {
            Dependencia *dependencia = _dependenciesSavedData[i];
            parameterValue = [parameterValue stringByAppendingString:dependencia.idDependencia];
            if (i!=_dependenciesSavedData.count-1) {
                parameterValue = [parameterValue stringByAppendingString:@","];
            }
        }
        [parameters setObject:parameterValue forKey:kParamDependencia];
    }
    
    /* Estados */
    
    parameterValue = @"";
    
    if (_statesSavedData.count > 0) {
        
        for (int i=0; i<[_statesSavedData count]; i++) {
            Estado *estado = _statesSavedData[i];
            parameterValue = [parameterValue stringByAppendingString:estado.idEstado];
            if (i!=_statesSavedData.count-1) {
                parameterValue = [parameterValue stringByAppendingString:@","];
            }
        }
        [parameters setObject:parameterValue forKey:kParamEstado];
    }
    
    /* Tipo de inversión */
    
    parameterValue = @"";
    
    if (_invesmentsSavedData.count > 0) {
        
        for (int i=0; i<[_invesmentsSavedData count]; i++) {
            Inversion *inversion = _invesmentsSavedData[i];
            parameterValue = [parameterValue stringByAppendingString:inversion.idTipoInversion];
            if (i!=_invesmentsSavedData.count-1) {
                parameterValue = [parameterValue stringByAppendingString:@","];
            }
        }
        [parameters setObject:parameterValue forKey:kParamTipoDeInversion];
    }
    
    /* Impacto */
    
    parameterValue = @"";
    
    if (_impactsSavedData.count > 0) {
        
        for (int i=0; i<[_impactsSavedData count]; i++) {
            Impacto *impacto = _impactsSavedData[i];
            parameterValue = [parameterValue stringByAppendingString:impacto.idImpacto];
            if (i!=_impactsSavedData.count-1) {
                parameterValue = [parameterValue stringByAppendingString:@","];
            }
        }
        [parameters setObject:parameterValue forKey:kParamImpacto];
    }
    
    /* Clasificaciones */
    
    parameterValue = @"";
    
    if (_clasificationsSavedData.count > 0) {
        
        for (int i=0; i<[_clasificationsSavedData count]; i++) {
            Clasificacion *clasificacion = _clasificationsSavedData[i];
            parameterValue = [parameterValue stringByAppendingString:clasificacion.idTipoClasificacion];
            if (i!=_clasificationsSavedData.count-1) {
                parameterValue = [parameterValue stringByAppendingString:@","];
            }
        }
        [parameters setObject:parameterValue forKey:kParamClasificacion];
    }
    
    
    
    return parameters;
}

#pragma mark - displayPinsOnMap

-(void)displayPinsMapView{
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    for (Obra *obra in _tableViewData) {
        
        CLLocationCoordinate2D annotationCoord;
        
        annotationCoord.latitude = [obra.estado.latitud doubleValue];
        annotationCoord.longitude = [obra.estado.longitud doubleValue];
        
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = annotationCoord;
        annotationPoint.title = obra.denominacion;
        annotationPoint.subtitle = obra.estado.nombreEstado;
        [_mapView addAnnotation:annotationPoint];
    }
    
    CLLocationCoordinate2D annotationCoord;
    annotationCoord.latitude = 23.123548;
    annotationCoord.longitude = - 102.293513;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(annotationCoord, 1000.0*METERS_PER_MILE, 1000.0*METERS_PER_MILE);
    [_mapView setRegion:viewRegion animated:YES];
    
}

#pragma mark Display Pop Up List

-(void)displayItemsOnButton:(id)sender
             withDataSource:(NSArray *)data
     withDataToShowCheckBox:(NSArray *)loadData
            isBarButtonItem:(BOOL)isBarButton
                     isMenu:(BOOL)isMenu
                searchField:(MainSearchFields)aSearchField{
    
    _popUpTableView = [[PopupListTableViewController alloc]initWithData:data
                                                                 isMenu:isMenu
                                                               markData:loadData
                                                            searchField:aSearchField];
    _popUpTableView.delegate = self;
    
    if (!_popOverView.popoverVisible && _popOverView != nil) {
        _popOverView = nil;
    }
    
    UIButton *button = (UIButton *)sender;

    if (_popOverView == nil ) {
        _popOverView = [[UIPopoverController alloc]initWithContentViewController:_popUpTableView];
        
        if (isBarButton) {
            [_popOverView presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }else if(aSearchField == e_Tipo){
            [_popOverView presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

        }else{
            [_popOverView presentPopoverFromRect:button.frame inView:_buttonsView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

        }
        
    }else{
        [_popOverView dismissPopoverAnimated:YES];
        _popOverView = nil;
    }
}


#pragma mark - PopupListTableView Delegate -Save Data

//Cuando el PopUp desaparece el delegado envia los datos seleccionados, posteriomente almacenamos los datos.

-(void)popupListView:(PopupListTableViewController *)popupListTableView dataForMultipleSelectedRows:(NSArray *)data{
    
    [self changeBackgroundColorForNumberOfSelections:data andTypeOfFieldButton:popupListTableView.field];
    
    if (popupListTableView.field == e_Dependencia) {
        _dependenciesSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreDependencies];
        
    }else if (popupListTableView.field == e_Estado){
        
        _statesSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreStates];
        
    }else if (popupListTableView.field == e_Impacto){
        
        _impactsSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreImpact];
        
    }else if (popupListTableView.field == e_Clasificacion){
        _clasificationsSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreClasification];
        
    }else if (popupListTableView.field == e_Tipo_Inversion){
        _invesmentsSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreInvesments];
    }
}

-(void)changeBackgroundColorForNumberOfSelections:(NSArray *)dataField andTypeOfFieldButton:(MainSearchFields)field{
    
    //Si hay datos seleccionados, cambiamos el background del boton para mostrar existen selecciones en el boton
    BOOL changeBackground = dataField.count > 0 ? YES : NO;
    
    UIColor *colorForSelection = changeBackground ? [UIColor colorForButtonSelection] : [UIColor clearColor];
    
    if (field == e_Dependencia) {
        _btndependency.backgroundColor = colorForSelection;
    }else if (field == e_Estado){
        _btnStates.backgroundColor = colorForSelection;
    }else if (field == e_Impacto){
        _btnImpact.backgroundColor = colorForSelection;
    }else if (field == e_Clasificacion){
        _btnClasification.backgroundColor = colorForSelection;
    }else if (field == e_Tipo_Inversion){
        _btnTypeInvestment.backgroundColor = colorForSelection;
    }
}


#pragma mark - UITableView  DataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _tableViewData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Obra *obra = _tableViewData[indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    
    ObraProgramaCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.lblDenominacion.text   = obra.denominacion;
    cell.lblIdObraPrograma.text = obra.idObra;
    cell.lblEstado.text         = obra.estado.nombreEstado;
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;

}

#pragma mark - UITableView  Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Obra *obra = _tableViewData[indexPath.row];
    [self performSegueWithIdentifier:@"ObraProgramaDetail" sender:self];
    NSLog(@"%@", obra);
}

#pragma mark PMCalendarControllerDelegate methods

- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
{
    NSString *startDate = [_dateFormatterShort stringFromDate:newPeriod.startDate];
    NSString *endDate   = [_dateFormatterShort stringFromDate:newPeriod.endDate];
    NSString *dateTitle = [NSString stringWithFormat:@"%@ - %@", startDate, endDate];
    UILabel *label    = _isStartDate ? _lblStartDate : _lblEndDate;
    label.text = dateTitle;
    
}

#pragma mark - Spread View Datasource

- (NSInteger)numberOfColumnSectionsInSpreadView:(MDSpreadView *)aSpreadView{
    return 1;
}

- (NSInteger)numberOfRowSectionsInSpreadView:(MDSpreadView *)aSpreadView{
    
    return 1;
}

- (NSInteger)spreadView:(MDSpreadView *)aSpreadView numberOfColumnsInSection:(NSInteger)section{
    
    return _titleFields.count;
    
}

- (NSInteger)spreadView:(MDSpreadView *)aSpreadView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

#pragma mark --- Heights

- (CGFloat)spreadView:(MDSpreadView *)aSpreadView heightForRowAtIndexPath:(MDIndexPath *)indexPath{
    return 31;
}

- (CGFloat)spreadView:(MDSpreadView *)aSpreadView heightForRowHeaderInSection:(NSInteger)rowSection{
    //    if (rowSection == 2) return 0; // uncomment to hide this header!
    return 45;
}

- (CGFloat)spreadView:(MDSpreadView *)aSpreadView widthForColumnAtIndexPath:(MDIndexPath *)indexPath{
    
    return 88;
}

- (CGFloat)spreadView:(MDSpreadView *)aSpreadView widthForColumnHeaderInSection:(NSInteger)columnSection{
    //    if (columnSection == 2) return 0; // uncomment to hide this header!
    return 0;
}

#pragma - Cells

- (MDSpreadViewCell *)spreadView:(MDSpreadView *)aSpreadView cellForRowAtIndexPath:(MDIndexPath *)rowPath forColumnAtIndexPath:(MDIndexPath *)columnPath{
    
    static NSString *cellIdentifier = @"Cell";
    MDSpreadViewCell *cell = [aSpreadView dequeueReusableCellWithIdentifier:cellIdentifier];
        
    if (cell == nil) {
        cell = [[MDSpreadViewCell alloc] initWithStyle:MDSpreadViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = @"Texto";
    return cell;
}

- (id)spreadView:(MDSpreadView *)aSpreadView titleForHeaderInRowSection:(NSInteger)section forColumnAtIndexPath:(MDIndexPath *)columnPath
{

    return _titleFields[columnPath.row];
}

#pragma mark - UISearchBar Delegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [_searchBar setShowsCancelButton:NO animated:YES];
    [_searchBar resignFirstResponder];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    [_searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [_searchBar setShowsCancelButton:NO animated:YES];
    [_searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

#pragma mark Hide Lists

- (IBAction)hideSearchList:(id)sender {
    
    /* When de user press the button if the list is hidden the list is displayed */
    
    if ([_tableView isHidden]) {
        _tableView.hidden = NO;
        _transition.subtype = kCATransitionFromLeft;
        
    }else{
        _tableView.hidden = YES;
        _transition.subtype = kCATransitionFromRight;
    }
    /* Add animation */
    [_tableView.layer addAnimation:_transition forKey:nil];
}

- (IBAction)hideReporteView:(id)sender {
    
    /* When de user press the button if the list is hidden the list is displayed */
    
    if ([_reportView isHidden]) {
        _reportView.hidden = NO;
        _transition.subtype = kCATransitionFromRight;
        
    }else{
        _reportView.hidden = YES;
        _transition.subtype = kCATransitionFromLeft;
    }
    /* Add animation */
    [_reportView.layer addAnimation:_transition forKey:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
