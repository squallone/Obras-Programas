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
#define kAppIntranetPath    @"ObrasProgramas/"
#define kAppFullURL         kAppBaseProtocol kAppBaseURL kAppBasePort kAppIntranetPath

/////////////       GENERAL
/******************************************************/

NSString * const kDbName = @"oyp";
NSString * const kAppURL = kAppFullURL;

// Devices
/******************/

#define kIs_iPhone (!IS_IPAD)
#define kIs_iPad (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
#define kIs_iPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE

// AppDelegate
/******************/
#define kAppDelegate (AppDelegate*)[[UIApplication sharedApplication]delegate]

//Debug
/******************/

#ifndef DEBUG
#define NSLog(...);
#endif

//              Servlets
/******************************************************/

NSString * const kServletEstados        = @"consultarEstados";
NSString * const kServletInauguradores  = @"consultarInauguradores";


//              KEYS TO PERSIST DATA
/******************************************************/

NSString * const kKeyStoreDependencies          =  @"kdp";
NSString * const kKeyStoreTypeWorkOrProgram     =  @"ktp";
NSString * const kKeyStoreStates                =  @"kedo";
NSString * const kKeyStoreCity                  =  @"kmun";
NSString * const kKeyStoreImpact                =  @"kimp";

//              KEYS JSON
/******************************************************/

NSString * const kKeyDbIdEstado         =  @"idEstado";
NSString * const kKeyDbNombreEstado     =  @"nombreEstado";
NSString * const kKeyDbLatitud          =  @"latitud";
NSString * const kKeyDbLongitud         =  @"longitud";




@end
