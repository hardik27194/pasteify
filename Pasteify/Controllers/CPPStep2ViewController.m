//
//  CPPEditStep2ViewController.m
//  Clippr
//
//  Created by Bradley Bain on 12/6/13.
//  Copyright (c) 2013 Bradley Bain. All rights reserved.
//

#import "CPPStep2ViewController.h"

#import "CPPProject.h"
#import "CPPCurrentProjectService.h"

@interface CPPStep2ViewController()
@property (weak, nonatomic) IBOutlet UIToolbar *optionsBar;
@property (weak, nonatomic) IBOutlet UIView *instructionPopover;
@property (weak, nonatomic) IBOutlet UIButton *tutorialOkButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *resetBarButtonItem;
@property (weak, nonatomic) IBOutlet JBCroppableImageView *foregroundImageView;

- (IBAction)resetButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)tutorialOkButtonPressed:(id)sender;
- (IBAction)addDotButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)doubleTapGestureRecognized:(UITapGestureRecognizer *)sender;
@end

@implementation CPPStep2ViewController

#pragma mark - Navigational Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    // Draw the foreground
    CPPProject *project = [CPPCurrentProjectService project];
    self.foregroundImageView.image = project.foreground;
    
    // Ensure the tutorial is only displayed if necessary
    self.instructionPopover.hidden = YES;
    self.tutorialOkButton.hidden = YES;
    if(!project.foreground) {
        // Round the corners of the tutorial
        self.instructionPopover.layer.cornerRadius = 5;
        self.instructionPopover.layer.masksToBounds = YES;
        self.instructionPopover.hidden = NO;
    }
    
    // Disable swipe back gesture - http://stackoverflow.com/questions/17209468/how-to-disable-back-swipe-gesture-in-uinavigationcontroller-on-ios-7
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && [self.view window] == nil) {
        self.view = nil;
    }
}

#pragma mark - Navigation
- (void)viewDidDisappear:(BOOL)animated {
    // Clean up memory-hogging photos
    self.foregroundImageView.image = nil;
}


#pragma mark - User Interaction
- (IBAction)gestureRecognizerLongPress:(UILongPressGestureRecognizer *)sender {
    // Allow the user to select a photo
    UIImagePickerController *imagePicker =[[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

-(IBAction)resetButtonPressed:(UIBarButtonItem *)sender {
    if([sender.title isEqualToString:@"Reset Image"]) {
        [self.foregroundImageView reverseCrop];
        [self.resetBarButtonItem setTitle:nil];
    }
    else if([sender.title isEqualToString:@"Remove Dot"])
        [self.foregroundImageView removePoint];
}

- (IBAction)tutorialOkButtonPressed:(id)sender {
    // Hide the tutorial so everyone can get on with their life
    self.instructionPopover.hidden = YES;
}

- (IBAction)addDotButtonPressed:(UIBarButtonItem *)sender {
    [self.foregroundImageView addPoint];
    [self.resetBarButtonItem setTitle:@"Remove Dot"];
}

- (IBAction)doubleTapGestureRecognized:(UITapGestureRecognizer *)sender {
    [self.foregroundImageView crop];
    [self.resetBarButtonItem setTitle:@"Reset Image"];
}

#pragma mark - UIImagePickerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Get the selected image
    UIImage* foreground = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // Update the UIImageView
    CPPProject *project = [CPPCurrentProjectService project];
    project.foreground = foreground;
    self.foregroundImageView.image = foreground;
    [self.foregroundImageView setNeedsDisplay];
    
    // Update the tutorial and display the ok button
    UILabel *helpText = (UILabel *)[self.instructionPopover.subviews objectAtIndex:0];
    [helpText setNumberOfLines:5];
    [helpText setText:@"Surround what you want to keep. Double tap when you're done."];
    self.tutorialOkButton.hidden = NO;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIImage *editedForegroundImage = [self.foregroundImageView getCroppedImage];
    
    if(editedForegroundImage)
        [[CPPCurrentProjectService project] setForeground:editedForegroundImage];
}


@end
