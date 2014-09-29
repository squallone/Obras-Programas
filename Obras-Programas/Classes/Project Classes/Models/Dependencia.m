//
//  Dependencia.m
//  Obras-Programas
//
//  Created by Abdiel on 9/29/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "Dependencia.h"

@implementation Dependencia

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"idDependencia"    :kKeyDbIdDependencia,
             @"nombreDependencia":kKeyDbNombreDependencia
             };
}


@end
