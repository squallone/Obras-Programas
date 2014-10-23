//
//  DBHelper.m
//  Obras-Programas
//
//  Created by Abdiel on 10/11/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "DBHelper.h"
#import "BmConsultas.h"

@implementation DBHelper

+(void)saveObra:(Obra *)obra{
    
    NSManagedObjectContext *context =  [kAppDelegate managedObjectContext];
    NSManagedObject *newContact;
    
    newContact = [NSEntityDescription insertNewObjectForEntityForName:@"BmObras" inManagedObjectContext:context];
    [newContact setValue:obra forKey:@"obraData"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [kAppDelegate notShowActivityIndicator:M13ProgressViewActionFailure whithMessage:@"Obra no guardada\nintentalo de nuevo" delay:1.0];
    }
}

+(NSArray *)getAllObras{
    
    NSManagedObjectContext *context =  [kAppDelegate managedObjectContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BmObras" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    NSArray *obras = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *results = [NSMutableArray new];
    
    for (int i=0; i<[obras count]; i++) {
        NSManagedObject *managedObject = [obras objectAtIndex:i];
        [results addObject:[managedObject valueForKey:@"obraData"]];
    }    
    return results;
}

+(void)savePrograma:(Programa *)programa{
    
    NSManagedObjectContext *context =  [kAppDelegate managedObjectContext];
    NSManagedObject *newContact;
    
    newContact = [NSEntityDescription insertNewObjectForEntityForName:@"BmProgramas" inManagedObjectContext:context];
    [newContact setValue:programa forKey:@"programaData"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [kAppDelegate notShowActivityIndicator:M13ProgressViewActionFailure whithMessage:@"Programa no guardado\nintentalo de nuevo" delay:1.0];
    }
}

+(NSArray *)getAllProgramas{
    
    NSManagedObjectContext *context =  [kAppDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BmProgramas" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    NSArray *obras = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *results = [NSMutableArray new];
    
    for (int i=0; i<[obras count]; i++) {
        NSManagedObject *managedObject = [obras objectAtIndex:i];
        [results addObject:[managedObject valueForKey:@"programaData"]];
    }
    return results;
}

+(void)saveConsulta:(Consulta *)consulta{
    
    NSManagedObjectContext *context =  [kAppDelegate managedObjectContext];
    NSManagedObject *newContact;
    
    newContact = [NSEntityDescription insertNewObjectForEntityForName:@"BmConsultas" inManagedObjectContext:context];
    [newContact setValue:consulta forKey:@"consultaData"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [kAppDelegate notShowActivityIndicator:M13ProgressViewActionFailure whithMessage:@"Consulta no guardada\nintentalo de nuevo" delay:1.0];
    }
}

+(NSArray *)getAllQueriesSaved{
    
    NSManagedObjectContext *context =  [kAppDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BmConsultas" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    NSArray *obras = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *results = [NSMutableArray new];
    
    for (int i=0; i<[obras count]; i++) {
        NSManagedObject *managedObject = [obras objectAtIndex:i];
        [results addObject:[managedObject valueForKey:@"consultaData"]];
        
    }
    return results;
}

@end
