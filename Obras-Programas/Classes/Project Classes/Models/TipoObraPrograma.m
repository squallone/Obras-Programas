//
//  TipoObraPrograma.m
//  Obras-Programas
//
//  Created by Abdiel on 9/26/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "TipoObraPrograma.h"

@implementation TipoObraPrograma

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"idTipoObra"      :kKeyDbIdTipoObra,
             @"nombreTipoObra"  :kKeyDbNombreTipoObra,
             };
}

@end
