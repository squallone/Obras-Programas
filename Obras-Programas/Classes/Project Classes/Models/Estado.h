//
//  Estado.h
//  Obras-Programas
//
//  Created by Abdiel on 9/26/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Estado : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *idEstado;
@property (nonatomic, strong) NSString *nombreEstado;
@property (nonatomic, strong) NSString *latitud;
@property (nonatomic, strong) NSString *longitud;

@end
