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
#import "MWPhotoBrowser.h"

@interface FichaTecnicaViewController () <MWPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imagenBanner;
@property (weak, nonatomic) IBOutlet UIImageView *imagenLogo;
@property (weak, nonatomic) IBOutlet UIImageView *imagenLogoDependencia;

@property (strong, nonatomic) IBOutlet UIImageView *imagenAntes;
@property (strong, nonatomic) IBOutlet UIImageView *imagenDurante;
@property (strong, nonatomic) IBOutlet UIImageView *imagenDespues;

@property (nonatomic, strong) NSMutableArray *photosMW;
@property (nonatomic, strong) MWPhotoBrowser *browser;



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
    
    _photosMW = [NSMutableArray array];
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
        _secondColumn.inversionesData = _inversionesData;
        _secondColumn.clasificacionesData = _clasificacionesData;

    }else
    if ([segueName isEqualToString: @"thirdColumnSegue"]) {
        _thirdColumn = (ThirdColumnTableViewController*) [segue destinationViewController];
        _thirdColumn.obra = _obra;
        _thirdColumn.programa = self.programa;

    }
}

-(void)firstImagePressed{
    NSLog(@"first");
    [self presentGallery:0];
}

-(void)secondImagePressed{
    NSLog(@"Second");
    [self presentGallery:1];

}
-(void)thirdImagePressed{
    NSLog(@"Third");
    [self presentGallery:2];

}
-(void) setupScrollView {
    //add the scrollview to the view
    scrollView = [[UIScrollView alloc] initWithFrame:scrollView.frame];

    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    [scrollView setAlwaysBounceVertical:NO];
    scrollView.backgroundColor = [UIColor clearColor];
    //setup internal views
    
    
    
    NSInteger numberOfViews = 3;
    for (int i = 0; i < numberOfViews; i++) {
        CGFloat xOrigin = i * scrollView.frame.size.width;
        UIImageView *image = [[UIImageView alloc] initWithFrame:
                              CGRectMake(xOrigin, 0,
                                         scrollView.frame.size.width,
                                         scrollView.frame.size.height)];
        
        
        
        if(i==0)
        {
            image.userInteractionEnabled =YES;
            [image setImageWithURL:self.obra.fotoAntesURL placeholderImage:[UIImage imageNamed:kImageNamePlaceHolder] options:SDWebImageRefreshCached usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstImagePressed)];
            [singleTap setNumberOfTapsRequired:1];
            [image addGestureRecognizer:singleTap];
            
            UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 121, 300 , 20)];
            lblTitle.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f];
            
            lblTitle.text = @"Antes";
            //[lblTitle setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
            [lblTitle setTextColor:[UIColor whiteColor]];
            lblTitle.textAlignment = NSTextAlignmentCenter;

            [image addSubview:lblTitle];
            
            MWPhoto *photo = [MWPhoto photoWithURL:self.obra.fotoAntesURL];
            photo.caption =  lblTitle.text;
            [_photosMW addObject:photo];

        }
        
        else if (i==1){
            image.userInteractionEnabled =YES;
            [image setImageWithURL:self.obra.fotoDuranteURL placeholderImage:[UIImage imageNamed:kImageNamePlaceHolder] options:SDWebImageRefreshCached usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondImagePressed)];
            [singleTap setNumberOfTapsRequired:1];
            [image addGestureRecognizer:singleTap];
            
            UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 121, 300 , 20)];
            lblTitle.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f];
            
            lblTitle.text = @"Durante";
            //[lblTitle setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
            [lblTitle setTextColor:[UIColor whiteColor]];
            lblTitle.textAlignment = NSTextAlignmentCenter;
            [image addSubview:lblTitle];
            
            MWPhoto *photo = [MWPhoto photoWithURL:self.obra.fotoDuranteURL];
            photo.caption =  lblTitle.text;
            [_photosMW addObject:photo];

        }
        else if (i==2){
            image.userInteractionEnabled =YES;
            [image setImageWithURL:self.obra.fotoDespuesURL placeholderImage:[UIImage imageNamed:kImageNamePlaceHolder] options:SDWebImageRefreshCached usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdImagePressed)];
            [singleTap setNumberOfTapsRequired:1];
            [image addGestureRecognizer:singleTap];
            
            UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 121, 300 , 20)];
            lblTitle.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f];
            
            lblTitle.text = @"Despues";
            //[lblTitle setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
            [lblTitle setTextColor:[UIColor whiteColor]];
            lblTitle.textAlignment = NSTextAlignmentCenter;
            
            [image addSubview:lblTitle];
            
            MWPhoto *photo = [MWPhoto photoWithURL:self.obra.fotoDespuesURL];
            photo.caption =  lblTitle.text;
            [_photosMW addObject:photo];

        }
        image.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:image];
    }
    //set the scroll view content size
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width *
                                             numberOfViews,
                                             scrollView.frame.size.height);
    //add the scrollview to this view
    [self.view addSubview:scrollView];
}


-(void)presentGallery:(int)index{
    /********** Photo Browser ***************/
    
    _browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    _browser.displayActionButton = YES;
    _browser.displayNavArrows = YES;
    _browser.zoomPhotosToFill = YES;
    _browser.enableGrid = YES;
    _browser.startOnGrid = NO;
    [_browser setCurrentPhotoIndex:index];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:_browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:nc animated:YES completion:nil];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photosMW.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photosMW.count)
        
        return [self.photosMW objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < self.photosMW.count)
        
        return [self.photosMW objectAtIndex:index];
    return nil;
}


#pragma mark - Navigation



@end
