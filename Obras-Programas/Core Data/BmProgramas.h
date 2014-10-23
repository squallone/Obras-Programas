//
//  BmProgramas.h
//  Obras-Programas
//
//  Created by Abdiel on 10/22/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Programa.h"


@interface BmProgramas : NSManagedObject

@property (nonatomic, retain) Programa *programaData;

@end
