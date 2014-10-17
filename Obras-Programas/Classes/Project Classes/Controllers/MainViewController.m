
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
#import "Inaugurador.h"
#import "Consulta.h"
#import "MDSpreadView.h"
#import "QBPopupMenu.h"
#import "QBPlasticPopupMenu.h"
#import "ListaReporteGeneral.h"
#import "ListaReporteEstado.h"
#import "ListaReporteDependencia.h"
#import "DBHelper.h"
#import "FichaTecnicaViewController.h"
#import "GraficasViewController.h"


#define METERS_PER_MILE 1609.344

@interface MainViewController () <MDSpreadViewDataSource, MDSpreadViewDelegate>

#pragma mark - IBOutLets

/* PopMenu */

@property (nonatomic, strong) QBPopupMenu *popupMenu;
@property (nonatomic, strong) QBPopupMenu *morePopupMenu;

/* IBOutlets*/

@property (weak, nonatomic) IBOutlet UITextField *txtRangoMinimo;
@property (weak, nonatomic) IBOutlet UITextField *txtRangoMaximo;
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
@property (weak, nonatomic) IBOutlet UIButton *btnInaugurator;
@property (weak, nonatomic) IBOutlet UIButton *btnSusceptible;
@property (weak, nonatomic) IBOutlet UIButton *btnInaugurada;

@property (weak, nonatomic) IBOutlet UILabel *lblStartIniDate;
@property (weak, nonatomic) IBOutlet UILabel *lblStartEndDate;

@property (weak, nonatomic) IBOutlet UILabel *lblEndIniDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndEndDate;

@property (strong, nonatomic) UIBarButtonItem *menuBarBtn;
@property (strong, nonatomic) UIButton *btnWorksPrograms;



#pragma mark - Reporte 

@property (nonatomic, strong) NSArray *titleFields;

#pragma mark - Calendar

@property (nonatomic, strong) PMCalendarController *pmCC;
@property (nonatomic, strong) NSDateFormatter *dateFormatterGeneral;
@property (nonatomic, strong) NSDateFormatter *dateFormatterShort;
@property (nonatomic, strong) UIButton *btnCalendarSelected;
@property (nonatomic, strong) UILabel *lblCalendarSelected;

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

@property (nonatomic, strong) NSArray *inauguratorOptionData;
@property (nonatomic, strong) NSArray *susceptibleOptionData;

@property (nonatomic, strong) NSArray *worksResultData;
@property (nonatomic, strong) NSArray *programasResultData;

@property (nonatomic, strong) NSMutableArray *tableViewData;

#pragma mark - Data Saved For Selections

@property (nonatomic, strong) NSArray *dependenciesSavedData;
@property (nonatomic, strong) NSArray *statesSavedData;
@property (nonatomic, strong) NSArray *impactsSavedData;
@property (nonatomic, strong) NSArray *inauguratorSavedData;
@property (nonatomic, strong) NSArray *clasificationsSavedData;
@property (nonatomic, strong) NSArray *invesmentsSavedData;
@property (nonatomic, strong) NSArray *worksProgramsSavedData;
@property (nonatomic, strong) NSArray *inauguratorOptionSavedData;
@property (nonatomic, strong) NSArray *susceptibleOptionSavedData;


@property (nonatomic, strong) NSString *limiteMin;
@property (nonatomic, strong) NSString *limiteMax;

@property (nonatomic, strong) NSDate *fechaInicio;
@property (nonatomic, strong) NSDate *fechaInicioSegunda;
@property (nonatomic, strong) NSDate *fechaFin;
@property (nonatomic, strong) NSDate *fechaFinSegunda;

#pragma mark - Animations

@property (nonatomic, strong) CATransition *transition;

#pragma mark - Grid (Reportes)

@property (nonatomic, strong) NSMutableArray *stateReportData;
@property (nonatomic, strong) NSMutableArray *dependenciesReportData;

#pragma mark - General

@property (nonatomic, assign) MainSearchFields searchField;
@property (nonatomic, strong) JSONHTTPClient *jsonClient;
@property (nonatomic, strong) NSNumberFormatter *currencyFormatter;
@property ReportOption reportOption;

@end

@implementation MainViewController

