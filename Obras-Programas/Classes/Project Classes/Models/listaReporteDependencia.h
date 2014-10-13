//
//  listaReporteDependencia.h
//  Obras-Programas
//
//  Created by Abdiel on 10/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "Dependencia.h"

@interface ListaReporteDependencia : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *numeroObras;
@property (nonatomic, strong) NSString *totalInvertido;
@property (nonatomic, strong) Dependencia *dependencia;
@end
