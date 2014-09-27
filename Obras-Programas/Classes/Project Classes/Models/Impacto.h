//
//  Impacto.h
//  Obras-Programas
//
//  Created by Abdiel on 9/26/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Impacto : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *idImpacto;
@property (nonatomic, strong) NSString *nombreImpacto;

@end
