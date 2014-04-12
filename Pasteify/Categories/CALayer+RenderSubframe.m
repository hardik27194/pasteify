//
//  UIView+RenderSubframe.m
//  Pasteify
//
//  Created by Bradley Bain on 1/12/14.
//  Copyright (c) 2014 Bradley Bain. All rights reserved.
//

#import "CALayer+RenderSubframe.h"
#import <QuartzCore/QuartzCore.h>

@implementation CALayer (RenderSubframe)

- (UIImage *) renderWithBounds:(CGRect)frame {
    
    CGSize imageSize = frame.size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextConcatCTM(c, CGAffineTransformMakeTranslation(-frame.origin.x, -frame.origin.y));
    [self renderInContext:c];
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
    
}

@end
