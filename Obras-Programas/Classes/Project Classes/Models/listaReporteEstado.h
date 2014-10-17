//
//  listaReporteEstado.h
//  Obras-Programas
//
//  Created by Abdiel on 10/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "Estado.h"

@interface ListaReporteEstado : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *numeroObras;
@property (nonatomic, strong) NSNumber *totalInvertido;
@property (nonatomic, strong) Estado *estado;
@end
