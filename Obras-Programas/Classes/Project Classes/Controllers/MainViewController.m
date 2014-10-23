
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
#import "Programa.h"
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
#import "MZFormSheetController.h"
#import "ConsultasGuardadasTableViewController.h"
#import "SDWebImageManager.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

#define METERS_PER_MILE 1609.344

@interface MainViewController () <MDSpreadViewDataSource, MDSpreadViewDelegate>

#pragma mark - IBOutLets

/* PopMenu */

@property (nonatomic, strong) QBPopupMenu *popupMenu;
@property (nonatomic, strong) QBPopupMenu *morePopupMenu;

/* IBOutlets*/

@property (weak, nonatomic) IBOutlet UITextField *txtRangoMinimo;
@property (weak, nonatomic) IBOutlet UITextField *txtRangoMaximo;
@property (weak, nonatomic) IBOutlet UITextField *txtDenominacion;
@property (weak, nonatomic) IBOutlet UITextField *txtIDObraPrograma;

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
@property (weak, nonatomic) IBOutlet UIButton *btnSortSearch;

@property (weak, nonatomic) IBOutlet UILabel *lblStartIniDate;
@property (weak, nonatomic) IBOutlet UILabel *lblStartEndDate;

@property (weak, nonatomic) IBOutlet UILabel *lblEndIniDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndEndDate;
@property (weak, nonatomic) IBOutlet UILabel *lblLista;
@property (weak, nonatomic) IBOutlet UILabel *lblReporte;

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
@property (nonatomic, strong) ListaReporteGeneral *general;

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
@property (nonatomic, strong) MNMBottomPullToRefreshManager *pullToRefreshManager;
@property (nonatomic, strong) NSNumberFormatter *currencyFormatter;
@property ReportOption reportOption;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property int numTotalPages;
@property int numCurrentPage;
@property BOOL isFromMainQuery;
@property BOOL isProgramsSelected;
@property BOOL isPrograms;
@property BOOL isProgramsNotification;

@end

@implementation MainViewController

#pragma mark - View Life cycle

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    [_pullToRefreshManager relocatePullToRefreshView];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /* Setting up Views */
    [self setupUI];
    [self initializeData];

    /* Hide TableView */
    [self hideSearchList:nil];
    [self hideReporteView:nil];
    /* Load Saved Selections */
    [self loadSelections];
    [self changeAllBackgrounds];
}

#pragma mark - Initialize

-(void)initializeData{
    
    [TSMessage setDefaultViewController:self];
    _pullToRefreshManager = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f tableView:_tableView withClient:self];
    
    /*  Menu items */
    
    _menuData       = @[@"Consultas guardadas", @"Registros guardados", @"Acerca de"];
    
    _titleFields    = @[@{@"title": @"Estado",     @"sortKey": @"estado.nombreEstado"},
                        @{@"title": @"Obras",      @"sortKey": @"numeroObras"},
                        @{@"title": @"Inversión",  @"sortKey": @"totalInvertido"}];
    ;
    
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
#ifdef __IPHONE_8_0
    NSUInteger code = [CLLocationManager authorizationStatus];
    if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
        // choose one request according to your business.
        if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
            [self.locationManager requestAlwaysAuthorization];
        } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
            [self.locationManager  requestWhenInUseAuthorization];
        } else {
            NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
        }
    }
#endif
    [self.locationManager startUpdatingLocation];
    
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
    popupMenu.color = [UIColor darkGrayColor];
    popupMenu.highlightedColor = [[UIColor colorWithRed:0 green:0.478 blue:1.0 alpha:1.0] colorWithAlphaComponent:0.8];
    self.popupMenu = popupMenu;
    
    QBPopupMenuItem *item10 = [QBPopupMenuItem itemWithTitle:@"Limpiar consulta" target:self action:@selector(cleanQueryAndHideHUD:)];
    QBPopupMenuItem *item11 = [QBPopupMenuItem itemWithTitle:@"Ver detalle consulta" target:self action:@selector(displayQueryDetail:)];
    
    NSArray *itemsMoreButton = @[item10, item11];
    
    self.morePopupMenu = [[QBPopupMenu alloc] initWithItems:itemsMoreButton];
    self.morePopupMenu.color = [UIColor darkGrayColor];
    self.morePopupMenu.highlightedColor = [[UIColor colorWithRed:0 green:0.478 blue:1.0 alpha:1.0] colorWithAlphaComponent:0.8];
    
    
    /* Date Formatters */
    
    _dateFormatterShort = [[NSDateFormatter alloc]init];
    [_dateFormatterShort setDateFormat:@"dd/MM/yy"];
    
    _dateFormatterGeneral = [[NSDateFormatter alloc]init];
    [_dateFormatterGeneral setDateFormat:@"yyyy-MM-dd"];

}

