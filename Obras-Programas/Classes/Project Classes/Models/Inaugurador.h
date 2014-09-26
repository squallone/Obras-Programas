//
//  Inaugurador.h
//  Obras-Programas
//
//  Created by Abdiel on 9/26/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Inaugurador : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *idCargoInaugura;
@property (nonatomic, strong) NSString *nombreCargoInaugura;

@end
