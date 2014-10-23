//
//  DetailTableViewController.m
//  Obras-Programas
//
//  Created by Abdiel on 10/11/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "DetailTableViewController.h"
#import "Obra.h"
#import "Programa.h"
#import "Consulta.h"
#import "FichaTecnicaViewController.h"

@interface DetailTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;
@property  CGSize size;
@property MenuOptions option;
@property CGFloat labelSize;

@end

@implementation DetailTableViewController


-(id)initWithDataSource:(NSArray *)dataSource menuOption:(MenuOptions)option{
    
    
    if ([super initWithStyle:UITableViewStylePlain] !=nil) {
        
        _option = option;
        /* Initialize instance variables */
        self.navigationController.navigationBar.hidden = NO;

        self.dataSource     = dataSource;
        
        self.clearsSelectionOnViewWillAppear = NO;
        
        NSInteger rowsCount = [self.dataSource count];
        NSInteger totalRowsHeight = (rowsCount * 45);
        self.tableView.backgroundColor = [UIColor clearColor];
        //Calcula el ancho que debe tener la vista buscando que ancho de cada string se espera que sea
        
        CGFloat largestLabelWidth = 0;
        _labelSize = _option == o_Consultas ? 17.0 : 14.5;
        
        if (_option == o_Consultas) {
            for (id objectModel in self.dataSource) {
                
                NSDictionary *dicData = [self textToDisplay:objectModel];
                NSString *title = dicData[@"title"];
                
                //Verifica el tamaño del texto usado la fuente del textLabel por defecto del UITableViewCell
                
                CGSize labelSize = [title sizeWithAttributes:
                                    @{NSFontAttributeName:
                                          [UIFont fontWithName:@"HelveticaNeue-Light" size:_labelSize]}];
                
                if (labelSize.width > largestLabelWidth) {
                    largestLabelWidth = labelSize.width;
                }
            }
        }else if (_option == o_Favoritos){
            
        }
               //Agrega un pequeño padding al ancho
        CGFloat popoverWidth = largestLabelWidth + 90;
        _size = CGSizeMake(popoverWidth, totalRowsHeight);
        //Establece la propiedad para decirle al contenedor del popover que tan grande sera su vista
        self.preferredContentSize = _size;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated{

    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{

    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    id objectModel = _dataSource[indexPath.row];
    
    NSDictionary *dicData = [self textToDisplay:objectModel];
    NSString *title = dicData[@"title"];
    NSString *subtitle = dicData[@"subtitle"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:_labelSize];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text         = [NSString stringWithFormat:@"%ld.- %@ ",(long)indexPath.row+1, title];
    cell.detailTextLabel.text   = [NSString stringWithFormat:@"      %@", subtitle];
    return cell;
}

#pragma mark - UITableView  Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_option == o_Consultas) {
        
    }else if (_option == o_Favoritos){
        Obra *obra = _dataSource[indexPath.row];
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"showFichaTecnica" object:obra];
    }
}

#pragma mark - Segue


-(NSDictionary *)textToDisplay:(id)objectModel{
    
    NSString *title     = @"";
    NSString *subtitle  = @"";
    
    if (_option == o_Consultas) {
        
        Consulta *consulta = (Consulta *)objectModel;
        title       = consulta.nombreConsulta;
        subtitle    = @"Fecha";
        
    }else if(_option == o_Favoritos){
        
        
        Obra *obra = (Obra *)objectModel;
        title = obra.denominacion;
        subtitle = obra.idObra;
    }
    
    return @{@"title": title, @"subtitle": subtitle};
}

@end
