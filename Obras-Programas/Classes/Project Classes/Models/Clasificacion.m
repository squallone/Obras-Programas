//
//  Clasificacion.m
//  Obras-Programas
//
//  Created by Abdiel on 9/26/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "Clasificacion.h"

@implementation Clasificacion

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"idTipoClasificacion"    :kKeyDbIdClasificacion,
             @"nombreTipoClasificacion":kKeyDbNombreClasificacion
             };
}


@end
