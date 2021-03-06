//
//  CPPStep3ViewController.h
//  Clippr
//
//  Created by Bradley Bain on 12/8/13.
//  Copyright (c) 2013 Bradley Bain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManiputableImageView.h"
#import "MPInterstitialAdController.h"

@interface CPPStep3ViewController : UIViewController <ManiputableImageDelegate, MPInterstitialAdControllerDelegate>
- (void)imageCropper:(ManiputableImageView *)cropper didFinishCombiningImages:(UIImage *)finalImage;
@end
