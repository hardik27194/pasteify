//
//  ImageCopperView.h
//  PerfectImageCropper
//
//  Created by Jin Huang on 11/22/12.
//
//

#import <UIKit/UIKit.h>

@protocol ManiputableImageDelegate;

@interface ManiputableImageView : UIView {
	UIImageView *imageView;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, assign) id <ManiputableImageDelegate> delegate;

- (void)setup;
- (void) combineWithImage:(UIImage *)background fromView:(UIImageView*)backgroundImageView;
- (void)reset;

@end

@protocol ManiputableImageDelegate <NSObject>
- (void)imageCropper:(ManiputableImageView *)cropper didFinishCombiningImages:(UIImage *)finalImage;
@end