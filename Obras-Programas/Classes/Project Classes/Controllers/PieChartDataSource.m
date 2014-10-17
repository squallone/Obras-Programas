//
//  PieChartDataSource.m
//  Prueba Graficas
//
//  Created by Pedro Contreras Nava on 02/10/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import "PieChartDataSource.h"

@implementation PieChartDataSource
@synthesize _diccionario;

-(id)initWithData:(NSDictionary *)data displayReporte:(NSString *)reporte{
    self._diccionario = data;
    self.reporte =reporte;
    return self;
}


- (NSDictionary*)dataForReport{
    NSDictionary* dataForReport = _diccionario[self.reporte];
    return dataForReport;
}


#pragma mark - SChartDatasource methods

- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 1;
}


-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
    if(chart.tag==2){
        SChartPieSeries *pieSeries = [SChartPieSeries new];
        pieSeries.selectionMode = SChartSelectionPoint;
        pieSeries.animationEnabled = YES;
        SChartAnimation *animation = [SChartAnimation growAnimation];
        
        pieSeries.entryAnimation = animation;
        return pieSeries;
        
    }else if(chart.tag==3){
        SChartDonutSeries *donutSeries = [SChartDonutSeries new];
        donutSeries.selectionMode = SChartSelectionPoint;
        donutSeries.animationEnabled = YES;
        SChartAnimation *animation = [SChartAnimation growAnimation];
        
        donutSeries.entryAnimation = animation;
        return donutSeries;
        
    }
    return nil;
    
}

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
    return [self dataForReport].count;
}

- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
   
    SChartDataPoint *datapoint = [[SChartDataPoint alloc] init];
    NSDictionary* dataForReport = [self dataForReport];

    NSString* key = dataForReport.allKeys[dataIndex];
    
    datapoint.xValue = key;
    datapoint.yValue = dataForReport[key];
    

    return datapoint;
    
}
@end
