//
//  CPPStep3ViewController.m
//  Clippr
//
//  Created by Bradley Bain on 12/8/13.
//  Copyright (c) 2013 Bradley Bain. All rights reserved.
//

#import "CPPStep3ViewController.h"
#import "CPPCurrentProjectService.h"
#import "CPPProject.h"
#import "CPPTipView.h"
#import "ManiputableImageView.h"
#import "MPInterstitialAdController.h"

@interface CPPStep3ViewController ()
{
    CPPTipView *popover;
}
@property (weak, nonatomic) IBOutlet ManiputableImageView *manipulatorView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) MPInterstitialAdController *interstitial;

- (IBAction)finishButtonTapped:(id)sender;
@end

@implementation CPPStep3ViewController

@synthesize manipulatorView;

#pragma mark - Navigational Methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set this controller as the ImageCropperView's delegate
    
    [manipulatorView setup];
    manipulatorView.delegate = self;
    manipulatorView.image = [[CPPCurrentProjectService project] foreground];
    
    // Load the interstitial
    self.interstitial = [MPInterstitialAdController
                         interstitialAdControllerForAdUnitId:@"058d92d58fec4bf7a1785d97ba8d3328"];

    self.interstitial.delegate = self;
    [self.interstitial loadAd];
    
    // Initialize a popover
    popover = [[CPPTipView alloc] initInFrame:self.view.frame];
    [popover setText:@"Finally, drag, pinch, and rotate to position the photo!" andNumberOfLines:3];
    popover.isButton = YES;
    [self.view addSubview:popover];
}

- (void)viewWillAppear:(BOOL)animated {
    CPPProject *project = [CPPCurrentProjectService project];
    
    // Draw the background
    self.backgroundImageView.image = project.background;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && [self.view window] == nil) {
        self.view = nil;
    }
}

#pragma mark - UIGestureControl Methods
-(IBAction)finishButtonTapped:(id)sender {
    CPPProject *project = [CPPCurrentProjectService project];
    [manipulatorView combineWithImage:project.background fromView:self.backgroundImageView];
}

#pragma  mark - ImageCropperDelegate Methods
-(void)imageCropper:(ManiputableImageView *)cropper didFinishCombiningImages:(UIImage *)finalImage {
    // Save the project
    CPPProject *project = [CPPCurrentProjectService project];
    project.combinedImage = finalImage;
    
    if(self.interstitial.ready) {
        [self.interstitial showFromViewController:self];
    } else {
        [self performSegueWithIdentifier:@"ToProjectViewSegue" sender:self];
    }
}

#pragma mark - MoPub Delegate Methods
-(void) interstitialDidDisappear:(MPInterstitialAdController *)interstitial {
    // When the interstitial is closed, continue on
    [self performSegueWithIdentifier:@"ToProjectViewSegue" sender:self];
}

@end
