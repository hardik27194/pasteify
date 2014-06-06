//
//  CPPTipView.h
//  Pasteify
//
//  Created by Bradley Bain on 4/29/14.
//  Copyright (c) 2014 Bradley Bain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPPTipView : UIControl

@property UIViewController *delegate;

@property bool isButton;
@property (nonatomic, weak) NSString *text;

-(instancetype) initInFrame:(CGRect)frame;

-(void)close;
- (void) setText:(NSString *)text andNumberOfLines:(NSInteger)lines;
@end