#pragma mark - View Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [TSMessage setDefaultViewController:self];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    
    /* Number Formatter */
    
    _currencyFormatter = [[NSNumberFormatter alloc] init];
    [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    /* Inaugurador, Suceptible Data for Array*/
    
    NSArray *options = @[@"Si", @"No"];
    
    _inauguratorOptionData = options;
    _susceptibleOptionData = options;
    
    /* PopUp */
    
    QBPopupMenuItem *item = [QBPopupMenuItem itemWithTitle:@"Fecha inicio" target:self action:@selector(displayStartCalendar:)];
    QBPopupMenuItem *item2 = [QBPopupMenuItem itemWithTitle:@"" image:[UIImage imageNamed:@"trash"] target:self action:@selector(deleteStartDate:)];
    QBPopupMenuItem *item3 = [QBPopupMenuItem itemWithTitle:@"Fecha final" target:self action:@selector(displayEndCalendar:)];
    QBPopupMenuItem *item4 = [QBPopupMenuItem itemWithTitle:@"" image:[UIImage imageNamed:@"trash"] target:self action:@selector(deleteEndDate:)];

    NSArray *items = @[item, item2, item3, item4];
    
    QBPopupMenu *popupMenu = [[QBPopupMenu alloc] initWithItems:items];
    popupMenu.highlightedColor = [[UIColor colorWithRed:0 green:0.478 blue:1.0 alpha:1.0] colorWithAlphaComponent:0.8];
    self.popupMenu = popupMenu;

    
    QBPopupMenuItem *item10 = [QBPopupMenuItem itemWithTitle:@"Limpiar consulta" target:self action:@selector(cleanQuery:)];
    QBPopupMenuItem *item11 = [QBPopupMenuItem itemWithTitle:@"Ver detalle consulta" target:self action:@selector(displayQueryDetail:)];
    
    NSArray *itemsMoreButton = @[item10, item11];
    
    self.morePopupMenu = [[QBPopupMenu alloc] initWithItems:itemsMoreButton];
    self.morePopupMenu.highlightedColor = [[UIColor colorWithRed:0 green:0.478 blue:1.0 alpha:1.0] colorWithAlphaComponent:0.8];


    /* Date Formatters */
    
    _dateFormatterShort = [[NSDateFormatter alloc]init];
    [_dateFormatterShort setDateFormat:@"dd/MM/yy"];
    
    _dateFormatterGeneral = [[NSDateFormatter alloc]init];
    [_dateFormatterGeneral setDateFormat:@"yyyy-MM-dd"];

    /* Setting up Views */
    [self setupUI];
    /* Hide TableView */
    [self hideSearchList:nil];
    [self hideReporteView:nil];

    /*  Menu items */
    
    _menuData       = @[@"Busquedas guardadas", @"Registros guardados", @"Acerca de"];
    
    _titleFields    = @[@{@"title": @"Estado",     @"sortKey": @"estado.nombreEstado"},
                        @{@"title": @"Obras",      @"sortKey": @"numeroObras"},
                        @{@"title": @"Inversión",  @"sortKey": @"totalInvertido"}];
           ;
    
    /* Load Saved Selections */
    
    _dependenciesSavedData      = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreDependencies];
    
    _statesSavedData            = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreStates];
    _impactsSavedData           = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreImpact];
    _clasificationsSavedData    = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreClasification];
    _invesmentsSavedData        = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreInvesments];
    _worksProgramsSavedData     = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreTypeWorkOrProgram];
    _inauguratorSavedData       = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreInaugurators];
    _lblStartIniDate.text       = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreStartIniDate];
    _lblStartEndDate.text       = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreStartEndDate];
    _lblEndIniDate.text         = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreEndIniDate];
    _lblEndEndDate.text         = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreEndEndDate];
    
    _inauguratorOptionSavedData = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreInauguradaOption];
    _susceptibleOptionSavedData = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreSusceptibleOption];

    //Si hay datos en los campos de busqueda, cambios el backgroundColor del boton
    
    [self changeBackgroundColorForNumberOfSelections:_dependenciesSavedData andTypeOfFieldButton:e_Dependencia];
    [self changeBackgroundColorForNumberOfSelections:_statesSavedData andTypeOfFieldButton:e_Estado];
    [self changeBackgroundColorForNumberOfSelections:_impactsSavedData andTypeOfFieldButton:e_Impacto];
    [self changeBackgroundColorForNumberOfSelections:_clasificationsSavedData andTypeOfFieldButton:e_Clasificacion];
    [self changeBackgroundColorForNumberOfSelections:_invesmentsSavedData andTypeOfFieldButton:e_Tipo_Inversion];
    [self changeBackgroundColorForNumberOfSelections:_inauguratorSavedData andTypeOfFieldButton:e_Nombre_Inaugura];
    [self changeBackgroundColorForNumberOfSelections:_inauguratorOptionSavedData andTypeOfFieldButton:e_Inaugurada];
    [self changeBackgroundColorForNumberOfSelections:_susceptibleOptionSavedData andTypeOfFieldButton:e_Suscpetible];
}


