
// Programador: Abdiel Soto, Pedro Contreras
// Origen: Edicomex
// Fecha inicio: Septiemnre 2014
// Fecha ultima modificación: 23/08/2014
// Descripción:
// Dependencias:

#import "MainViewController.h"
@import MapKit.MKMapView;

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//Buttons

@property (weak, nonatomic) IBOutlet UIButton *btnQuery;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveQuery;
@property (weak, nonatomic) IBOutlet UIButton *btnDependence;

@property (strong, nonatomic) UIBarButtonItem *menuBarBtn;

@property (nonatomic, strong) PopupListTableViewController *popUpTableView;
@property (nonatomic, strong) UIPopoverController *popOverView;

//SearchBar
@property (nonatomic, strong) UISearchBar *searchBar;

//Data

@property (nonatomic, strong) NSArray *menuData;

//Animations

@property (nonatomic, strong) CATransition *transition;

@end

@implementation MainViewController

#pragma mark - View Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /*  Menu items */
    
    _menuData = @[@"Busquedas recientes", @"Favoritos", @"Acerca de"];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    /*  Create segmented control with items */
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Obras", @"Programas", nil]];
     segmentedControl.frame = CGRectMake(10, 50, 300, 30);
    
    //add segmented control bar button item to navigation bar
    self.navigationItem.titleView = segmentedControl;
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

#pragma mark - Methods of action (Selectors - IBOulet)

/* Display the menu items */

-(void)showMenu{
    
   // [self displayItemsOntheButton:_menuBarBtn withData:_menuData];
  
}

- (IBAction)displayDependencies:(id)sender {
    
    [self displayItemsOntheButton:_btnDependence withData:_menuData];
}

/* Button that allows to sort a search */

- (IBAction)sortSearch:(id)sender {
    
 
}

- (IBAction)hideSearchList:(id)sender {
    
    if ([_tableView isHidden]) {
        _tableView.hidden = NO;
        _transition.subtype = kCATransitionFromLeft;

    }else{
        _tableView.hidden = YES;
        _transition.subtype = kCATransitionFromRight;
    }
    
    [_tableView.layer addAnimation:_transition forKey:nil];

}

-(void)displayItemsOntheButton:(id)sender withData:(NSArray *)data{
    
    _popUpTableView = [[PopupListTableViewController alloc]initWithData:data];
    _popUpTableView.delegate = self;
    
    if (_popOverView == nil) {
        _popOverView = [[UIPopoverController alloc]initWithContentViewController:_popUpTableView];
        
        [_popOverView presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
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


@end
