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
#import "Subclasificacion.h"


const NSString *kKeyNombre = @"nombre";
const NSString *kKeyDatos  = @"datos";

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
    NSMutableArray *createArrayOfString = [NSMutableArray array];
    
    if (self.consulta.denominacion) {
        createArrayOfString = [NSMutableArray arrayWithArray:@[self.consulta.denominacion]];
        [dataDic setObject:createArrayOfString forKey:kKeyDatos];
        [dataDic setObject:@"Denominación" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
    dataDic = [NSMutableDictionary new];

    if (self.consulta.idPrograma.length > 0) {
        createArrayOfString =[NSMutableArray arrayWithArray:@[self.consulta.idPrograma]];
        [dataDic setObject:createArrayOfString forKey:kKeyDatos];
        [dataDic setObject:@"ID Programa" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
    dataDic = [NSMutableDictionary new];

    if (self.consulta.idObra.length > 0) {
        createArrayOfString = [NSMutableArray arrayWithArray:@[self.consulta.idObra]];
        [dataDic setObject:createArrayOfString forKey:kKeyDatos];
        [dataDic setObject:@"ID Obra" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
    
    dataDic = [NSMutableDictionary new];
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

    if (![[NSDecimalNumber notANumber] isEqualToNumber:self.consulta.rangoMin] && ![[NSDecimalNumber notANumber] isEqualToNumber:self.consulta.rangoMax]) {
        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        NSString *string = [NSString stringWithFormat:@"%@  a  %@",[currencyFormatter stringFromNumber:self.consulta.rangoMin], [currencyFormatter stringFromNumber:self.consulta.rangoMax]];
        createArrayOfString = [NSMutableArray arrayWithArray:@[string]];
        [dataDic setObject:createArrayOfString forKey:kKeyDatos];
        [dataDic setObject:@"Rango de inversión (MDP)" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }

    dataDic = [NSMutableDictionary new];
    if (self.consulta.tipoDeInversionesData) {
        [dataDic setObject:self.consulta.tipoDeInversionesData forKey:kKeyDatos];
        [dataDic setObject:@"Tipo de inversión" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
    
    dataDic = [NSMutableDictionary new];
    if (self.consulta.anoProgramaData) {
        [dataDic setObject:self.consulta.anoProgramaData forKey:kKeyDatos];
        [dataDic setObject:@"Año(s) programa" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
    
    
    dataDic = [NSMutableDictionary new];
    createArrayOfString = [NSMutableArray array];

    if (self.consulta.fechaInicio || self.consulta.fechaInicioSegunda) {
        
        NSDateFormatter *dateFormatterShort = [[NSDateFormatter alloc]init];
        dateFormatterShort.dateStyle = NSDateFormatterLongStyle;
        NSString *strIni = [dateFormatterShort stringFromDate:self.consulta.fechaInicio];
        NSString *strFin = [dateFormatterShort stringFromDate:self.consulta.fechaInicioSegunda];
        strIni = strIni ? strIni : @"Ninguna";
        strFin = strFin ? strFin : @"Ninguna";
        [createArrayOfString addObject:[NSString stringWithFormat:@"Inicio: %@",strIni]];
        [createArrayOfString addObject:[NSString stringWithFormat:@"Final: %@", strFin]];
        
        [dataDic setObject:createArrayOfString forKey:kKeyDatos];
        [dataDic setObject:@"Fecha inicial" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
    
    dataDic = [NSMutableDictionary new];
    createArrayOfString = [NSMutableArray array];
    
    if (self.consulta.fechaFin || self.consulta.fechaFinSegunda) {
        
        NSDateFormatter *dateFormatterShort = [[NSDateFormatter alloc]init];
        dateFormatterShort.dateStyle = NSDateFormatterLongStyle;
        NSString *strIni = [dateFormatterShort stringFromDate:self.consulta.fechaFin];
        NSString *strFin = [dateFormatterShort stringFromDate:self.consulta.fechaFinSegunda];
        strIni = strIni ? strIni : @"Ninguna";
        strFin = strFin ? strFin : @"Ninguna";
        [createArrayOfString addObject:[NSString stringWithFormat:@"Inicio: %@",strIni]];
        [createArrayOfString addObject:[NSString stringWithFormat:@"Final: %@", strFin]];
        
        [dataDic setObject:createArrayOfString forKey:kKeyDatos];
        [dataDic setObject:@"Fecha final" forKey:kKeyNombre];
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
    if (self.consulta.subclasificacionesCG) {
        [dataDic setObject:self.consulta.subclasificacionesCG forKey:kKeyDatos];
        [dataDic setObject:@"Compromisos de Gobierno" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
    dataDic = [NSMutableDictionary new];
    if (self.consulta.inauguradoresData) {
        [dataDic setObject:self.consulta.inauguradoresData forKey:kKeyDatos];
        [dataDic setObject:@"Inauguradores" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
    
    dataDic = [NSMutableDictionary new];
    if (self.consulta.inauguradaData) {
        [dataDic setObject:self.consulta.inauguradaData forKey:kKeyDatos];
        [dataDic setObject:@"Inaugurada" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
    dataDic = [NSMutableDictionary new];
    if (self.consulta.susceptibleData) {
        [dataDic setObject:self.consulta.susceptibleData forKey:kKeyDatos];
        [dataDic setObject:@"Susceptible" forKey:kKeyNombre];
        [_datasource addObject:dataDic];
    }
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
    
    if ([nombre isEqualToString:@"Denominación"]) {
       cell.textLabel.text = dataSelected[indexPath.row];
    }
    if ([nombre isEqualToString:@"ID Programa"]) {
        cell.textLabel.text = dataSelected[indexPath.row];
    }
    if ([nombre isEqualToString:@"ID Obra"]) {
        cell.textLabel.text = dataSelected[indexPath.row];
    }
    if ([nombre isEqualToString:@"Dependencia"]) {
        Dependencia *dependencia = dataSelected[indexPath.row];
        cell.textLabel.text = dependencia.nombreDependencia;
    }else if ([nombre isEqualToString:@"Estados"]) {
        Estado *estado = dataSelected[indexPath.row];
        cell.textLabel.text = estado.nombreEstado;
    }else if ([nombre isEqualToString:@"Rango de inversión (MDP)"]) {
        cell.textLabel.text = dataSelected[indexPath.row];
    }else if ([nombre isEqualToString:@"Tipo de inversión"]) {
        Inversion *inversion = dataSelected[indexPath.row];
        cell.textLabel.text = inversion.nombre;
    }else if ([nombre isEqualToString:@"Año(s) programa"]){
        cell.textLabel.text = dataSelected[indexPath.row];
    }else if ([nombre isEqualToString:@"Fecha inicial"]){
        cell.textLabel.text = dataSelected[indexPath.row];
    }else if ([nombre isEqualToString:@"Fecha final"]){
        cell.textLabel.text = dataSelected[indexPath.row];
    }else if ([nombre isEqualToString:@"Impactos"]) {
        Impacto *impacto = dataSelected[indexPath.row];
        cell.textLabel.text = impacto.nombreImpacto;
    }else if ([nombre isEqualToString:@"Clasificación"]) {
        Clasificacion *clasificacion = dataSelected[indexPath.row];
        cell.textLabel.text = clasificacion.nombreTipoClasificacion;
    }else if ([nombre isEqualToString:@"Compromisos de Gobierno"]){
        Subclasificacion *compromiso = dataSelected[indexPath.row];
        cell.textLabel.text = compromiso.nombreSubclasificacion;
    }else if ([nombre isEqualToString:@"Inauguradores"]) {
        Inaugurador *inaugurador = dataSelected[indexPath.row];
        cell.textLabel.text = inaugurador.nombreCargoInaugura;
    }else if ([nombre isEqualToString:@"Inaugurada"]) {
        cell.textLabel.text = dataSelected[indexPath.row];
    }else if ([nombre isEqualToString:@"Susceptible"]) {
        cell.textLabel.text = dataSelected[indexPath.row];
    }
    return cell;
}


@end
