//
//  Subclasificacion.m
//  Obras-Programas
//
//  Created by Abdiel on 10/29/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "Subclasificacion.h"

@implementation Subclasificacion

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"idSubClasificacion"      :@"idSubClasificacion",
             @"idTipoClasificacion"     :@"idTipoClasificacion",
             @"nombreSubclasificacion"  :@"nombreSubclasificacion"
             };
}

@end
