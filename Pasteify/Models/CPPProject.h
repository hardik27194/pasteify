//
//  CPPProject.h
//  Clippr
//
//  Created by Bradley Bain on 12/1/13.
//  Copyright (c) 2013 Bradley Bain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPPProject : NSObject <NSCopying>

@property (copy, nonatomic) UIImage *background;
@property (copy, nonatomic) UIImage *foreground;
@property (copy, nonatomic) UIImage *combinedImage;

@end
