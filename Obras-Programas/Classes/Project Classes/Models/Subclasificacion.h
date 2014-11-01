//
//  Subclasificacion.h
//  Obras-Programas
//
//  Created by Abdiel on 10/29/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Subclasificacion :MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *idSubClasificacion;
@property (nonatomic, strong) NSString *idTipoClasificacion;
@property (nonatomic, strong) NSString *nombreSubclasificacion;

@end