-(void)viewDidAppear:(BOOL)animated{
    /* Request */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showFichaTecnica:) name:@"showFichaTecnica" object:nil];

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
    
    float cornerRadius      = 8.0f;
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

- (IBAction)displayInaugurators:(id)sender {
    
    [self displayItemsOnButton:_btnInaugurator
                withDataSource:_inauguratorData
        withDataToShowCheckBox:_inauguratorSavedData
               isBarButtonItem:NO
                        isMenu:NO
                   searchField:e_Nombre_Inaugura];

}

- (IBAction)displayReportByDependency:(id)sender {
    
    _reportOption = r_dependency;
    
    [_spreadView reloadData];

}

- (IBAction)displayReportByState:(id)sender {
    _reportOption = r_state;
    [_spreadView reloadData];
}

- (IBAction)displayInauguradaOptions:(id)sender {
    
    [self displayItemsOnButton:_btnInaugurada
                withDataSource:_inauguratorOptionData
        withDataToShowCheckBox:_inauguratorOptionSavedData
               isBarButtonItem:NO
                        isMenu:NO
                   searchField:e_Inaugurada];
}

- (IBAction)displaySusceptibleOptions:(id)sender {
    
    [self displayItemsOnButton:_btnSusceptible
                withDataSource:_susceptibleOptionData
        withDataToShowCheckBox:_susceptibleOptionSavedData
               isBarButtonItem:NO
                        isMenu:NO
                   searchField:e_Suscpetible];
}

- (IBAction)displayMoreOptions:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self.morePopupMenu showInView:self.view targetRect:button.frame animated:YES];
 
}

-(void)cleanQuery:(id)sender{
    
}

-(void)displayQueryDetail:(id)sender{
    
}

#pragma mark - Calendar

- (IBAction)displayCalendar:(id)sender{
    
    _btnCalendarSelected = (UIButton *)sender;
    [self.popupMenu showInView:self.view targetRect:_btnCalendarSelected.frame animated:YES];
  
}

-(void)displayStartCalendar:(id)sender{
    
    _isStartDate = YES;
    if (_btnCalendarSelected == _btnStartDate) {
        _lblCalendarSelected = _lblStartIniDate;
    }else if (_btnCalendarSelected == _btnEndDate){
        _lblCalendarSelected = _lblEndIniDate;
    }
    [self showCalendarControl];
}

-(void)showCalendarControl{
    
    if ([self.pmCC isCalendarVisible])  [self.pmCC dismissCalendarAnimated:NO];
    
    [self initializeCalendar];
    
    [self.pmCC presentCalendarFromView:_btnCalendarSelected
              permittedArrowDirections:PMCalendarArrowDirectionAny
                             isPopover:YES
                              animated:YES];
}

-(void)displayEndCalendar:(id)sender{
    
    _isStartDate = NO;
    if (_btnCalendarSelected == _btnStartDate) {
        _lblCalendarSelected = _lblStartEndDate;
    }else if (_btnCalendarSelected == _btnEndDate){
        _lblCalendarSelected = _lblEndEndDate;
    }
    [self showCalendarControl];
}


-(void)initializeCalendar{
    
    self.pmCC = [[PMCalendarController alloc] initWithThemeName:@"default"];
    self.pmCC.delegate = self;
    self.pmCC.allowsPeriodSelection = NO;
    self.pmCC.mondayFirstDayOfWeek = NO;
    self.pmCC.period = [PMPeriod oneDayPeriodWithDate:[NSDate date]];
    [self calendarController:self.pmCC didChangePeriod:self.pmCC.period];
}

