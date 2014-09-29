//
//  Constants.h
//  Obras-Programas
//
//  Created by Abdiel on 9/25/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

typedef NS_OPTIONS(NSInteger, MainSearchFields)
{
    e_Tipo            = 0,
    e_Dependencia     = 1,
    e_Estado          = 2,
    e_Municipio       = 3,
    e_Tipo_Inversion  = 4,
    e_Impacto         = 5,
    e_Clasificacion   = 6,
    e_Nombre_Inaugura = 7
};


/////////////       General
/******************************************************/

extern NSString * const kDbName;
extern NSString * const kAppURL; //http://desarrollo.smartthinking.com.mx:8080/versailles_intranet/

/////////////       Server
/******************************************************/

extern NSString * const kServletBuscar;
extern NSString * const kServletEstados;
extern NSString * const kServletInauguradores;
extern NSString * const kServletImpactos;
extern NSString * const kServletPoblacionesObjetivo;
extern NSString * const kServletConsultarInversiones;
extern NSString * const kServletConsultarClasificacion;
extern NSString * const kServletConsultarTipoObraPrograma;
extern NSString * const kServletConsultarDependencias;

/////////////       Options
/******************************************************/

extern MainSearchFields searchFields;

/////////////       Keys
/******************************************************/

extern NSString * const kKeyStoreDependencies;
extern NSString * const kKeyStoreTypeWorkOrProgram;
extern NSString * const kKeyStoreStates;
extern NSString * const kKeyStoreCity;
extern NSString * const kKeyStoreImpact;

/////////////       Keys JSON
/******************************************************/

extern NSString * const kKeyDbIdEstado;
extern NSString * const kKeyDbNombreEstado;
extern NSString * const kKeyDbLatitud;
extern NSString * const kKeyDbLongitud;

extern NSString * const kKeyDbIdCargoInaugura;
extern NSString * const kKeyDbNombreCargoInaugura;

extern NSString * const kKeyDbIdInaugurador;
extern NSString * const kKeyDbNombreCargoInaugura;

extern NSString * const kKeyDbIdImpacto;
extern NSString * const kKeyDbNombreImpacto;

extern NSString * const kKeyDbIdClasificacion;
extern NSString * const kKeyDbNombreClasificacion;

extern NSString * const kKeyDbIdDependencia;
extern NSString * const kKeyDbNombreDependencia;

@end
