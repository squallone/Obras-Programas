//
//  Obra.h
//  Obras-Programas
//
//  Created by Abdiel on 9/25/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "TipoObraPrograma.h"
#import "Dependencia.h"
#import "Estado.h"
#import "Impacto.h"
#import "Inaugurador.h"
#import "Subclasificacion.h"

@interface Obra : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *idObra;
@property (nonatomic, strong) NSString *denominacion;
@property (nonatomic, strong) TipoObraPrograma *tipoObra;
@property (nonatomic, strong) Dependencia *dependencia;
@property (nonatomic, strong) Estado *estado;
@property (nonatomic, strong) Impacto *impacto;
@property (nonatomic, strong) NSArray *inversiones;
@property (nonatomic, strong) NSArray *clasificaciones;
@property (nonatomic, strong) Inaugurador *inaugurador;
@property (nonatomic, strong) NSString *descripcion;
@property (nonatomic, strong) NSString *observaciones;
@property (nonatomic, strong) NSDate *fechaInicio;
@property (nonatomic, strong) NSDate *fechaTermino;
@property (nonatomic, strong) NSString *inversionTotal;
@property (nonatomic, strong) NSString *totalBeneficiarios;
@property (nonatomic, strong) NSString *senalizacion;
@property (nonatomic, strong) NSString *susceptibleInauguracion;
@property (nonatomic, strong) NSString *porcentajeAvance;
@property (nonatomic, strong) NSURL *fotoAntesURL;
@property (nonatomic, strong) NSURL *fotoDuranteURL;
@property (nonatomic, strong) NSURL *fotoDespuesURL;
@property (nonatomic, strong) NSDate *fechaModificacion;
@property (nonatomic, strong) NSString *tipoMoneda;
@property (nonatomic, strong) NSString *inaugurada;
@property (nonatomic, strong) NSString *poblacionObjetivo;
@property (nonatomic, strong) NSString *municipio;
@property (nonatomic, strong) Subclasificacion *subclasificacion;

+ (NSDictionary *)JSONKeyPathsByPropertyKey;




@end
