//
//  ColumnChartDataSource.m
//  Prueba Graficas
//
//  Created by Pedro Contreras Nava on 02/10/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import "ColumnChartDataSource.h"

@implementation ColumnChartDataSource
@synthesize _diccionario;

-(id)initWithData:(NSDictionary *)data displayReporte:(NSString *)reporte{
    self._diccionario = data;
    self.reporte = reporte;
    return self;
}

#pragma mark - SChartDatasource methods

- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
        return 1;

}


- (NSDictionary*)dataForReport{
    NSDictionary* dataForReport = _diccionario[self.reporte];
    return dataForReport;
}


-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
    
    if(chart.tag==1){
        SChartColumnSeries *columnSeries = [SChartColumnSeries new];
        columnSeries.selectionMode = SChartSelectionPoint;
        columnSeries.animationEnabled = YES;
        SChartAnimation *animation = [SChartAnimation growVerticalAnimation];
        columnSeries.entryAnimation = animation;
        columnSeries.title = self.reporte;
        
        //Display labels
        columnSeries.style.dataPointLabelStyle.showLabels = YES;
        
        //Position labels
        columnSeries.style.dataPointLabelStyle.offsetFromDataPoint = CGPointMake(0, -15);
        columnSeries.style.dataPointLabelStyle.offsetFlippedForNegativeValues = YES;
        
        //Style labels
        columnSeries.style.dataPointLabelStyle.textColor = [UIColor blackColor];
        columnSeries.style.dataPointLabelStyle.displayValues = SChartDataPointLabelDisplayValuesY;
        
        
        
        return columnSeries;

    }else if(chart.tag==4){
        SChartBarSeries *barSeries = [SChartBarSeries new];
        barSeries.selectionMode = SChartSelectionPoint;
        barSeries.title = self.reporte;

        barSeries.animationEnabled = YES;
        SChartAnimation *animation = [SChartAnimation growHorizontalAnimation];
        
        barSeries.entryAnimation = animation;
        return barSeries;
    }
    return nil;
    
}

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
    return [self dataForReport].count;

}

- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
    SChartDataPoint *datapoint = [[SChartDataPoint alloc] init];
    
    NSDictionary* elementosReporte = [self dataForReport];
    
    
    NSArray *sortedKeys = [[elementosReporte allKeys] sortedArrayUsingSelector: @selector(compare:)];
    NSMutableArray *sortedValues = [NSMutableArray array];
    for (NSString *key in sortedKeys) {
        [sortedValues addObject: [elementosReporte objectForKey: key]];
    }

    
    NSString* key = sortedKeys[dataIndex];


    datapoint.xValue = key;
    datapoint.yValue = elementosReporte[key];
    
    if(chart.tag ==4){
        datapoint.xValue = elementosReporte[key];
        datapoint.yValue = key;
    }
    
    return datapoint;
    

}

@end
