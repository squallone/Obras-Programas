//
//  ConsultasGuardadasTableViewController.m
//  Obras-Programas
//
//  Created by Abdiel on 10/20/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "ConsultasGuardadasTableViewController.h"
#import "Dependencia.h"
#import "Estado.h"
#import "Inversion.h"
#import "Impacto.h"
#import "Clasificacion.h"
#import "Inaugurador.h"

const NSString *kKeyNombre = @"nombre";
const NSString *kKeyDatos = @"datos";

const NSString *kNombreDependencia;

@interface ConsultasGuardadasTableViewController ()

@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation ConsultasGuardadasTableViewController

-(id)initWithDataSource:(NSArray *)dataSource menuOption:(MenuOptions)option{
    
    if ([super initWithStyle:UITableViewStylePlain] !=nil) {
        
        /* Initialize instance variables */
        self.navigationController.navigationBar.hidden = NO;
        self.clearsSelectionOnViewWillAppear = NO;
        self.tableView.backgroundColor = [UIColor clearColor];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Detalle de la consulta";
    
    NSMutableDictionary *dataDic = [NSMutableDictionary new];
    _datasource = [NSMutableArray new];
    if (self.consulta.dependenciasData) {
        [dataDic setObject:self.consulta.dependenciasData forKey:kKeyDatos];
        [dataDic setObject:@"Dependencia" forKey:kKeyNombre];

        [_datasource addObject:dataDic];
    }
    dataDic = [NSMutableDictionary new];
    if (self.consulta.estadosData) {
        [dataDic setObject:self.consulta.estadosData forKey:kKeyDatos];
        [dataDic setObject:@"Estados" forKey:kKeyNombre];

        [_datasource addObject:dataDic];
    }
    dataDic = [NSMutableDictionary new];
    if (self.consulta.tipoDeInversionesData) {
        [dataDic setObject:self.consulta.tipoDeInversionesData forKey:kKeyDatos];
        [dataDic setObject:@"Tipo de inversión" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
    dataDic = [NSMutableDictionary new];
    if (self.consulta.impactosData) {
        [dataDic setObject:self.consulta.impactosData forKey:kKeyDatos];
        [dataDic setObject:@"Impactos" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
    dataDic = [NSMutableDictionary new];
    if (self.consulta.clasificacionesData) {
        [dataDic setObject:self.consulta.clasificacionesData forKey:kKeyDatos];
        [dataDic setObject:@"Clasificación" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
    dataDic = [NSMutableDictionary new];
    if (self.consulta.inauguradoresData) {
        [dataDic setObject:self.consulta.inauguradoresData forKey:kKeyDatos];
        [dataDic setObject:@"Inauguradores" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return _datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSDictionary *dicData = _datasource[section];
    NSArray *dataSelected = dicData[kKeyDatos];
    return dataSelected.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    NSDictionary *dicData = _datasource[section];
    
    return dicData[kKeyNombre];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dicData = _datasource[indexPath.section];
    

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    NSString *nombre = dicData[kKeyNombre];
    NSArray *dataSelected = dicData[kKeyDatos];

    if ([nombre isEqualToString:@"Dependencia"]) {
        Dependencia *dependencia = dataSelected[indexPath.row];
        cell.textLabel.text = dependencia.nombreDependencia;
    }else if ([nombre isEqualToString:@"Estados"]) {
        Estado *estado = dataSelected[indexPath.row];
        cell.textLabel.text = estado.nombreEstado;

    }else if ([nombre isEqualToString:@"Tipo de inversión"]) {
        Inversion *inversion = dataSelected[indexPath.row];
        cell.textLabel.text = inversion.nombre;
        
    }else if ([nombre isEqualToString:@"Impactos"]) {
        Impacto *impacto = dataSelected[indexPath.row];
        cell.textLabel.text = impacto.nombreImpacto;
        
    }else if ([nombre isEqualToString:@"Clasificación"]) {
        Clasificacion *clasificacion = dataSelected[indexPath.row];
        cell.textLabel.text = clasificacion.nombreTipoClasificacion;
        
    }else if ([nombre isEqualToString:@"Inauguradores"]) {
        Inaugurador *inaugurador = dataSelected[indexPath.row];
        cell.textLabel.text = inaugurador.nombreCargoInaugura;
        
    }
    
    return cell;
}


@end
