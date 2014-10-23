//
//  BmObras.h
//  Obras-Programas
//
//  Created by Abdiel on 10/11/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Obra.h"

@interface BmObras : NSManagedObject

@property (nonatomic, retain) Obra *obraData;

@end
