//
//  Estado.m
//  Obras-Programas
//
//  Created by Abdiel on 9/26/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "Estado.h"

@implementation Estado

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"idEstado"    :kKeyDbIdEstado,
             @"nombreEstado":kKeyDbNombreEstado,
             @"latitud"     :kKeyDbLatitud,
             @"longitud"    :kKeyDbLongitud
             };
}

@end