-(void)initializeCalendar{
    
    self.pmCC = [[PMCalendarController alloc] initWithThemeName:@"default"];
    self.pmCC.delegate = self;
    self.pmCC.allowsPeriodSelection = NO;
    self.pmCC.mondayFirstDayOfWeek = NO;
    self.pmCC.period = [PMPeriod oneDayPeriodWithDate:[NSDate date]];
    [self calendarController:self.pmCC didChangePeriod:self.pmCC.period];
}


-(void)loadSelections{
    
    _dependenciesSavedData      = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreDependencies];
    _statesSavedData            = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreStates];
    _impactsSavedData           = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreImpact];
    _clasificationsSavedData    = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreClasification];
    _invesmentsSavedData        = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreInvesments];
    _worksProgramsSavedData     = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreTypeWorkOrProgram];
    _inauguratorSavedData       = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreInaugurators];
    _fechaInicio                = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreStartIniDate];
    _lblStartIniDate.text       = [_dateFormatterShort stringFromDate:_fechaInicio];
    _fechaInicioSegunda         = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreStartEndDate];
    _lblStartEndDate.text       = [_dateFormatterShort stringFromDate:_fechaInicioSegunda];
    _fechaFin                   = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreEndIniDate];
    _lblEndIniDate.text         = [_dateFormatterShort stringFromDate:_fechaFin];
    _fechaFinSegunda            = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreEndEndDate];
    _lblEndEndDate.text         = [_dateFormatterShort stringFromDate:_fechaFinSegunda];
    _inauguratorOptionSavedData = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreInauguradaOption];
    _susceptibleOptionSavedData = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreSusceptibleOption];
}

-(void)changeAllBackgrounds{
    
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
    [super viewDidAppear:NO];
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


-(void)changeTitleNavigationBar:(NSString *)title{
    
    CGFloat largestLabelWidth = 0;
    UIFont *font = [UIFont systemFontOfSize:17];
    
    CGSize labelSize = [title sizeWithAttributes:
                        @{NSFontAttributeName:
                              font}];
    
    if (labelSize.width > largestLabelWidth) {
        largestLabelWidth = labelSize.width;
    }
    
    _btnWorksPrograms = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btnWorksPrograms addTarget:self action:@selector(displayTypesOfProgramasWorks) forControlEvents:UIControlEventTouchUpInside];
    _btnWorksPrograms.frame = CGRectMake(0, 0, largestLabelWidth, 44);
    _btnWorksPrograms.tintColor = [UIColor darkGrayColor];
    _btnWorksPrograms.titleLabel.font = font;
    //Imagen
    [_btnWorksPrograms setImage:[UIImage imageNamed:@"arrowDown"] forState:UIControlStateNormal];
    [_btnWorksPrograms setImageEdgeInsets:UIEdgeInsetsMake(0, largestLabelWidth+20, 3, -100)];
    [_btnWorksPrograms setTitle:title forState:UIControlStateNormal];
    
    self.navigationItem.titleView = _btnWorksPrograms;
}

