//
//  CPPEditStep1ViewController.m
//  Clippr
//
//  Created by Bradley Bain on 12/1/13.
//  Copyright (c) 2013 Bradley Bain. All rights reserved.
//

#import "CPPStep1ViewController.h"
#import "CPPTipView.h"

@interface CPPStep1ViewController () {
    CPPTipView *popover;
}
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
- (IBAction)gestureRecognizerLongPress:(UILongPressGestureRecognizer *)sender;
@end

@implementation CPPStep1ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && [self.view window] == nil) {
        self.view = nil;
    }
}

#pragma -
#pragma Navigational Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    popover = [[CPPTipView alloc] initInFrame:self.view.frame];
    popover.text = @"Tap and hold to select a background";
    [self.view addSubview:popover];
}

-(void) viewWillAppear:(BOOL)animated {
    CPPProject *project = [CPPCurrentProjectService project];
    self.backgroundImageView.image = project.background;
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (void)viewDidDisappear:(BOOL)animated {
    // Clean up memory-hogging photos
    self.backgroundImageView.image = nil;
}

#pragma mark - UI Event Handlers

- (IBAction)gestureRecognizerLongPress:(UILongPressGestureRecognizer *)sender {
    UIImagePickerController *imagePicker =[[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];

}


#pragma mark - UIImagePickerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Get the background image
    CPPProject *project = [CPPCurrentProjectService project];
    project.background = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // Hide the popover
    [popover close];
    
    // Display the background image
    self.backgroundImageView.image = project.background;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

