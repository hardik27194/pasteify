//
//  CPPStep3ViewController.m
//  Clippr
//
//  Created by Bradley Bain on 12/8/13.
//  Copyright (c) 2013 Bradley Bain. All rights reserved.
//

#import "CPPStep3ViewController.h"
#import "ManiputableImageView.h"
#import "CPPCurrentProjectService.h"
#import "CPPProject.h"

@interface CPPStep3ViewController ()
@property (weak, nonatomic) IBOutlet ManiputableImageView *manipulatorView;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *instructionPopover;
@property (weak, nonatomic) IBOutlet UIButton *tutorialOkButton;

- (IBAction)finishButtonTapped:(id)sender;
- (IBAction)tutorialOkButtonPressed:(id)sender;
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
}

- (void)viewWillAppear:(BOOL)animated {
    CPPProject *project = [CPPCurrentProjectService project];
    
    // Draw the background
    self.backgroundImageView.image = project.background;
    
    // Ensure the tutorial is only displayed if necessary
    self.instructionPopover.hidden = YES;
    self.tutorialOkButton.hidden = YES;
    if(![CPPCurrentProjectService project].combinedImage) {
        // Round the corners of the tutorial
        self.instructionPopover.layer.cornerRadius = 5;
        self.instructionPopover.layer.masksToBounds = YES;
        self.instructionPopover.hidden = NO;
        self.tutorialOkButton.hidden = NO;
    }
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

- (IBAction)tutorialOkButtonPressed:(id)sender {
    self.instructionPopover.hidden = YES;
}

#pragma  mark - ImageCropperDelegate Methods
-(void)imageCropper:(ManiputableImageView *)cropper didFinishCombiningImages:(UIImage *)finalImage {
    // Save the project
    CPPProject *project = [CPPCurrentProjectService project];
    project.combinedImage = finalImage;
    
    [self performSegueWithIdentifier:@"ToProjectViewSegue" sender:self];
}

@end
