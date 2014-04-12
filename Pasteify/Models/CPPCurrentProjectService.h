//
//  CPPCurrentProjectService.h
//  Clippr
//
//  Created by Bradley Bain on 12/4/13.
//  Copyright (c) 2013 Bradley Bain. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CPPProject;

@interface CPPCurrentProjectService : NSObject

+(CPPProject *)project;
+(void)flushProject;

@end
