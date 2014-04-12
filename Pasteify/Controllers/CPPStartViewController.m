//
//  CPPStartViewController.m
//  Pasteify
//
//  Created by Bradley Bain on 3/3/14.
//  Copyright (c) 2014 Bradley Bain. All rights reserved.
//

#import "CPPStartViewController.h"
#import "OLImage.h"
#import "OLImageView.h"

@interface CPPStartViewController ()
{
    UIImage *demoGif;
}
@property (weak, nonatomic) IBOutlet OLImageView *demoImageView;

@end

@implementation CPPStartViewController

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
}

- (void)viewWillAppear:(BOOL)animated {
    if(!demoGif) {
        NSString *imageFile = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"gif"];
        demoGif = [OLImage imageWithContentsOfFile:imageFile];
        
        self.demoImageView.image = demoGif;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && [self.view window] == nil) {
        self.view = nil;
    }
}

- (IBAction)unwindToStart:(UIStoryboardSegue *)unwindSegue
{
}

- (void)viewDidDisappear:(BOOL)animated {
    // Clean up memory-hogging photos
    demoGif = nil;
    self.demoImageView.image = nil;
}

@end
