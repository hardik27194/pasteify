//
//  UIImage+Rotation.m
//  PerfectImageCropper
//
//  Created by Jin Huang on 5/29/13.
//  Copyright (c) 2013 Jin Huang. All rights reserved.
//

#import "UIImage+Manipulation.h"
#import "UIImageView+GeometryConversion.h"

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};
CGRect aspectRectangle(CGSize original, CGSize maxRect) {
    /* return the rectangle which fits the entire image into the given rectangle while preserving aspect ratio */
    
    float hfactor = original.width / maxRect.width;
    float vfactor = original.height / maxRect.height;
    
    float factor = fmax(hfactor, vfactor);
    
    // Divide the size by the greater of the vertical or horizontal shrinkage factor
    float newWidth = original.width / factor;
    float newHeight = original.height / factor;
    
    // Then figure out if you need to offset it to center vertically or horizontally
    float leftOffset = (maxRect.width - newWidth) / 2;
    float topOffset = (maxRect.height - newHeight) / 2;
    
    CGRect newRect = CGRectMake(leftOffset, topOffset, newWidth, newHeight);
    return newRect;
}

@implementation UIImage (Scaling)
- (UIImage*)imageScaledByFactor:(CGFloat)scaleFactor {
    CGSize imageSize = CGSizeMake(self.size.width*scaleFactor, self.size.height*scaleFactor);
    
    UIGraphicsBeginImageContext(imageSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, imageSize.width/2, imageSize.height/2);
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextScaleCTM(bitmap, scaleFactor, scaleFactor);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end


@implementation UIImage (Masking)
-(UIBezierPath *) UIBezierPathCreateFromPoints:(NSArray *)points {
    UIBezierPath *clippingPath;
    CGMutablePathRef path = CGPathCreateMutable();
    if (points && points.count > 0) {
        CGPoint p = [(NSValue *)[points objectAtIndex:0] CGPointValue];
        CGPathMoveToPoint(path, nil, p.x, p.y);
        for (int i = 1; i < points.count; i++) {
            p = [(NSValue *)[points objectAtIndex:i] CGPointValue];
            CGPathAddLineToPoint(path, nil, p.x, p.y);
        }
    }
    clippingPath = [UIBezierPath bezierPathWithCGPath:path];
    CFRelease(path);
    
    return clippingPath;
}

-(UIImage *)maskToPathContainingPoints:(NSArray *)points inView:(UIImageView *)imageView{
    CGSize imageSize = self.size;
    UIImage *clippedImage;
    
    // Convert every point to the image's coordinate space
    NSMutableArray *pointsArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < points.count; i++) {
        CGPoint newPoint;
        [(NSValue *)[points objectAtIndex:i] getValue:&newPoint];
        newPoint = [imageView convertPointFromView:newPoint];
        
        [pointsArray addObject:([NSValue valueWithCGPoint:newPoint])];
    }
    
    // Create the path from the modified points
    UIBezierPath *path = [self UIBezierPathCreateFromPoints:pointsArray];
    
    // Clip the image to said path
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    [path addClip];
    [self drawAtPoint:CGPointZero];
    
    clippedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return clippedImage;
};

@end

@implementation UIImage (Merging)

-(UIImage *)mergeOntoImage:(UIImage *)background
{
    CGSize imageSize = background.size;
    UIImage *mergedImage;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // Draw the images onto eachother
    [background drawAtPoint:CGPointZero];
    [self drawAtPoint:CGPointZero];
    
    mergedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return mergedImage;
}
@end
