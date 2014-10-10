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
NSString * const kKeyStoreClasification         =  @"kcs";
NSString * const kKeyStoreInvesments            =  @"kinv";


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
NSString * const kKeyDbNombreDependencia        =  @"nombreDependencia";

//Inversion

NSString * const kKeyDbIdTipoInversion          =  @"idTipoInversion";
NSString * const kKeyDbNombreTipoInversion      =  @"nombreTipoInversion";

//Tipo Obra Programa

NSString * const kKeyDbIdTipoObra               =  @"idTipoObra";
NSString * const kKeyDbNombreTipoObra           =  @"nombreTipoObra";

//Obras

NSString * const kKeyDbIdObra                   = @"idObra";
NSString * const kKeyDbDenominacion             = @"denominacion";
NSString * const kKeyDbTipoObra                 = @"tipoObra";
NSString * const kKeyDbDependencia              = @"dependencia";
NSString * const kKeyDbEstado                   = @"estado";
NSString * const kKeyDbImpacto                  = @"impacto";
NSString * const kKeyDbTipoInversion            = @"tipoInversion";
NSString * const kKeyDbClasificacion            = @"clasificacion";
NSString * const kKeyDbInaugurador              = @"inaugurador";
NSString * const kKeyDbDescripcion              = @"descripcion";
NSString * const kKeyDbObservaciones            = @"observaciones";
NSString * const kKeyDbFechaInicio              = @"fechaInicio";
NSString * const kKeyDbFechaTermino             = @"fechaTermino";
NSString * const kKeyDbInversionTotal           = @"inversionTotal";
NSString * const kKeyDbSenalizacion             = @"senalizacion";
NSString * const kKeyDbSusceptibleInauguracion  = @"susceptibleInauguracion";
NSString * const kKeyDbPorcentajeAvance         = @"porcentajeAvance";
NSString * const kKeyDbFotoAntes                = @"fotoAntes";
NSString * const kKeyDbFotoDurante              = @"fotoDurante";
NSString * const kKeyDbFotoDespues              = @"fotoDespues";
NSString * const kKeyDbFechaModificacion        = @"fechaModificacion";
NSString * const kKeyDbTotalBeneficiarios       = @"totalBeneficiarios";
NSString * const kKeyDbTipoMoneda               = @"tipoMoneda";
NSString * const kKeyDbInaugurada               = @"inaugurada";
NSString * const kKeyDbPoblacionObjetivo        = @"poblacionObjetivo";
NSString * const kKeyDbMunicipio                = @"municipio";


//              Parameters Servlet Buscar
/******************************************************/

NSString * const kParamTipoDeObra       = @"tipoDeObra";
NSString * const kParamDependencia      = @"dependencia";
NSString * const kParamEstado           = @"estado";
NSString * const kParamInversionMinima  = @"inversionMinima";
NSString * const kParamImversionMaxima  = @"inversionMaxima";
NSString * const kParamTipoDeInversion  = @"tipoDeInversion";
NSString * const kParamFechaInicio      = @"fechaInicio";
NSString * const kParamFechaFin         = @"fechaFin";
NSString * const kParamImpacto          = @"impacto";
NSString * const kParamClasificacion    = @"clasificacion";
NSString * const kParamInaugurador      = @"inaugurador";
NSString * const kParamSusceptible      = @"susceptible";
NSString * const kParamInaugurada       = @"inaugurada";

//              Alerts Messages and HUD Messages
/******************************************************/

//Dependencia

NSString * const kHUDMsgLoading          =  @"Buscando...";

@end