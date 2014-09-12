//
//  MainViewController.m
//  Obras-Programas
//
//  Created by Abdiel on 9/12/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "MainViewController.h"
@import MapKit.MKMapView;

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
