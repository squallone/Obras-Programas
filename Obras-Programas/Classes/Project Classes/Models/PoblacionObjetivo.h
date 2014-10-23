//
//  PoblacionObjetivo.h
//  Obras-Programas
//
//  Created by Abdiel on 10/22/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface PoblacionObjetivo : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *idPoblacion;
@property (nonatomic, strong) NSString *nombrePoblacionObjetivo;

@end
