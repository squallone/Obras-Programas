//
//  DBHelper.h
//  Obras-Programas
//
//  Created by Abdiel on 10/11/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Obra.h"
#import "Programa.h"
#import "Consulta.h"

@interface DBHelper : NSObject

+(void)saveObra:(Obra *)obra;
+(NSArray *)getAllObras;
+(void)saveConsulta:(Consulta *)consulta;
+(NSArray *)getAllQueriesSaved;

+(void)savePrograma:(Programa *)obra;
+(NSArray *)getAllProgramas;

@end
