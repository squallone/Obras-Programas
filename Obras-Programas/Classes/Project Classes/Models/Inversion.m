//
//  Inversion.m
//  Obras-Programas
//
//  Created by Abdiel on 10/5/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "Inversion.h"

@implementation Inversion

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"idTipoInversion" :kKeyDbIdTipoInversion,
             @"nombre"          :kKeyDbNombreTipoInversion,
             };
}

@end
