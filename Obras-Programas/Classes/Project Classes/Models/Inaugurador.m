//
//  Inaugurador.m
//  Obras-Programas
//
//  Created by Abdiel on 9/26/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "Inaugurador.h"


@implementation Inaugurador

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"idCargoInaugura"    :kKeyDbIdCargoInaugura,
             @"nombreCargoInaugura":kKeyDbNombreCargoInaugura,
             };
}

@end
