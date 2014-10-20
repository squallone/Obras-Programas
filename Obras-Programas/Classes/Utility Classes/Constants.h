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
    e_Nombre_Inaugura = 7,
    e_Inaugurada      = 8,
    e_Suscpetible     = 9,
    e_RangoInversion  = 10,
    e_Sort_Result     = 11
};

typedef NS_OPTIONS(NSInteger, MenuOptions)
{
    o_Consultas         = 0,
    o_Favoritos         = 1,
    o_AcercaDe          = 2,
    o_Detalle_Consulta  = 3

};

typedef NS_OPTIONS(NSInteger, ReportOption)
{
    r_state = 0,
    r_dependency = 1,
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
extern NSString * const kKeyStoreClasification;
extern NSString * const kKeyStoreInvesments;
extern NSString * const kKeyStoreInaugurators;

extern NSString * const kKeyStoreStartIniDate;
extern NSString * const kKeyStoreStartEndDate;
extern NSString * const kKeyStoreEndIniDate;
extern NSString * const kKeyStoreEndEndDate;
extern NSString * const kKeyStoreInauguradaOption;
extern NSString * const kKeyStoreSusceptibleOption;

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

extern NSString * const kKeyDbIdTipoInversion;
extern NSString * const kKeyDbNombreTipoInversion;

extern NSString * const kKeyDbIdTipoObra;
extern NSString * const kKeyDbNombreTipoObra;

//Obras

extern NSString * const kKeyDbIdObra;
extern NSString * const kKeyDbDenominacion;
extern NSString * const kKeyDbTipoObra;
extern NSString * const kKeyDbDependencia;
extern NSString * const kKeyDbEstado;
extern NSString * const kKeyDbImpacto;
extern NSString * const kKeyDbTipoInversion;
extern NSString * const kKeyDbClasificacion;
extern NSString * const kKeyDbInaugurador;
extern NSString * const kKeyDbDescripcion;
extern NSString * const kKeyDbObservaciones;
extern NSString * const kKeyDbFechaInicio;
extern NSString * const kKeyDbFechaTermino;
extern NSString * const kKeyDbInversionTotal;
extern NSString * const kKeyDbSenalizacion;
extern NSString * const kKeyDbSusceptibleInauguracion;
extern NSString * const kKeyDbPorcentajeAvance;
extern NSString * const kKeyDbFotoAntes;
extern NSString * const kKeyDbFotoDurante;
extern NSString * const kKeyDbFotoDespues;
extern NSString * const kKeyDbFechaModificacion;
extern NSString * const kKeyDbTotalBeneficiarios;
extern NSString * const kKeyDbTipoMoneda;
extern NSString * const kKeyDbInaugurada;
extern NSString * const kKeyDbPoblacionObjetivo;
extern NSString * const kKeyDbMunicipio;

extern NSString * const kKeyListaObras;
extern NSString * const kKeyListaReporteEstado;
extern NSString * const kKeyListaReporteDependencia;
extern NSString * const kKeyListaReporteGeneral;

//              Parameters Servlet Buscar
/******************************************************/

extern NSString * const kParamTipoDeObra;
extern NSString * const kParamDependencia;
extern NSString * const kParamEstado;
extern NSString * const kParamInversionMinima;
extern NSString * const kParamImversionMaxima;
extern NSString * const kParamTipoDeInversion;
extern NSString * const kParamFechaInicio;
extern NSString * const kParamFechaInicioSegunda;
extern NSString * const kParamFechaFin;
extern NSString * const kParamFechaFinSegunda;
extern NSString * const kParamImpacto;
extern NSString * const kParamClasificacion;
extern NSString * const kParamInaugurador;
extern NSString * const kParamSusceptible;
extern NSString * const kParamInaugurada;
extern NSString * const kParamLimiteMin;
extern NSString * const kParamLimiteMax;

//              Alerts Messages and HUD Messages
/******************************************************/

//Dependencia

extern NSString * const kHUDMsgLoading;

@end
