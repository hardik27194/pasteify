//
//  UIImage+Rotation.h
//  PerfectImageCropper
//
//  Created by Jin Huang on 5/29/13.
//  Copyright (c) 2013 Jin Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
CGRect aspectRectangle(CGSize original, CGSize max);

@interface UIImage (Scaling)
- (UIImage*)imageScaledByFactor:(CGFloat)scaleFactor;
@end

@interface UIImage (Masking)
-(UIImage *)maskToPathContainingPoints:(NSArray *)points inView:(UIImageView *)imageView;
@end

@interface UIImage (Merging)
-(UIImage *)mergeOntoImage:(UIImage *)background;
@end