-(void)setupUI{
    
    [self changeTitleNavigationBar:@"SELECCIONA UN TIPO"];
 
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
    
    if ([client.servletName isEqualToString:kServletBuscar]) {
        if (_isFromMainQuery) {
        } [kAppDelegate notShowActivityIndicator:M13ProgressViewActionFailure whithMessage:@"Se ha perdido\nla conexión" delay:2.6];
    
        [_pullToRefreshManager tableViewReloadFinished];
    }

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
    
    NSArray *sort = @[@"Nombre (Ascendente)", @"Nombre (Descendente)", @"Estado (Ascendente)", @"Estado (Descendente)"];
    
    [self displayItemsOnButton:_btnSortSearch
                withDataSource:sort
        withDataToShowCheckBox:nil
               isBarButtonItem:NO
                        isMenu:NO
                   searchField:e_Sort_Result];
 
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

-(void)displayQueryDetail:(id)sender{
    
    ConsultasGuardadasTableViewController *consultasGuardasViewController  = [[ConsultasGuardadasTableViewController alloc]initWithStyle:UITableViewStylePlain];
    consultasGuardasViewController.consulta = [self initializeConsulta];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:consultasGuardasViewController];
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:nav];
    formSheet.presentedFormSheetSize = CGSizeMake(500, 500);
    formSheet.shadowRadius = 2.0;
    formSheet.shadowOpacity = 0.3;
    formSheet.cornerRadius = 15.0;
    formSheet.shouldDismissOnBackgroundViewTap = YES;
    formSheet.shouldCenterVertically = YES;
    formSheet.movementWhenKeyboardAppears = MZFormSheetWhenKeyboardAppearsCenterVertically;
    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {};
    formSheet.transitionStyle = MZFormSheetTransitionStyleDropDown;
    [self mz_presentFormSheetController:formSheet animated:YES completionHandler:nil];
}

#pragma mark - Clean Parameters

-(void)cleanQueryAndHideHUD:(BOOL)option{
    
    /* Load Saved Selections */
    
    if (!option) {
       [kAppDelegate showActivityIndicator:M13ProgressViewActionNone whithMessage:kHUDMsgLoading delay:0];
    }
    
    [self savedDataForSelections:[NSArray array] andTypeOfFieldButton:e_Dependencia];
    [self savedDataForSelections:[NSArray array] andTypeOfFieldButton:e_Estado];
    [self savedDataForSelections:[NSArray array] andTypeOfFieldButton:e_Impacto];
    [self savedDataForSelections:[NSArray array] andTypeOfFieldButton:e_Clasificacion];
    [self savedDataForSelections:[NSArray array] andTypeOfFieldButton:e_Tipo_Inversion];
    [self savedDataForSelections:[NSArray array] andTypeOfFieldButton:e_Nombre_Inaugura];
    [self savedDataForSelections:[NSArray array] andTypeOfFieldButton:e_Inaugurada];
    [self savedDataForSelections:[NSArray array] andTypeOfFieldButton:e_Suscpetible];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyStoreStartIniDate];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyStoreStartEndDate];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyStoreEndIniDate];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyStoreEndEndDate];


    _lblStartIniDate.text = @"";
    _lblStartEndDate.text = @"";
    _lblEndIniDate.text   = @"";
    _lblEndEndDate.text   = @"";
    self.txtRangoMaximo.text    = @"";
    self.txtRangoMinimo.text    = @"";
    self.txtDenominacion.text   = @"";
    self.txtIDObraPrograma.text = @"";

    _numCurrentPage = 0;
    _numTotalPages = 0;
    
    [self changeAllBackgrounds];
    
    if (!option) {
        [kAppDelegate notShowActivityIndicator:M13ProgressViewActionSuccess whithMessage:@"Se han limpiado\nlos campos de\nbúsqueda" delay:1.5];
    }
}

-(void)cleandDataForTableViewAndReport{
    
    _tableViewData = [NSMutableArray array];
    _stateReportData        =  [NSMutableArray array];
    _dependenciesReportData = [NSMutableArray array];
    _general = nil;
    [_tableView reloadData];
    [_pullToRefreshManager tableViewReloadFinished];
    [self displayPinsMapView];
    [_spreadView reloadData];
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


-(void)deleteStartDate:(id)sender{
    
    if (_btnCalendarSelected == _btnStartDate) {
        _lblStartIniDate.text = @"";
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyStoreStartIniDate];

    }else if (_btnCalendarSelected == _btnEndDate){
        _lblEndIniDate.text = @"";
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyStoreEndIniDate];
    }
}

-(void)deleteEndDate:(id)sender{
    if (_btnCalendarSelected == _btnStartDate) {
        _lblStartEndDate.text = @"";
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyStoreStartEndDate];

    }else if (_btnCalendarSelected == _btnEndDate){
        _lblEndEndDate.text = @"";
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyStoreEndEndDate];
    }
}

#pragma mark PMCalendarControllerDelegate methods

- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
{
    NSString *dateCalendar = [_dateFormatterShort stringFromDate:newPeriod.startDate];
    _lblCalendarSelected.text = dateCalendar;

    if (_lblCalendarSelected == _lblStartIniDate) {
        
        if (_lblStartIniDate.text.length==0) {
            _fechaInicioSegunda = newPeriod.startDate;
            _lblStartEndDate.text = dateCalendar;
            [[NSUserDefaults standardUserDefaults]rm_setCustomObject:_fechaInicioSegunda forKey:kKeyStoreStartEndDate];
        }
        _fechaInicio = newPeriod.startDate;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:_fechaInicio forKey:kKeyStoreStartIniDate];
        
    }else if (_lblCalendarSelected == _lblStartEndDate) {
        _fechaInicioSegunda = newPeriod.startDate;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:_fechaInicioSegunda forKey:kKeyStoreStartEndDate];

    }else if (_lblCalendarSelected == _lblEndIniDate) {
        _fechaFin = newPeriod.startDate;

        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:_fechaFin forKey:kKeyStoreEndIniDate];

        if (_lblEndIniDate.text.length==0) {
            _fechaFinSegunda = newPeriod.startDate;
            _lblEndEndDate.text = dateCalendar;
            [[NSUserDefaults standardUserDefaults]rm_setCustomObject:_fechaFinSegunda forKey:kKeyStoreEndEndDate];

        }
        
        //        NSComparisonResult result = [_fechaInicio compare:newPeriod.startDate];
        //
        //        if (result != NSOrderedAscending) {
        //            [[[UIAlertView alloc]initWithTitle:@"Fecha incorrecta" message:@"La fecha de termino no puede ser menor a la fecha de comienzo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil] show];
        //            return;
        //        }
        
    }else if (_lblCalendarSelected == _lblEndEndDate) {
        _fechaFinSegunda = newPeriod.startDate;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:_fechaFinSegunda forKey:kKeyStoreEndEndDate];

    }
}


#pragma mark - *************  REQUEST TO SERVER MAIN QUERY

/* Realizar consulta */

- (IBAction)performQuery:(id)sender {
    
    _numTotalPages = 0;
    _numCurrentPage = 0;
    _isFromMainQuery = YES;
    _isPrograms = _isProgramsSelected ? YES : NO;
    _tableViewData = [NSMutableArray array];
    [self perfomQueryWithParameters];
}

const int numResultsPerPage = 200;

-(void)perfomQueryWithParameters{
    
    NSMutableDictionary *parameters = [self buildServletParameters];
    //int limiteMin = _numCurrentPage * numResultsPerPage;
    [parameters setObject:[NSString stringWithFormat:@"%d", numResultsPerPage] forKey:kParamLimiteMax];
    [parameters setObject:[NSString stringWithFormat:@"%d", _numCurrentPage * numResultsPerPage]  forKey:kParamLimiteMin];
    if (_isFromMainQuery)[kAppDelegate showActivityIndicator:M13ProgressViewActionNone whithMessage:kHUDMsgLoading delay:0];
    [_jsonClient performPOSTRequestWithParameters:parameters toServlet:kServletBuscar withOptions:@"obras"];
    
    [_searchBar resignFirstResponder];
    [self.txtRangoMaximo resignFirstResponder];
    [self.txtRangoMinimo resignFirstResponder];
    [self.txtDenominacion resignFirstResponder];
    [self.txtIDObraPrograma resignFirstResponder];
    _searchBar.text = @"";
}

