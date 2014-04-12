//
//  UIView+RenderSubframe.h
//  Pasteify
//
//  Created by Bradley Bain on 1/12/14.
//  Copyright (c) 2014 Bradley Bain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALayer (RenderSubframe)
- (UIImage *) renderWithBounds:(CGRect)frame;
@end
