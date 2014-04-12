//
//  CPPTabViewController.m
//  Clippr
//
//  Created by Bradley Bain on 12/3/13.
//  Copyright (c) 2013 Bradley Bain. All rights reserved.
//

#import "CPPProjectViewController.h"

@interface CPPProjectViewController ()
{
    UIImage *result;
}
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackBarButton;

- (IBAction)shareBarButtonPress:(UIBarButtonItem *)sender;
@end

@implementation CPPProjectViewController

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
	// Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = self.goBackBarButton;
    
}

- (void)viewWillAppear:(BOOL)animated {
    CPPProject *project = [CPPCurrentProjectService project];
    result = project.combinedImage;
    
    self.backgroundImageView.image = result;
    [CPPCurrentProjectService flushProject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && [self.view window] == nil) {
        self.view = nil;
    }
}

- (IBAction)shareBarButtonPress:(UIBarButtonItem *)sender {
    NSArray *sharedItems = @[result];
    UIActivityViewController *shareView = [[UIActivityViewController alloc] initWithActivityItems:sharedItems
                                                                            applicationActivities:nil];
    
    [self presentViewController:shareView animated:YES completion:nil];
    

}
@end
