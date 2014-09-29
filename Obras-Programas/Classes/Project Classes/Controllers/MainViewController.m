
// Programador: Abdiel Soto, Pedro Contreras
// Origen: Edicomex
// Fecha inicio: Septiemnre 2014
// Fecha ultima modificación: 23/08/2014
// Descripción:
// Dependencias:

#import "MainViewController.h"
#import "NSUserDefaults+RMSaveCustomObject.h"

@import MapKit.MKMapView;

@interface MainViewController ()

/* IBOutLets */

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *buttonsView;


@property (weak, nonatomic) IBOutlet UIButton *btnQuery;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveQuery;
@property (weak, nonatomic) IBOutlet UIButton *btndependency;
@property (weak, nonatomic) IBOutlet UIButton *btnStates;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;
@property (weak, nonatomic) IBOutlet UIButton *btnImpact;
@property (weak, nonatomic) IBOutlet UIButton *btnClasification;
@property (weak, nonatomic) IBOutlet UIButton *btnInaugurated;

@property (strong, nonatomic) UIBarButtonItem *menuBarBtn;

/* PopUp List*/

@property (nonatomic, strong) PopupListTableViewController *popUpTableView;
@property (nonatomic, strong) UIPopoverController *popOverView;

/* SearchBar */

@property (nonatomic, strong) UISearchBar *searchBar;

/* Data */

@property (nonatomic, strong) NSArray *menuData;
@property (nonatomic, strong) NSArray *dependencyData;
@property (nonatomic, strong) NSArray *statesData;
@property (nonatomic, strong) NSArray *impactsData;
@property (nonatomic, strong) NSArray *inauguratorData;
@property (nonatomic, strong) NSArray *clasificationsData;


/* Data Saved For Selecctions */

@property (nonatomic, strong) NSArray *dependenciesSavedData;
@property (nonatomic, strong) NSArray *statesSavedData;
@property (nonatomic, strong) NSArray *impactsSavedData;
@property (nonatomic, strong) NSArray *inauguratorSavedData;
@property (nonatomic, strong) NSArray *clasificationsSavedData;

/* Animations */

@property (nonatomic, strong) CATransition *transition;

/* General  */

@property (nonatomic, assign) MainSearchFields searchField;
@property (nonatomic, strong) JSONHTTPClient *jsonClient;

@end

@implementation MainViewController

#pragma mark - View Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    
    [TSMessage setDefaultViewController:self];
    /*  Menu items */
    
    _menuData       = @[@"Busquedas recientes", @"Favoritos", @"Acerca de"];
    _dependencyData = @[@"SEGOB", @"SEP", @"PEMEX", @"SCT", @"CFE", @"SECTUR"];
    
    /* Saved Selections */
    
    _dependenciesSavedData = [[NSUserDefaults standardUserDefaults]objectForKey:kKeyStoreDependencies];
    
    /* Request */
    [self setupUI];
    [self requestToWebServices];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showActivityIndicator:M13ProgressViewActionNone whithMessage:@"Hola" delay:1.0];

}

#pragma mark Server Requests (JSON)

-(void)requestToWebServices{
    
    _jsonClient = [JSONHTTPClient sharedJSONAPIClient];
    _jsonClient.delegate = self;
    
    [_jsonClient performPOSTRequestWithParameters:nil toServlet:kServletEstados];
    [_jsonClient performPOSTRequestWithParameters:nil toServlet:kServletInauguradores];
    [_jsonClient performPOSTRequestWithParameters:nil toServlet:kServletImpactos];
    [_jsonClient performPOSTRequestWithParameters:nil toServlet:kServletConsultarClasificacion];
    [_jsonClient performPOSTRequestWithParameters:nil toServlet:kServletConsultarDependencias];

    
}
#pragma mark - Interface Customization

/*  Setting the User Interface */

-(void)setupUI{
    
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

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToStates:(id)response{
    
    _statesData = response;
}

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToInaugurators:(id)response{
    
    _inauguratorData = response;
}

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToImpacts:(id)response{
    
    _impactsData = response;
}

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToClasifications:(id)response{
    
    _clasificationsData = response;
}

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToDependencies:(id)response{
    
    _dependencyData = response;
    
}

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didFailResponseWithError:(NSError *)error{
    
    NSLog(@"Error : %@", [error localizedDescription]);
}

#pragma mark - (Save Data) PopupListTableView Delegate

-(void)popupListView:(PopupListTableViewController *)popupListTableView dataForMultipleSelectedRows:(NSArray *)data{
    
    if (popupListTableView.field == e_Dependencia) {
        _dependenciesSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreDependencies];
    }else if (popupListTableView.field == e_Impacto){
        _impactsSavedData = data;
        [[NSUserDefaults standardUserDefaults]rm_setCustomObject:data forKey:kKeyStoreImpact];
    }
    
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

- (IBAction)displayTypesOfProgramasWorks:(id)sender {
    
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
    
    if (_popOverView == nil ) {
        _popOverView = [[UIPopoverController alloc]initWithContentViewController:_popUpTableView];
        
        if (isBarButton) {
            [_popOverView presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }else{
            UIButton *button = (UIButton *)sender;
            
            [_popOverView presentPopoverFromRect:button.frame inView:_buttonsView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        
    }else{
        [_popOverView dismissPopoverAnimated:YES];
        _popOverView = nil;
    }
}

#pragma mark - UITableView  DataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    return cell;

}

#pragma mark - UITableView  Delegate




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


@end