#pragma mark - Resultado Busquedas

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseSearchWorks:(id)response{
    
    NSDictionary *objectsResponse = response;
    
    NSArray *results = objectsResponse[kKeyListaObras];
    
    [_tableViewData addObjectsFromArray:results];
    _stateReportData        = objectsResponse[kKeyListaReporteEstado];
    _dependenciesReportData = objectsResponse[kKeyListaReporteDependencia];
    NSArray *generalData    = objectsResponse[kKeyListaReporteGeneral];
    
    [_tableView reloadData];
    [_pullToRefreshManager tableViewReloadFinished];

    NSLog(@"%lu", (unsigned long)_tableViewData.count);
    
    /* Animaciones para el TableView */
    if (_tableView.isHidden) {
        _lblLista.text = @"Ocultar lista";
        _tableView.hidden = NO;
        _transition.subtype = kCATransitionFromLeft;
        [_tableView.layer addAnimation:_transition forKey:nil];
    }
    
    /* Animaciones para el Report View */
    
    if (_reportView.isHidden) {
        _lblReporte.text = @"Ocultar reporte";
        _reportView.hidden = NO;
        _transition.subtype = kCATransitionFromRight;
        [_reportView.layer addAnimation:_transition forKey:nil];
    }
    
    /* Muestra los pines en el mapa */
    
    NSString *numObras = @"0";

    if (generalData.count > 0) {
        _general = generalData[0];
        numObras = [NSString stringWithFormat:@"%@", _general.numeroObras];
        _numTotalPages = ceil([numObras floatValue]/numResultsPerPage);
    }
    
    if (_tableViewData.count>0) {
        if (_isFromMainQuery) {
            NSString *mesage = [NSString stringWithFormat:@"%@ resultados\nencontrados", numObras];
            [kAppDelegate notShowActivityIndicator:M13ProgressViewActionSuccess whithMessage:mesage delay:2.0];
        }
    }else{
        [kAppDelegate notShowActivityIndicator:M13ProgressViewActionNone whithMessage:@"Sin resultados" delay:1.0];
    }
    
    if (_isFromMainQuery) {
        [self displayPinsMapView];
        _spreadView.delegate = self;
        _spreadView.dataSource = self;
        [_spreadView reloadData];
    }
}

#pragma mark -
#pragma mark MNMBottomPullToRefreshManagerClient


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pullToRefreshManager tableViewScrolled];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_pullToRefreshManager tableViewReleased];
}

- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager {
    
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:1.0f];
}

- (void)loadTable {
    _numCurrentPage ++;
    if (_numCurrentPage < _numTotalPages) {
        _isFromMainQuery = NO;
        [self perfomQueryWithParameters];
    }else{
        [_pullToRefreshManager tableViewReloadFinished];
    }
}

#pragma mark - Guardar Consulta

/* Guardar Consulta */

- (IBAction)performSaveQuery:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Guardar consulta"
                                                   message:@"Pro favor ingresa el nombre de la consulta"
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
        
        UITextField *textfield =  [alertView textFieldAtIndex: 0];
        NSString *queryName = textfield.text;
        Consulta *consulta = [self initializeConsulta];
        
        if (queryName.length == 0){
            consulta.nombreConsulta = @"Sin Nombre";
        }else{
            consulta.nombreConsulta = queryName;
        }
        [DBHelper saveConsulta:consulta];

    }
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

-(Consulta *)initializeConsulta{
    
    Consulta *consulta = [[Consulta alloc]init];
    
    //Dependencia
    if (_dependenciesSavedData.count>0)
        consulta.dependenciasData = _dependenciesSavedData;
    //Estado
    if (_statesSavedData.count>0)
        consulta.estadosData = _statesSavedData;
    //Tipo de inversión
    if (_invesmentsSavedData.count>0)
        consulta.tipoDeInversionesData = _invesmentsSavedData;
    //Impactos
    if (_impactsSavedData.count>0)
        consulta.impactosData = _impactsSavedData;
    //Clasificaciones
    if (_clasificationsSavedData.count>0)
        consulta.clasificacionesData = _clasificationsSavedData;
    //Inaugurador
    if (_inauguratorSavedData.count>0)
        consulta.inauguradoresData = _inauguratorSavedData;

    return consulta;
}

#pragma mark - Servlet Parameters

