//
//  Constants.m
//  Obras-Programas
//
//  Created by Abdiel on 9/25/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "Constants.h"

@implementation Constants

/////////////       SERVER
/******************************************************/

#define kAppBaseProtocol    @"http://"
#define kAppBaseURL         @"54.69.71.115"
#define kAppBasePort        @":8080/"
#define kAppIntranetPath    @"ObrasYProgramas/"
#define kAppFullURL         kAppBaseProtocol kAppBaseURL kAppBasePort kAppIntranetPath

/////////////       GENERAL
/******************************************************/

NSString * const kDbName = @"oyp";
NSString * const kAppURL = kAppFullURL;



//              Servlets
/******************************************************/

NSString * const kServletBuscar                     = @"buscar";
NSString * const kServletEstados                    = @"consultarEstados";
NSString * const kServletInauguradores              = @"consultarInauguradores";
NSString * const kServletImpactos                   = @"consultarImpactos";
NSString * const kServletPoblacionesObjetivo        = @"consultarPoblacionesObjetivo";
NSString * const kServletConsultarInversiones       = @"consultarInversiones";
NSString * const kServletConsultarClasificacion     = @"consultarClasificaciones";
NSString * const kServletConsultarTipoObraPrograma  = @"consultarTiposDeObraProgramas";
NSString * const kServletConsultarDependencias      = @"consultarDependencias";


//              KEYS TO PERSIST DATA
/******************************************************/

NSString * const kKeyStoreDependencies          =  @"kdp";
NSString * const kKeyStoreTypeWorkOrProgram     =  @"ktp";
NSString * const kKeyStoreStates                =  @"kedo";
NSString * const kKeyStoreCity                  =  @"kmun";
NSString * const kKeyStoreImpact                =  @"kimp";

//              KEYS JSON
/******************************************************/

//Estado

NSString * const kKeyDbIdEstado                 =  @"idEstado";
NSString * const kKeyDbNombreEstado             =  @"nombreEstado";
NSString * const kKeyDbLatitud                  =  @"latitud";
NSString * const kKeyDbLongitud                 =  @"longitud";

//Inaugura
NSString * const kKeyDbIdCargoInaugura          =  @"idCargoInaugura";
NSString * const kKeyDbNombreCargoInaugura      =  @"nombreCargoInaugura";


//Impacto
NSString * const kKeyDbIdImpacto                =  @"idImpacto";
NSString * const kKeyDbNombreImpacto            =  @"nombreImpacto";

//Clasificación
NSString * const kKeyDbIdClasificacion          =  @"idTipoClasificacion";
NSString * const kKeyDbNombreClasificacion      =  @"nombreTipoClasificacion";

//Dependencia

NSString * const kKeyDbIdDependencia            =  @"idDependencia";
NSString * const kKeyDbNombreDependencia       =  @"nombreDependencia";

@end
