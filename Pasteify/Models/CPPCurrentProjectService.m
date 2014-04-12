//
//  CPPCurrentProjectService.m
//  Clippr
//
//  Created by Bradley Bain on 12/4/13.
//  Copyright (c) 2013 Bradley Bain. All rights reserved.
//

#import "CPPCurrentProjectService.h"
#import "CPPProject.h"

static CPPProject *project;

@implementation CPPCurrentProjectService

+(CPPProject *) project {
    /* Returns the current project or creates one */
    extern CPPProject *project;
    if(!project) project = [[CPPProject alloc] init];
    
    return project;
}

+(void)flushProject {
    /* Set the current project to nil */
    project = nil;
}

@end
