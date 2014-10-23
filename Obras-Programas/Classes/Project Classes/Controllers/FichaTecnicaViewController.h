//
//  FichaTecnicaViewController.h
//  Obras-Programas
//
//  Created by Pedro Contreras Nava on 10/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Obra;
@class Programa;
@interface FichaTecnicaViewController : UIViewController <UIScrollViewDelegate>
@property (strong,nonatomic) Obra *  obra;
@property (strong,nonatomic) Programa *programa;

@end
