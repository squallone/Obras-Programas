//
//  FichaTecnicaViewController.m
//  Obras-Programas
//
//  Created by Pedro Contreras Nava on 10/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "FichaTecnicaViewController.h"
#import "Obra.h"
#import "FirstColumnTableViewController.h"
#import "SecondColumnTableViewController.h"
#import "ThirdColumnTableViewController.h"
#import "SDWebImageManager.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "Programa.h"

@interface FichaTecnicaViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imagenBanner;
@property (weak, nonatomic) IBOutlet UIImageView *imagenLogo;
@property (weak, nonatomic) IBOutlet UIImageView *imagenLogoDependencia;

@property (weak, nonatomic) IBOutlet UIImageView *imagenAntes;
@property (weak, nonatomic) IBOutlet UIImageView *imagenDurante;
@property (weak, nonatomic) IBOutlet UIImageView *imagenDespues;



@property FirstColumnTableViewController *firstColumn;
@property SecondColumnTableViewController *secondColumn;
@property ThirdColumnTableViewController *thirdColumn;
@property (strong , nonatomic) IBOutlet UIScrollView *imagesContainer;

@end

@implementation FichaTecnicaViewController
@synthesize obra = _obra;
@synthesize firstColumn = _firstColumn;
@synthesize secondColumn = _secondColumn;
@synthesize thirdColumn = _thirdColumn;
@synthesize imagesContainer = scrollView;


- (void)viewDidLoad {
    [super viewDidLoad];
    if (_obra !=nil) {
        [_imagenLogoDependencia setImageWithURL:self.obra.dependencia.imagenDependencia placeholderImage:[UIImage imageNamed:kImageNamePlaceHolder] options:SDWebImageRefreshCached usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }else{
        [_imagenLogoDependencia setImageWithURL:self.programa.dependencia.imagenDependencia placeholderImage:[UIImage imageNamed:kImageNamePlaceHolder] options:SDWebImageRefreshCached usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    }
    [self setupScrollView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"firstColumnSegue"]) {
        _firstColumn = (FirstColumnTableViewController*) [segue destinationViewController];
        _firstColumn.obra = _obra;
        _firstColumn.programa = self.programa;
    }else
    if ([segueName isEqualToString: @"secondColumnSegue"]) {
        _secondColumn = (SecondColumnTableViewController*) [segue destinationViewController];
        _secondColumn.obra = _obra;
        _secondColumn.programa = self.programa;

    }else
    if ([segueName isEqualToString: @"thirdColumnSegue"]) {
        _thirdColumn = (ThirdColumnTableViewController*) [segue destinationViewController];
        _thirdColumn.obra = _obra;
        _thirdColumn.programa = self.programa;

    }
}


-(void) setupScrollView {
    // Adjust scroll view content size, set background colour and turn on paging
    [_imagenAntes setImageWithURL:self.obra.fotoAntesURL placeholderImage:[UIImage imageNamed:kImageNamePlaceHolder] options:SDWebImageRefreshCached usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [_imagenDurante setImageWithURL:self.obra.fotoDuranteURL placeholderImage:[UIImage imageNamed:kImageNamePlaceHolder] options:SDWebImageRefreshCached usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [_imagenDespues setImageWithURL:self.obra.fotoDespuesURL placeholderImage:[UIImage imageNamed:kImageNamePlaceHolder] options:SDWebImageRefreshCached usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 12,
                                        scrollView.frame.size.height);
    scrollView.pagingEnabled=YES;
    scrollView.backgroundColor = [UIColor blackColor];
    
    // Generate content for our scroll view using the frame height and width as the reference point
    
    
    [scrollView addSubview:_imagenAntes];
    [scrollView addSubview:_imagenDurante];
    [scrollView addSubview:_imagenDespues];
    
    
}


#pragma mark - Navigation



@end
