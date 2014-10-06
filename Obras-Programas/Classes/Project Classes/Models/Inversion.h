//
//  Inversion.h
//  Obras-Programas
//
//  Created by Abdiel on 10/5/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Inversion : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) NSString *idTipoInversion;

@end
