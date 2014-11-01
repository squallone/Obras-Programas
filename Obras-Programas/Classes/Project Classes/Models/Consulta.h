//
//  Consulta.h
//  Obras-Programas
//
//  Created by Abdiel on 9/25/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Consulta : NSObject

@property (nonatomic, strong) NSDate *fechaCreacion;
@property (nonatomic, strong) NSArray *tipoObrasPorgramasData;
@property (nonatomic, strong) NSString * nombreConsulta;
@property (nonatomic, strong) NSString * denominacion;
@property (nonatomic, strong) NSString * idObra;
@property (nonatomic, strong) NSString * idPrograma;
@property (nonatomic, strong) NSArray * dependenciasData;
@property (nonatomic, strong) NSArray * estadosData;
@property (nonatomic, strong) NSNumber * rangoMin;
@property (nonatomic, strong) NSNumber * rangoMax;
@property (nonatomic, strong) NSArray * tipoDeInversionesData;
@property (nonatomic, strong) NSDate * fechaInicio;
@property (nonatomic, strong) NSDate * fechaInicioSegunda;
@property (nonatomic, strong) NSDate * fechaFin;
@property (nonatomic, strong) NSDate * fechaFinSegunda;
@property (nonatomic, strong) NSArray * impactosData;
@property (nonatomic, strong) NSArray * clasificacionesData;
@property (nonatomic, strong) NSArray * inauguradoresData;
@property (nonatomic, strong) NSArray * susceptibleData;
@property (nonatomic, strong) NSArray * inauguradaData;
@property (nonatomic, strong) NSArray * anoProgramaData;
@property (nonatomic, strong) NSArray * subclasificacionesCG;

@end
