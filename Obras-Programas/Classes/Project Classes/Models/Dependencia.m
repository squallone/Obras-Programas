//
//  Dependencia.m
//  Obras-Programas
//
//  Created by Abdiel on 9/29/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "Dependencia.h"
#import "MTLValueTransformer.h"

@implementation Dependencia

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"idDependencia"    :kKeyDbIdDependencia,
             @"nombreDependencia":kKeyDbNombreDependencia,
             @"imagenDependencia":@"imagenDependencia"

             };
}

+ (NSValueTransformer *)imagenDependenciaJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        NSURL *imageURL = nil;
        
        if (![str isEqualToString:@"null"]) {
            NSString *imageStrURL = [NSString stringWithFormat:@"%@%@%@", kAppURL, kAppImagenesDependencia, str];
            imageURL = [NSURL URLWithString:imageStrURL];
        }
        
        return imageURL;
        
    } reverseBlock:^(NSDate *date) {
        return @"";
    }];
}

@end
