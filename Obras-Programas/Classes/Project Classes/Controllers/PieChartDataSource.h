//
//  PieChartDataSource.h
//  Prueba Graficas
//
//  Created by Pedro Contreras Nava on 02/10/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiCharts.h>

@interface PieChartDataSource : NSObject <SChartDatasource>
-(id) initWithData:(NSDictionary *)data displayReporte:(NSString *)reporte;
@property NSDictionary *_diccionario;
@property NSString* reporte;
@end