-(NSMutableDictionary *)buildServletParameters{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *parameterValue = @"";
    
    /* Tipo de Obra */
    
    if (_worksProgramsSavedData.count > 0) {
        
        for (int i=0; i<[_worksProgramsSavedData count]; i++) {
            TipoObraPrograma *tipObra = _worksProgramsSavedData[i];
            if (![tipObra.nombreTipoObra isEqualToString:@"PROGRAMAS"]) {
                parameterValue = [parameterValue stringByAppendingString:tipObra.idTipoObra];
                if (i!=_worksProgramsSavedData.count-1) {
                    parameterValue = [parameterValue stringByAppendingString:@","];
                }
            }
            
        }
        
        if (!_isProgramsSelected) {
            [parameters setObject:parameterValue forKey:kParamTipoDeObra];
        }else{
            [parameters setObject:@"1" forKey:@"consultaProgramas"];
            
        }
    }
    
    if (_searchBar.text.length > 0) {
        [parameters setObject:_searchBar.text forKey:kParamBusquedaRapida];

    }else{
        if (self.txtDenominacion.text.length>0) {
            if (_isProgramsSelected) {
                [parameters setObject:self.txtDenominacion.text forKey:@"nombrePrograma"];
            }else{
                [parameters setObject:self.txtDenominacion.text forKey:kParamDenominacion];
            }
        }
        
        if (self.txtIDObraPrograma.text.length>0) {
            if (_isProgramsSelected) {
                [parameters setObject:self.txtIDObraPrograma.text forKey:kParamIdPrograma];
            }else{
                [parameters setObject:self.txtIDObraPrograma.text forKey:kParamIdObra];
            }

        }
        
        
        /* Depedencias */
        parameterValue = @"";
        
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
        
        /* Inagurada */
        
        parameterValue = @"";
        
        if (_inauguratorOptionSavedData.count > 0) {
            
            for (int i=0; i<[_inauguratorOptionSavedData count]; i++) {
                NSString *value = _inauguratorOptionSavedData[i];
                if ([value isEqualToString:@"Si"]) {
                    value = @"1";
                }else if ([value isEqualToString:@"No"]){
                    value = @"0";
                }
                parameterValue = [parameterValue stringByAppendingString:value];
                if (i!=_inauguratorOptionSavedData.count-1) {
                    parameterValue = [parameterValue stringByAppendingString:@","];
                }
            }
            [parameters setObject:parameterValue forKey:kParamInaugurada];
        }
        
        /* Inagurada */
        
        parameterValue = @"";
        
        if (_susceptibleOptionSavedData.count > 0) {
            
            for (int i=0; i<[_susceptibleOptionSavedData count]; i++) {
                NSString *value = _susceptibleOptionSavedData[i];
                if ([value isEqualToString:@"Si"]) {
                    value = @"1";
                }else if ([value isEqualToString:@"No"]){
                    value = @"0";
                }
                parameterValue = [parameterValue stringByAppendingString:value];
                if (i!=_susceptibleOptionSavedData.count-1) {
                    parameterValue = [parameterValue stringByAppendingString:@","];
                }
            }
            [parameters setObject:parameterValue forKey:kParamSusceptible];
        }

    }
    
    
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
        }else if(aSearchField == e_Tipo || aSearchField == e_Sort_Result){
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
    if (popupListTableView.field == e_Tipo) { [self setupTitle:data]; }
    [self savedDataForSelections:data andTypeOfFieldButton:popupListTableView.field];
}

-(void)setupTitle:(NSArray *)data {
    _isProgramsSelected = NO;
    
    //Guardamos los datos para hacer la busqeuda por obras o programas
    
    if (data.count== 0) {
        [self changeTitleNavigationBar:@"OBRAS TOTALES"];
        if ((_tableViewData.count > 0 && _isPrograms) || _isProgramsSelected) {
            [self cleandDataForTableViewAndReport];
            [self cleanQueryAndHideHUD:YES];
                 }
    }else if (data.count == 1){
        TipoObraPrograma *tipo = data[0];
        [self changeTitleNavigationBar:tipo.nombreTipoObra];
        if ([tipo.nombreTipoObra isEqualToString:@"PROGRAMAS"]) {
            //Habilitamos la busqueda para programas
            _isProgramsSelected = YES;
            //Limpiamos las busquedas
            
            //Limpiamos datos
            if ((_tableViewData.count > 0 && !_isPrograms) || !_isProgramsSelected) {
                [self cleandDataForTableViewAndReport];
                [self cleanQueryAndHideHUD:YES];

            }
        }else {
            if ((_tableViewData.count > 0 && _isPrograms) || _isProgramsSelected) {
                [self cleandDataForTableViewAndReport];
                [self cleanQueryAndHideHUD:YES];
            }
        }
    }else{
        [self changeTitleNavigationBar:@"OBRAS"];
        //Limpiamos datos
        if ((_tableViewData.count > 0 && _isPrograms) || _isProgramsSelected) {
            
//            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tu consulta se limpiara"
//                                                           message:@"Para buscar Obras es necesario limpiar la búsqueda de programas. ¿Deseas guardarla?"
//                                                          delegate:nil
//                                                 cancelButtonTitle:@"Guardar"
//                                                 otherButtonTitles:@"Omitir", nil];
//            
//            [alert show];
//
//            
//            
            [self cleandDataForTableViewAndReport];
            [self cleanQueryAndHideHUD:YES];

        }
    }
    
    [self disableOrEnableButtonsDependOnTypeSearch];
}

