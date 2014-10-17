//
//  GridViewController.m
//  Obras-Programas
//
//  Created by Pedro Contreras Nava on 15/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "GridViewController.h"
#import "ListaReporteEstado.h"
#define ESTADO 0
#define NUMEROREGISTROS 1
#define INVERSION 2
@interface GridViewController () <MDSpreadViewDataSource,MDSpreadViewDelegate>
@property (nonatomic, strong) NSArray *titleFields;
@property (nonatomic, strong) NSNumberFormatter *currencyFormatter;
@property (strong, nonatomic) IBOutlet MDSpreadView *reportView;

@end

@implementation GridViewController
@synthesize stateReportData = _stateReportData;
@synthesize dependenciesReportData =_dependenciesReportData;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleFields    = @[@{@"title": @"Estado",     @"sortKey": @"estado.nombreEstado"},
                        @{@"title": @"Número de Registros",      @"sortKey": @"numeroObras"},
                        @{@"title": @"Inversión en millones de pesos",  @"sortKey": @"totalInvertido"}];
    ;
    
    _currencyFormatter = [[NSNumberFormatter alloc] init];
    [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    
    return _stateReportData.count;
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
    if (indexPath.row ==ESTADO) {
        return 402;
    }else if(indexPath.row==NUMEROREGISTROS){ //Tamaño para el campo estado/dependencia y inversión
        return 208;
    }else if(indexPath.row==INVERSION){
        return 354;
    }else
        return 0;
}

- (CGFloat)spreadView:(MDSpreadView *)aSpreadView widthForColumnHeaderInSection:(NSInteger)columnSection{
    //    if (columnSection == 2) return 0; // uncomment to hide this header!
    return 0;
}

#pragma - Cells

- (MDSpreadViewCell *)spreadView:(MDSpreadView *)aSpreadView cellForRowAtIndexPath:(MDIndexPath *)rowPath forColumnAtIndexPath:(MDIndexPath *)columnPath{
    
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





@end
