//
//  ObraProgramaCell.h
//  Obras-Programas
//
//  Created by Abdiel on 10/5/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface ObraProgramaCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblDenominacion;
@property (weak, nonatomic) IBOutlet UILabel *lblIdObraPrograma;
@property (weak, nonatomic) IBOutlet UILabel *lblEstado;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end