-(void)deleteStartDate:(id)sender{
    
    if (_btnCalendarSelected == _btnStartDate) {
        _lblStartIniDate.text = @"";
    }else if (_btnCalendarSelected == _btnEndDate){
        _lblEndIniDate.text = @"";
    }
}

-(void)deleteEndDate:(id)sender{
    if (_btnCalendarSelected == _btnStartDate) {
        _lblStartEndDate.text = @"";
    }else if (_btnCalendarSelected == _btnEndDate){
        _lblEndEndDate.text = @"";
    }
}

#pragma mark PMCalendarControllerDelegate methods

- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
{
    NSString *dateCalendar = [_dateFormatterShort stringFromDate:newPeriod.startDate];
    
    if (_lblCalendarSelected == _lblStartIniDate) {
        
        if (_lblStartIniDate.text.length==0) {
            _fechaInicioSegunda = newPeriod.startDate;
            _lblStartEndDate.text = dateCalendar;
        }
        _fechaInicio = newPeriod.startDate;
    }else if (_lblCalendarSelected == _lblStartEndDate) {
        _fechaInicioSegunda = newPeriod.startDate;
    }else if (_lblCalendarSelected == _lblEndIniDate) {
        
        if (_lblEndIniDate.text.length==0) {
            _fechaFin = newPeriod.startDate;
            _lblEndEndDate.text = dateCalendar;
        }
        
        //        NSComparisonResult result = [_fechaInicio compare:newPeriod.startDate];
        //
        //        if (result != NSOrderedAscending) {
        //            [[[UIAlertView alloc]initWithTitle:@"Fecha incorrecta" message:@"La fecha de termino no puede ser menor a la fecha de comienzo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil] show];
        //            return;
        //        }
        
        _fechaFin = newPeriod.startDate;
    }else if (_lblCalendarSelected == _lblEndEndDate) {
        _fechaFinSegunda = newPeriod.startDate;
    }
    
    _lblCalendarSelected.text = dateCalendar;
}


#pragma mark - *************  REQUEST TO SERVER MAIN QUERY

const NSInteger numberOfResults = 50;

/* Realizar consulta */

- (IBAction)perfomQuery:(id)sender {
    
    NSDictionary *parameters = [self buildServletParameters];
    NSLog(@"%@", parameters);
    [kAppDelegate showActivityIndicator:M13ProgressViewActionNone whithMessage:kHUDMsgLoading delay:0];
    
    [_jsonClient performPOSTRequestWithParameters:parameters toServlet:kServletBuscar withOptions:@"obras"];
}

#pragma mark - Resultado Busquedas

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseSearchWorks:(id)response{
    
    NSDictionary *objectsResponse = response;
    
    _tableViewData          = objectsResponse[kKeyListaObras];
    _stateReportData        = objectsResponse[kKeyListaReporteEstado];
    
    _dependenciesReportData = objectsResponse[kKeyListaReporteDependencia];
    
    
    NSArray *generalData    = objectsResponse[kKeyListaReporteGeneral];
    
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
    
    if (_tableViewData.count>0) {
        
        NSString *numObras = @"0";
        
        if (generalData>0) {
            ListaReporteGeneral *general = generalData[0];
            numObras = [NSString stringWithFormat:@"%@", general.numeroObras];
        }
        NSString *mesage = [NSString stringWithFormat:@"%@ resultados\nencontrados", numObras];
        [kAppDelegate notShowActivityIndicator:M13ProgressViewActionSuccess whithMessage:mesage delay:2.0];
        
    }else{
        [kAppDelegate notShowActivityIndicator:M13ProgressViewActionNone whithMessage:@"Sin resultados" delay:1.0];
    }
}

#pragma mark - Guardar Consulta

/* Guardar Consulta */

