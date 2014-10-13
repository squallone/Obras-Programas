//
//  DetailTableViewController.h
//  Obras-Programas
//
//  Created by Abdiel on 10/11/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewController : UITableViewController

-(id)initWithDataSource:(NSArray *)dataSource menuOption:(MenuOptions)option;

@end
