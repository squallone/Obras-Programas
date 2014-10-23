//
//  Programa.m
//  Obras-Programas
//
//  Created by Abdiel on 9/25/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "Programa.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation Programa

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    [super JSONKeyPathsByPropertyKey];
    return @{
             @"tipoApoyo"           :@"tipoApoyo",
             @"idPrograma"          :@"idPrograma",
             @"anoPrograma"         :@"anoPrograma",
             @"absoluto"            :@"absoluto",
             @"lineaBase"           :@"lineaBase",
             @"poblacion"           :@"poblacionObjetivoProgramas",
             @"metaBeneficiarios"   :@"metaBeneficiarios",
             @"montoDeApoyo"        :@"montoDeApoyo",
             @"nombrePrograma"      :@"nombrePrograma",
             @"porcentual"          :@"porcentual",
             @"totalMunicipios"     :@"totalMunicipios",
             };
}


+ (NSValueTransformer *)tipoApoyoJSONTransformer
{
    // tell Mantle to populate appActions property with an array of ChoosyAppAction objects
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TipoApoyo class]];
}

+ (NSValueTransformer *)poblacionJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PoblacionObjetivo class]];
}



@end