- (IBAction)performSaveQuery:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Guardando consulta"
                                                   message:@"Ingresa el nombre de la consulta"
                                                  delegate:self
                                         cancelButtonTitle:@"Aceptar"
                                         otherButtonTitles:@"Cancelar", nil];
    
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"Aceptar"]) {
        
        Consulta *consulta = [[Consulta alloc]init];
        
        UITextField *textfield =  [alertView textFieldAtIndex: 0];
        NSString *queryName = textfield.text;
        
        
        if (_dependenciesSavedData.count>0)
            consulta.dependenciasData = _dependenciesSavedData;
        if (_statesSavedData.count>0)
            consulta.estadosData = _statesSavedData;

        if (_invesmentsSavedData.count>0)
            consulta.tipoDeInversionesData = _invesmentsSavedData;

        if (_impactsSavedData.count>0)
            consulta.impactosData = _impactsSavedData;

        if (_clasificationsSavedData.count>0)
            consulta.clasificacionesData = _clasificationsSavedData;

        if (queryName.length == 0){
            consulta.nombreConsulta = @"Sin Nombre";

        }else{
            consulta.nombreConsulta = queryName;
        }
        
        [DBHelper saveConsulta:consulta];
    }
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
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
    
    /* Rango de inversion*/
    
    if (_txtRangoMinimo.text.length >0) {
        [parameters setObject:[self changeFormatStringToNSNumber:_txtRangoMinimo.text] forKey:kParamInversionMinima];
        
        if (_txtRangoMaximo.text.length == 0) {
            NSNumber *maxFloat = [NSNumber numberWithFloat:MAXFLOAT];
            [parameters setObject:maxFloat forKey:kParamImversionMaxima];
        }
    }
    
    if (_txtRangoMaximo.text.length > 0){
        [parameters setObject:[self changeFormatStringToNSNumber:_txtRangoMaximo.text] forKey:kParamImversionMaxima];

        if (_txtRangoMinimo.text.length == 0) {
            NSNumber *minFloat = [NSNumber numberWithFloat:0];
            [parameters setObject:minFloat forKey:kParamInversionMinima];
        }
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
    
    /* Inaguradores */
    
    parameterValue = @"";
    
    if (_inauguratorSavedData.count > 0) {
        
        for (int i=0; i<[_inauguratorSavedData count]; i++) {
            Inaugurador *inaugurador = _inauguratorSavedData[i];
            parameterValue = [parameterValue stringByAppendingString:inaugurador.idCargoInaugura];
            if (i!=_inauguratorSavedData.count-1) {
                parameterValue = [parameterValue stringByAppendingString:@","];
            }
        }
        [parameters setObject:parameterValue forKey:kParamInaugurador];
    }
    
    /* Fechas */
    
    if (_lblStartIniDate.text.length>0) {
        NSString *dateStr = [_dateFormatterGeneral stringFromDate:_fechaInicio];
        [parameters setObject:dateStr forKey:kParamFechaInicio];
    }
    if (_lblStartEndDate.text.length>0) {
        NSString *dateStr = [_dateFormatterGeneral stringFromDate:_fechaInicioSegunda];

        [parameters setObject:dateStr forKey:kParamFechaInicioSegunda];
    }
    if (_lblEndIniDate.text.length>0) {
        NSString *dateStr = [_dateFormatterGeneral stringFromDate:_fechaFin];
        [parameters setObject:dateStr forKey:kParamFechaFin];
    }
    if (_lblEndEndDate.text.length>0) {
        NSString *dateStr = [_dateFormatterGeneral stringFromDate:_fechaFinSegunda];
        [parameters setObject:dateStr forKey:kParamFechaFinSegunda];
    }
    
    /*Limite */
    [parameters setObject:@"0"  forKey:kParamLimiteMin];
    [parameters setObject:@"500" forKey:kParamLimiteMax];


    return parameters;
}

-(NSNumber *)changeFormatStringToNSNumber:(NSString *)textFieldStr{
    
    NSMutableString *textFieldStrValue = [NSMutableString stringWithString:textFieldStr];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    [textFieldStrValue replaceOccurrencesOfString:numberFormatter.currencySymbol
                                       withString:@""
                                          options:NSLiteralSearch
                                            range:NSMakeRange(0, [textFieldStrValue length])];
    
    [textFieldStrValue replaceOccurrencesOfString:numberFormatter.groupingSeparator
                                       withString:@""
                                          options:NSLiteralSearch
                                            range:NSMakeRange(0, [textFieldStrValue length])];
    
    NSDecimalNumber *textFieldNum = [NSDecimalNumber decimalNumberWithString:textFieldStrValue];
    
    return textFieldNum;
}

