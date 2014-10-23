//
//  Programa.h
//  Obras-Programas
//
//  Created by Abdiel on 9/25/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Obra.h"
#import "PoblacionObjetivo.h"
#import "TipoApoyo.h"

@interface Programa : Obra

@property (nonatomic, strong) NSString *idPrograma;
@property (nonatomic, strong) NSString *absoluto;
@property (nonatomic, strong) NSString *anoPrograma;
@property (nonatomic, strong) NSString *lineaBase;
@property (nonatomic, strong) NSString *metaBeneficiarios;
@property (nonatomic, strong) NSString *montoDeApoyo;
@property (nonatomic, strong) NSString *nombrePrograma;
@property (nonatomic, strong) PoblacionObjetivo *poblacion;
@property (nonatomic, strong) TipoApoyo *tipoApoyo;
@property (nonatomic, strong) NSString *porcentual;
@property (nonatomic, strong) NSString *totalMunicipios;

@end
