//
//  ChartsViewController.h
//  Prueba Graficas
//
//  Created by Pedro Contreras Nava on 02/10/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiCharts.h>
#import "LineView.h"
@class ShinobiChart;
@class ColumnChartDataSource;
@class PieChartDataSource;

@interface ChartsViewController : UIViewController <SChartDelegate>
@property  NSDictionary* _diccionario;
@property  ShinobiChart * _chart;
@property ShinobiChart * _pieChart;
@property ShinobiChart * _donutChart;
@property ShinobiChart * _barChart;
@property NSString * reporteSeleccionado;


@property ColumnChartDataSource * columnDataSource;
@property PieChartDataSource * pieDataSource;
@property LineView *lineView;
-(void)activateColumn;
-(void)activatePie;
-(void)activateDonut;
-(void)activateBar;

-(void)prepareColumnChartWithTitle:(NSString*)title;
-(void)preparePieChartWithTitle:(NSString*)title;
-(void)prepareDonutChartWithTitle:(NSString*)title;
-(void)prepareBarChartWithTitle:(NSString*)title;

-(void)updateChartsWithTitle:(NSString*)title;


@end
