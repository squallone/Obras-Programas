//
//  Dependencia.h
//  Obras-Programas
//
//  Created by Abdiel on 9/29/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Dependencia : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *idDependencia;
@property (nonatomic, strong) NSString *nombreDependencia;

@end
