//
//  GraficasViewController.h
//  Obras-Programas
//
//  Created by Pedro Contreras Nava on 14/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShinobiChart;
@class ChartsViewController;

@interface GraficasViewController : UIViewController {
    UIScrollView *myScrollView;
}

@property (nonatomic, strong) NSMutableArray *stateReportData;
@property (nonatomic, strong) NSMutableArray *dependenciesReportData;

@property ChartsViewController *chartController;
@end
