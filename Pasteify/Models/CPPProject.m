//
//  CPPProject.m
//  Clippr
//
//  Created by Bradley Bain on 12/1/13.
//  Copyright (c) 2013 Bradley Bain. All rights reserved.
//

#import "CPPProject.h"

@implementation CPPProject

#pragma mark - Initialization
-(id) init {
    self = [super init];
    if(self) {
        
    }
    return self;
}

#pragma mark - Copying
- (id)copyWithZone:(NSZone *)zone {
    CPPProject *copy = [[CPPProject alloc] init];
    copy.background = self.background;
    copy.foreground = self.foreground;
    copy.combinedImage = self.combinedImage;
    
    return copy;
}

@end