#pragma mark - displayPinsOnMap

-(void)displayPinsMapView{
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    for (ListaReporteEstado *reporte in _stateReportData) {
        
        CLLocationCoordinate2D annotationCoord;
        
        annotationCoord.latitude = [reporte.estado.longitud doubleValue];
        annotationCoord.longitude = [reporte.estado.latitud doubleValue];
        
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = annotationCoord;
        annotationPoint.title = reporte.estado.nombreEstado;
        annotationPoint.subtitle = [NSString stringWithFormat:@"%@ Obras - $%@ en inversión", reporte.numeroObras, reporte.totalInvertido];
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
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:_popUpTableView];
    
    if (!_popOverView.popoverVisible && _popOverView != nil) {
        _popOverView = nil;
    }
    
    UIButton *button = (UIButton *)sender;

    if (_popOverView == nil ) {
        _popOverView = [[UIPopoverController alloc]initWithContentViewController:nav];
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
        
    }else if (popupListTableView.field == e_Nombre_Inaugura){
        _inauguratorSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreInaugurators];
    }else if (popupListTableView.field == e_Inaugurada){
        _inauguratorOptionSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreInauguradaOption];
    }else if (popupListTableView.field == e_Suscpetible){
        _susceptibleOptionSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreSusceptibleOption];
    }
}

-(void)changeBackgroundColorForNumberOfSelections:(NSArray *)dataField andTypeOfFieldButton:(MainSearchFields)field{
    
    //Si hay datos seleccionados, cambiamos el background del boton para mostrar existen selecciones en el boton
    BOOL changeBackground = dataField.count > 0 ? YES : NO;
    
    UIColor *colorForSelection = changeBackground ? [UIColor colorForButtonSelection] : [UIColor clearColor];
    UIColor *colorForTitleSelection = changeBackground ? [UIColor whiteColor] : [UIColor darkGrayColor];

    
    if (field == e_Dependencia) {
        _btndependency.backgroundColor      = colorForSelection;
        [_btndependency setTitleColor:colorForTitleSelection forState:UIControlStateNormal];
    }else if (field == e_Estado){
        _btnStates.backgroundColor          = colorForSelection;
        [_btnStates setTitleColor:colorForTitleSelection forState:UIControlStateNormal];

    }else if (field == e_Impacto){
        _btnImpact.backgroundColor          = colorForSelection;
        [_btnImpact setTitleColor:colorForTitleSelection forState:UIControlStateNormal];

    }else if (field == e_Clasificacion){
        _btnClasification.backgroundColor   = colorForSelection;
        [_btnClasification setTitleColor:colorForTitleSelection forState:UIControlStateNormal];

    }else if (field == e_Tipo_Inversion){
        _btnTypeInvestment.backgroundColor  = colorForSelection;
        [_btnTypeInvestment setTitleColor:colorForTitleSelection forState:UIControlStateNormal];

    }else if (field == e_Nombre_Inaugura){
        _btnInaugurator.backgroundColor     = colorForSelection;
        [_btnInaugurator setTitleColor:colorForTitleSelection forState:UIControlStateNormal];

    }else if (field == e_Inaugurada){
        _btnInaugurada.backgroundColor     = colorForSelection;
        [_btnInaugurada setTitleColor:colorForTitleSelection forState:UIControlStateNormal];
        
    }else if (field == e_Suscpetible){
        _btnSusceptible.backgroundColor     = colorForSelection;
        [_btnSusceptible setTitleColor:colorForTitleSelection forState:UIControlStateNormal];
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
    
    //SWTableViewCel
    
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - UITableView  Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Obra *obra = _tableViewData[indexPath.row];
    [self performSegueWithIdentifier:@"showFichaTecnica" sender:obra];
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor darkGrayColor]
                                                title:@"Guardar Obra"];
   
    return rightUtilityButtons;
}

