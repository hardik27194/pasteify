//
//  ImageCopperView.m
//  PerfectImageCropper
//
//  Created by Jin Huang on 11/22/12.
//
//

#import <QuartzCore/QuartzCore.h>
#import <math.h>
#import "ManiputableImageView.h"
#import "UIImage+Manipulation.h"
#import "CALayer+RenderSubframe.h"

@interface ManiputableImageView()
{
    @private
    //CGSize _originalImageViewSize;
}

@property (nonatomic, retain) UIImageView *imageView;
@end

@implementation ManiputableImageView
@synthesize imageView, image = _image, delegate;

- (void)setup
{
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    // ImageView subview
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
    // Gesture Recgonizersss
    UIRotationGestureRecognizer *rotateGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateImage:)];
    [imageView addGestureRecognizer:rotateGes];
    
    UIPinchGestureRecognizer *scaleGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImage:)];
    [imageView addGestureRecognizer:scaleGes];
    
    UIPanGestureRecognizer *moveGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
    [moveGes setMinimumNumberOfTouches:1];
    [moveGes setMaximumNumberOfTouches:1];
    [imageView addGestureRecognizer:moveGes];
    
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		self.frame = frame;
        [self setup];
	}
	
	return self;
}

float _lastTransX = 0.0, _lastTransY = 0.0;
- (void)moveImage:(UIPanGestureRecognizer *)sender
{
    CGPoint translatedPoint = [sender translationInView:self];

    if([sender state] == UIGestureRecognizerStateBegan) {
        _lastTransX = 0.0;
        _lastTransY = 0.0;
    }
    
    CGAffineTransform trans = CGAffineTransformMakeTranslation(translatedPoint.x - _lastTransX, translatedPoint.y - _lastTransY);
    CGAffineTransform newTransform = CGAffineTransformConcat(imageView.transform, trans);
    _lastTransX = translatedPoint.x;
    _lastTransY = translatedPoint.y;
    
    imageView.transform = newTransform;
}

float _lastScale = 1.0;
- (void)scaleImage:(UIPinchGestureRecognizer *)sender
{
    if([sender state] == UIGestureRecognizerStateBegan) {
        
        _lastScale = 1.0;
        return;
    }
    
    CGFloat scale = [sender scale]/_lastScale;
    
    CGAffineTransform currentTransform = imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [imageView setTransform:newTransform];
    
    _lastScale = [sender scale];
}

float _lastRotation = 0.0;
- (void)rotateImage:(UIRotationGestureRecognizer *)sender
{
    if([sender state] == UIGestureRecognizerStateEnded) {
        
        _lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = -_lastRotation + [sender rotation];
    
    CGAffineTransform currentTransform = imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    [imageView setTransform:newTransform];
    
    _lastRotation = [sender rotation];
    
}

- (void)setImage:(UIImage *)image
{
    if (_image != image) {
        _image = image;
    }
    if (!_image)
        return;
    
    float _imageScale = self.frame.size.width / image.size.width;
    self.imageView.frame = CGRectMake(0, 0, image.size.width*_imageScale, image.size.height*_imageScale);
    imageView.image = image;
    imageView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    
    //imageView.layer.borderWidth = 5;
}

- (void) combineWithImage:(UIImage *)background fromView:(UIImageView *)backgroundImageView{
    
    UIImage *foreground = [self.layer renderWithBounds:aspectRectangle(background.size, backgroundImageView.bounds.size)];
    
    foreground = [foreground imageScaledByFactor:background.size.width/backgroundImageView.bounds.size.width];
    
    UIImage *mergedImage = [foreground mergeOntoImage:background];
    
    // Notify the delegate
    [delegate imageCropper:self didFinishCombiningImages:mergedImage];

}

- (void)reset
{
    self.imageView.transform = CGAffineTransformIdentity;
}

@end
