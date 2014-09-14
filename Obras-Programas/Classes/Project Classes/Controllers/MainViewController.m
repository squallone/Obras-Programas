
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
@property (weak, nonatomic) IBOutlet UIButton *btnQuery;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveQuery;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) UISearchBar *searchBar;

@end

@implementation MainViewController

#pragma mark - View Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Interface Customization

-(void)setupUI{
    
    
    /* Corner nav buttons bar */
    
    float cornerRadius      = 10.0f;
    float borderWidth       = 1.0f;
    UIColor *borderColor    = [UIColor darkGrayColor];
    
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
    UIBarButtonItem *menuBarBtn = [[UIBarButtonItem alloc] initWithCustomView:menuButton];

    /* Add Navigation bar buttom  */

    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:menuBarBtn, searchBarBtn, nil];

    /* Navigation bar buttom implementation */

    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    UIBarButtonItem *logoBar = [[UIBarButtonItem alloc]initWithCustomView:logoImageView];
    
    self.navigationItem.rightBarButtonItem = logoBar;
    
    
}

#pragma mark - Methods of action (Selectors - IBOulet)


-(void)showMenu{
    
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
