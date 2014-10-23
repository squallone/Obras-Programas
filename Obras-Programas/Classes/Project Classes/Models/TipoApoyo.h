//
//  TipoApoyo.h
//  Obras-Programas
//
//  Created by Abdiel on 10/22/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface TipoApoyo : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *idTipoApoyo;
@property (nonatomic, strong) NSString *nombreTipoApoyo;

@end