-(void)savedDataForSelections:(NSArray *)data andTypeOfFieldButton:(MainSearchFields)field{
    
    if (field == e_Dependencia) {
        _dependenciesSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreDependencies];
    }else if (field == e_Estado){
        _statesSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreStates];
    }else if (field == e_Impacto){
        _impactsSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreImpact];
    
    }else if (field == e_Clasificacion){
        _clasificationsSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreClasification];
        
    }else if (field == e_Tipo_Inversion){
        _invesmentsSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreInvesments];
        
    }else if (field == e_Nombre_Inaugura){
        _inauguratorSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreInaugurators];
    }else if (field == e_Inaugurada){
        _inauguratorOptionSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreInauguradaOption];
    }else if (field == e_Suscpetible){
        _susceptibleOptionSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreSusceptibleOption];
    }else if (field == e_Tipo){
        _worksProgramsSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreTypeWorkOrProgram];
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


-(void)disableOrEnableButtonsDependOnTypeSearch{
    
    if (_isProgramsSelected) {
        _btnStartDate.enabled = NO;
        _btnEndDate.enabled = NO;
        _btnInaugurated.enabled = NO;
        _btnInaugurator.enabled = NO;
        _btnSusceptible.enabled = NO;
        _btnImpact.enabled = NO;
    }else{
        _btnStartDate.enabled = YES;
        _btnEndDate.enabled = YES;
        _btnInaugurated.enabled = YES;
        _btnInaugurator.enabled = YES;
        _btnSusceptible.enabled = YES;
        _btnImpact.enabled = YES;

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
    
    if (_isPrograms) {
        Programa *programa = _tableViewData[indexPath.row];
        
        static NSString *CellIdentifier = @"Cell";
        
        ObraProgramaCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.lblDenominacion.text   = programa.nombrePrograma;
        cell.lblIdObraPrograma.text = programa.idPrograma;
        cell.lblEstado.text         = programa.estado.nombreEstado;
        [cell.logoImageView setImageWithURL:programa.dependencia.imagenDependencia placeholderImage:[UIImage imageNamed:kImageNamePlaceHolder] options:SDWebImageRefreshCached usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //SWTableViewCel
        
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
        cell.backgroundColor = [UIColor clearColor];
        return cell;

    }else{
        Obra *obra = _tableViewData[indexPath.row];
        
        static NSString *CellIdentifier = @"Cell";
        
        ObraProgramaCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.lblDenominacion.text   = obra.denominacion;
        cell.lblIdObraPrograma.text = obra.idObra;
        cell.lblEstado.text         = obra.estado.nombreEstado;
        [cell.logoImageView setImageWithURL:obra.dependencia.imagenDependencia placeholderImage:[UIImage imageNamed:kImageNamePlaceHolder] options:SDWebImageRefreshCached usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //SWTableViewCel
        
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
        cell.backgroundColor = [UIColor clearColor];
        return cell;

    }
}

#pragma mark - UITableView  Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id registro = _tableViewData[indexPath.row];
    [self performSegueWithIdentifier:@"showFichaTecnica" sender:registro];
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor darkGrayColor]
                                                title:@"Guardar"];
   
    return rightUtilityButtons;
}

#pragma mark - SwipeableTableViewCell

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            [kAppDelegate showActivityIndicator:M13ProgressViewActionNone whithMessage:@"Guardando..." delay:0];
            NSIndexPath *cellIndexPath = [_tableView indexPathForCell:cell];
            NSString *message = @"";
            if (_isProgramsSelected) {
                Programa *programa = _tableViewData[cellIndexPath.row];
                [DBHelper savePrograma:programa];
                message = [NSString stringWithFormat:@"Programa guardado\n%@", programa.idPrograma];
            }else{
                Obra *obra = _tableViewData[cellIndexPath.row];
                [DBHelper saveObra:obra];
                message = [NSString stringWithFormat:@"Obra guardada\n%@", obra.idObra];
            }
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