#pragma mark - SwipeableTableViewCell

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            [kAppDelegate showActivityIndicator:M13ProgressViewActionNone whithMessage:@"Guardando..." delay:0];
            NSIndexPath *cellIndexPath = [_tableView indexPathForCell:cell];
            
            Obra *obra = _tableViewData[cellIndexPath.row];
            [DBHelper saveObra:obra];
            
            NSString *message = [NSString stringWithFormat:@"Obra guardada\n%@", obra.idObra];
            [kAppDelegate notShowActivityIndicator:M13ProgressViewActionSuccess whithMessage:message delay:1.5];

            break;

        }
        default:
            break;
    }
    
    [cell hideUtilityButtonsAnimated:YES];

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
    
    if (_reportOption == r_state) {
        return _stateReportData.count;
    }else{
        return _dependenciesReportData.count;
    }
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
    //Tamaño para el campo obras
    if (indexPath.row ==1) {
        return 68;
    }else{ //Tamaño para el campo estado/dependencia y inversión
        return 98;
    }
}

- (CGFloat)spreadView:(MDSpreadView *)aSpreadView widthForColumnHeaderInSection:(NSInteger)columnSection{
    //    if (columnSection == 2) return 0; // uncomment to hide this header!
    return 0;
}

#pragma - Cells

