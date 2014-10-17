//
//  GraficasViewController.m
//  Obras-Programas
//
//  Created by Pedro Contreras Nava on 14/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "GraficasViewController.h"
#import "ChartsViewController.h"
#import "GridViewController.h"
#import "listaReporteEstado.h"
#import "listaReporteDependencia.h"
#import "Dependencia.h"

@interface GraficasViewController ()<UIPageViewControllerDelegate>

- (IBAction)displayColumnChart:(id)sender;
- (IBAction)displayPieChart:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property CGRect rectLandscape;
@property CGRect rectPortrait;
@property GridViewController* gridViewController;
@property  NSMutableDictionary* diccionario;
@property NSString *tituloGrafica;

@end

@implementation GraficasViewController


@synthesize chartController;
@synthesize segmentedControl;
@synthesize diccionario = _diccionario;
@synthesize tituloGrafica = _tituloGrafica;

- (void)viewDidLoad {
    [super viewDidLoad];
    chartController = self.childViewControllers.firstObject;
    self.rectLandscape = CGRectMake(0, 0, 964, 506);
    self.rectPortrait = CGRectMake(0, 0, 708, 300);
    [segmentedControl setTitle:(@"Estados") forSegmentAtIndex:0];
    [segmentedControl setTitle:(@"Dependencias") forSegmentAtIndex:1];
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
    tempScrollView.contentSize=CGSizeMake(1024,960);
    tempScrollView.backgroundColor = [UIColor whiteColor];
    tempScrollView.bounces = NO;
    _tituloGrafica = @"totalInvertido";

}



- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        chartController.view.frame =self.rectLandscape;
        NSLog(@"Change to custom UI for landscape");
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationPortrait ||
             toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        NSLog(@"Change to custom UI for portrait");
        chartController.view.frame =self.rectPortrait;

        
    }
}
- (IBAction)indexChanged:(id)sender {
    if (self.segmentedControl.selectedSegmentIndex ==0) {
        _tituloGrafica = @"totalInvertido";

    }else{
        _tituloGrafica = @"totalInvertidoDependencias";

    }
    
    [chartController setReporteSeleccionado:_tituloGrafica];
    [chartController updateChartsWithTitle:_tituloGrafica];
}

-(void)prepareDictionary{
    _diccionario = [[NSMutableDictionary alloc] init];
    
    NSString *nombre;
    ListaReporteEstado *reporteEstado;
    ListaReporteDependencia *reporteDependencia;
    
    NSNumber *valorObras;
    NSNumber *valorInvertido;

    NSMutableDictionary *diccionarioNumeroObras = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *diccionarioTotalInvertido = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *diccionarioNumeroObrasDependencias = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *diccionarioTotalInvertidoDependencias = [[NSMutableDictionary alloc] init];

    for(int i=0;i<[_stateReportData count];i++){
        reporteEstado = [_stateReportData objectAtIndex:i];
        nombre = reporteEstado.estado.nombreEstado;
        valorObras = reporteEstado.numeroObras;
        valorInvertido = reporteEstado.totalInvertido;
        [diccionarioNumeroObras setObject:valorObras forKey:nombre];
        [diccionarioTotalInvertido setObject:valorInvertido forKey:nombre];
        
    }
    NSString *valorObrasDependencia;
    NSString *valorInvertidoDependencia;
    for(int i=0;i<[_dependenciesReportData count];i++){
        reporteDependencia = [_dependenciesReportData objectAtIndex:i];
        nombre = reporteDependencia.dependencia.nombreDependencia;
        valorObrasDependencia = reporteDependencia.numeroObras;
        valorInvertidoDependencia = reporteDependencia.totalInvertido;
        
        [diccionarioNumeroObrasDependencias setObject:valorObrasDependencia forKey:nombre];
        [diccionarioTotalInvertidoDependencias setObject:valorInvertidoDependencia forKey:nombre];
        
    }
    
    
    [_diccionario setObject:diccionarioNumeroObras forKey:@"numeroObras"];
    [_diccionario setObject:diccionarioTotalInvertido forKey:@"totalInvertido"];
    [_diccionario setObject:diccionarioNumeroObrasDependencias forKey:@"numeroObrasDependencias"];
    [_diccionario setObject:diccionarioTotalInvertidoDependencias forKey:@"totalInvertidoDependencias"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)totalInvertidoButton:(id)sender {
    if (self.segmentedControl.selectedSegmentIndex ==0) {
        _tituloGrafica = @"totalInvertido";
        
    }else{
        _tituloGrafica = @"totalInvertidoDependencias";
        
    }
    
    [chartController setReporteSeleccionado:_tituloGrafica];
    [chartController updateChartsWithTitle:_tituloGrafica];

}

- (IBAction)numeroObrasButton:(id)sender {
    if (self.segmentedControl.selectedSegmentIndex ==0) {
        _tituloGrafica = @"numeroObras";
        
    }else{
        _tituloGrafica = @"numeroObrasDependencias";
        
    }
    
    [chartController setReporteSeleccionado:_tituloGrafica];
    [chartController updateChartsWithTitle:_tituloGrafica];

}

- (IBAction)displayColumnChart:(id)sender {
    
    [chartController activateColumn];
}

- (IBAction)displayPieChart:(id)sender {
    [chartController preparePieChartWithTitle:_tituloGrafica];
    [chartController activatePie];
    NSLog(@"%@",_tituloGrafica);

}

- (IBAction)displayDonutChart:(id)sender {
    [chartController prepareDonutChartWithTitle:_tituloGrafica];
    [chartController activateDonut];
    NSLog(@"%@",_tituloGrafica);
}

- (IBAction)displayBubbleChart:(id)sender {
    [chartController prepareBarChartWithTitle:_tituloGrafica];
    [chartController activateBar];
    NSLog(@"%@",_tituloGrafica);

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"gridSegue"]) {
        _gridViewController = (GridViewController*) [segue destinationViewController];
        _gridViewController.stateReportData = _stateReportData;
    }else if([segueName isEqualToString: @"graficaSegue"]){
        [self prepareDictionary];
        chartController = (ChartsViewController*) [segue destinationViewController];
        chartController._diccionario = _diccionario;
    }
    
}

@end