- (CGFloat)spreadView:(MDSpreadView *)aSpreadView heightForRowFooterInSection:(NSInteger)rowSection
{
    //    if (rowSection == 0 || rowSection == 2) return 0; // uncomment to hide this header!
    return 45;
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
            cell.textLabel.text = reporte.dependencia.nombreDependencia;
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

- (id)spreadView:(MDSpreadView *)aSpreadView titleForFooterInRowSection:(NSInteger)section forColumnAtIndexPath:(MDIndexPath *)columnPath
{
    if (columnPath.row == 0) {
        return @"Total";
    }else if (columnPath.row == 1){
        
        if (_general.numeroObras == nil) {
            return @"";
        }else{
            return [NSString stringWithFormat:@"%@", _general.numeroObras];

        }
    }else {
        if (_general.totalInvertido == nil) {
            return @"";
        }else{
            return [NSString stringWithFormat:@"%@", [_currencyFormatter stringFromNumber:_general.totalInvertido]];
        }
    }
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
    
    [self performQuery:nil];
    [_searchBar setShowsCancelButton:NO animated:YES];
    _searchBar.text = @"";
    [_searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        [_searchBar resignFirstResponder];

    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    if (searchBar.text.length==0) {
        [_searchBar resignFirstResponder];
    }
}

#pragma mark - UITextField Delegate


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger MAX_DIGITS = 11; // $999,999,999.99

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    
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
        _lblLista.text = @"Ocultar lista";
        _transition.subtype = kCATransitionFromLeft;
        
    }else{
        _tableView.hidden = YES;
        _lblLista.text = @"Mostrar lista";
        _transition.subtype = kCATransitionFromRight;
    }
    /* Add animation */
    [_tableView.layer addAnimation:_transition forKey:nil];
}

- (IBAction)hideReporteView:(id)sender {
    
    /* When de user press the button if the list is hidden the list is displayed */
    
    if ([_reportView isHidden]) {
        _reportView.hidden = NO;
        _lblReporte.text = @"Ocultar reporte";

        _transition.subtype = kCATransitionFromRight;
        
    }else{
        _reportView.hidden = YES;
        _lblReporte.text = @"Mostrar reporte";

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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (_stateReportData.count ==0) {
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"No puedes visualizar la gráfica"
                                                         message:@"Para consultar la gráfica necesitas realizar un consulta que tenga resultados"
                                                        delegate:nil
                                               cancelButtonTitle:@"Aceptar"
                                               otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    else return YES;
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (_isPrograms || _isProgramsNotification) {
       Programa *programa =  (Programa *)sender;
        if ([segue.identifier isEqualToString:@"showFichaTecnica"]) {
            FichaTecnicaViewController *fichaTecnicaViewController = segue.destinationViewController;
            fichaTecnicaViewController.programa = programa;
            fichaTecnicaViewController.inversionesData = _invesmentsData;
            fichaTecnicaViewController.clasificacionesData = _clasificationsData;
        }
    }else{
        if ([segue.identifier isEqualToString:@"showFichaTecnica"]) {
        FichaTecnicaViewController *fichaTecnicaViewController = segue.destinationViewController;
        fichaTecnicaViewController.obra = (Obra *)sender;
        fichaTecnicaViewController.inversionesData = _invesmentsData;
        fichaTecnicaViewController.clasificacionesData = _clasificationsData;
        }
    }
    
    if ([segue.identifier isEqualToString:@"showGrafica"]) {
            GraficasViewController *graficasViewController = segue.destinationViewController;
            graficasViewController.stateReportData = _stateReportData;
            graficasViewController.dependenciesReportData = _dependenciesReportData;

        
    }
}

-(void)showFichaTecnica:(NSNotification *)notification{
   
    id obra = [notification object];
    
    if ([obra isKindOfClass:[Programa class]]) {
        _isProgramsNotification = YES;
    }else if ([obra isKindOfClass:[Obra class]]){
        _isProgramsNotification = NO;
    }
    
    [self performSegueWithIdentifier:@"showFichaTecnica" sender:obra];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
