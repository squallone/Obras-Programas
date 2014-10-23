//
//  FirstColumnTableViewController.h
//  Prueba Graficas
//
//  Created by Pedro Contreras Nava on 06/10/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Obra;
@class Programa;

@interface FirstColumnTableViewController : UITableViewController

@property (strong,nonatomic) Obra *obra;
@property (strong,nonatomic) Programa *programa;

@end
