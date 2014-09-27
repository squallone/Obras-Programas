//
//  Impacto.m
//  Obras-Programas
//
//  Created by Abdiel on 9/26/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "Impacto.h"

@implementation Impacto

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"idImpacto"    :kKeyDbIdImpacto,
             @"nombreImpacto":kKeyDbNombreImpacto
             };
}

@end
