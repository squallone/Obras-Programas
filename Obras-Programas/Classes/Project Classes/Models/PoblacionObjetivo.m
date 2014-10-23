//
//  PoblacionObjetivo.m
//  Obras-Programas
//
//  Created by Abdiel on 10/22/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "PoblacionObjetivo.h"

@implementation PoblacionObjetivo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"idPoblacion"                 :@"idPoblacion",
             @"nombrePoblacionObjetivo"     :@"nombrePoblacionObjetivo"
             };
}

@end
