//
//  MPMovieViewController.m
//  Inari
//
//  Created by Abdiel on 9/3/14.
//  Copyright (c) 2014 Smartthinking. All rights reserved.
//

#import "MPMovieViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MPMovieViewController ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

@end

@implementation MPMovieViewController



- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"video" ofType:@"mp4"];
    
    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:path]];
    // Rotating the player to landscape position
    _moviePlayer.controlStyle = MPMovieControlStyleFullscreen;

    if (!kIs_iPad) {
        _moviePlayer.view.frame = CGRectMake(0.0f,
                                             0.0f,
                                             self.view.frame.size.height,
                                             self.view.frame.size.width);
        NSLog(@"%@", NSStringFromCGRect(_moviePlayer.view.frame));
        _moviePlayer.view.transform =  CGAffineTransformMakeRotation(M_PI_2);
    }else{
        _moviePlayer.view.frame = self.view.frame;
    }
    
    [_moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
    _moviePlayer.view.center = self.view.center;
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer play];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (void) moviePlayerWillEnterFullscreenNotification:(NSNotification*)notification {


}
- (void) moviePlayerWillExitFullscreenNotification:(NSNotification*)notification {
    
    
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerPlaybackDidFinishNotification
                                                 object:player];
    if ([player respondsToSelector:@selector(setFullscreen:animated:)]) [player.view removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration{
    
    if (kIs_iPad) {
        if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||  toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
            _moviePlayer.view.frame = CGRectMake(0, 0, 1024, 768);
        }else{
            _moviePlayer.view.frame = CGRectMake(0, 0, 768, 1024);
        }
    }
}

@end