- (MDSpreadViewCell *)spreadView:(MDSpreadView *)aSpreadView cellForRowAtIndexPath:(MDIndexPath *)rowPath forColumnAtIndexPath:(MDIndexPath *)columnPath{
    
    
    if (_reportOption == r_state) {
        static NSString *cellIdentifier = @"Cell";
        MDSpreadViewCell *cell = [aSpreadView dequeueReusableCellWithIdentifier:cellIdentifier];

        ListaReporteEstado *reporte = _stateReportData[rowPath.row];
        
        if (cell == nil) {
            cell = [[MDSpreadViewCell alloc] initWithStyle:MDSpreadViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        }
        
        if (columnPath.row == 0) {
            cell.textLabel.text = reporte.estado.nombreEstado;
            
        }else if (columnPath.row == 1){
            cell.textLabel.text = [NSString stringWithFormat:@"%@", reporte.numeroObras];
            
        }else if (columnPath.row == 2){
            
            cell.textLabel.text =  [NSString stringWithFormat:@"%@", [_currencyFormatter stringFromNumber:reporte.totalInvertido]];
        }
        
        return cell;

    
    }else{
        static NSString *cellIdentifier = @"Cell2";
        MDSpreadViewCell *cell = [aSpreadView dequeueReusableCellWithIdentifier:cellIdentifier];

        ListaReporteDependencia *reporte = _dependenciesReportData[rowPath.row];
        
        if (cell == nil) {
            cell = [[MDSpreadViewCell alloc] initWithStyle:MDSpreadViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        }
        
        if (columnPath.row == 0) {
            
            cell.textLabel.text = @"Dependencia";
            
        }else if (columnPath.row == 1){
            cell.textLabel.text = [NSString stringWithFormat:@"%@", reporte.numeroObras];
            
        }else if (columnPath.row == 2){
            
            cell.textLabel.text =  [NSString stringWithFormat:@"%@", [_currencyFormatter stringFromNumber:reporte.totalInvertido]];
        }
        
        return cell;
    }
    
}

- (id)spreadView:(MDSpreadView *)aSpreadView titleForHeaderInRowSection:(NSInteger)section forColumnAtIndexPath:(MDIndexPath *)columnPath
{
    NSDictionary *titleFieldDic = _titleFields[columnPath.row];
    NSString *title = titleFieldDic[@"title"];
    return title;
}

#pragma mark - Sorting


- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForHeaderInRowSection:(NSInteger)section forColumnAtIndexPath:(MDIndexPath *)columnPath
{
    NSDictionary *titleFieldDic = _titleFields[columnPath.row];
    NSString *key = titleFieldDic[@"sortKey"];

    return [MDSortDescriptor sortDescriptorWithKey:key ascending:YES selectsWholeSpreadView:NO];
}

- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForHeaderInColumnSection:(NSInteger)section forRowAtIndexPath:(MDIndexPath *)rowPath
{
    return nil;
}

- (void)spreadView:(MDSpreadView *)aSpreadView sortDescriptorsDidChange:(NSArray *)oldDescriptors
{
    [_stateReportData sortUsingDescriptors:aSpreadView.sortDescriptors];
    [aSpreadView reloadData];
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

#pragma mark - UITextField Delegate


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger MAX_DIGITS = 11; // $999,999,999.99

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    [numberFormatter setMaximumFractionDigits:1];
    [numberFormatter setMinimumFractionDigits:1];
    
    NSString *stringMaybeChanged = [NSString stringWithString:string];
    if (stringMaybeChanged.length > 1)
    {
        NSMutableString *stringPasted = [NSMutableString stringWithString:stringMaybeChanged];
        
        [stringPasted replaceOccurrencesOfString:numberFormatter.currencySymbol
                                      withString:@""
                                         options:NSLiteralSearch
                                           range:NSMakeRange(0, [stringPasted length])];
        
        [stringPasted replaceOccurrencesOfString:numberFormatter.groupingSeparator
                                      withString:@""
                                         options:NSLiteralSearch
                                           range:NSMakeRange(0, [stringPasted length])];
        
        NSDecimalNumber *numberPasted = [NSDecimalNumber decimalNumberWithString:stringPasted];
        stringMaybeChanged = [numberFormatter stringFromNumber:numberPasted];
    }
    
    NSMutableString *textFieldTextStr = [NSMutableString stringWithString:textField.text];
    
    [textFieldTextStr replaceCharactersInRange:range withString:stringMaybeChanged];
    
    [textFieldTextStr replaceOccurrencesOfString:numberFormatter.currencySymbol
                                      withString:@""
                                         options:NSLiteralSearch
                                           range:NSMakeRange(0, [textFieldTextStr length])];
    
    [textFieldTextStr replaceOccurrencesOfString:numberFormatter.groupingSeparator
                                      withString:@""
                                         options:NSLiteralSearch
                                           range:NSMakeRange(0, [textFieldTextStr length])];
    
    [textFieldTextStr replaceOccurrencesOfString:numberFormatter.decimalSeparator
                                      withString:@""
                                         options:NSLiteralSearch
                                           range:NSMakeRange(0, [textFieldTextStr length])];
    
    if (textFieldTextStr.length <= MAX_DIGITS)
    {
        NSDecimalNumber *textFieldTextNum = [NSDecimalNumber decimalNumberWithString:textFieldTextStr];
        NSDecimalNumber *divideByNum = [[[NSDecimalNumber alloc] initWithInt:10] decimalNumberByRaisingToPower:numberFormatter.maximumFractionDigits];
        NSDecimalNumber *textFieldTextNewNum = [textFieldTextNum decimalNumberByDividingBy:divideByNum];
        NSString *textFieldTextNewStr = [numberFormatter stringFromNumber:textFieldTextNewNum];
        
        textField.text = textFieldTextNewStr;

    }

    return NO;

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


#pragma mark - Segue

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showFichaTecnica"]) {
        FichaTecnicaViewController *fichaTecnicaViewController = segue.destinationViewController;
        fichaTecnicaViewController.obra = (Obra *)sender;
        
    }else
        if ([segue.identifier isEqualToString:@"showGrafica"]) {
            GraficasViewController *graficasViewController = segue.destinationViewController;
            graficasViewController.stateReportData = _stateReportData;
            
#warning La lista de reporte de dependencias no tiene el atributo de los nombres sustituir reporteDependenciaarr por _dependenciesReportData
            ListaReporteDependencia *reporteDependencia = [[ListaReporteDependencia alloc] init];
            Dependencia *dependencia = [Dependencia new];
            dependencia.nombreDependencia = @"CFE";
            dependencia.idDependencia = @"1";
            reporteDependencia.dependencia =dependencia;
            reporteDependencia.totalInvertido = @"100";
            reporteDependencia.numeroObras = @"50";
            
            NSMutableArray *reporteDependenciaarr = [NSMutableArray new];
            [reporteDependenciaarr addObject:reporteDependencia];
            
            graficasViewController.dependenciesReportData = reporteDependenciaarr;
        }
}


-(void)showFichaTecnica:(NSNotification *)notification{
    [_popOverView dismissPopoverAnimated:YES];

    Obra *obra = [notification object];
    [self performSegueWithIdentifier:@"showFichaTecnica" sender:obra];
}


@end
