//
//  CPPTipView.m
//  Pasteify
//
//  Created by Bradley Bain on 4/29/14.
//  Copyright (c) 2014 Bradley Bain. All rights reserved.
//

#import "CPPTipView.h"

@interface CPPTipView (){
    UILabel *_label;
    UIButton *_button;
}
@property UIFont *font;
@end

@implementation CPPTipView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        
        self.layer.cornerRadius = 5;
        self.alpha = 0.5;
        
        _font = [UIFont fontWithName:@"HelveticaNeue" size:14.00];

    }
    return self;
}

- (instancetype) initInFrame:(CGRect)frame {
    return [self initWithFrame:CGRectMake(frame.size.width/4, frame.size.height/4, frame.size.width /2, frame.size.width/2)];
}

- (void)setText:(NSString *)text {
    
    CGRect frame = self.frame;
    if(!_label)
        _label = [[UILabel alloc] initWithFrame:CGRectMake(
                                                       0, 0,
                                                       frame.size.width,
                                                       frame.size.height)];
    
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor blackColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = self.font;
    _label.text = text;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.numberOfLines = 2;
    
    [self addSubview:_label];
}

- (void) setText:(NSString *)text andNumberOfLines:(NSInteger)lines {
    [self setText:text];
    _label.numberOfLines = lines;
}

- (void) setIsButton:(bool)button {
    CGRect frame = self.frame;
    _button = [[UIButton alloc] initWithFrame:CGRectMake(
                                                         frame.size.width/4, 3*frame.size.height/4 - 5, frame.size.width/2, frame.size.height/4)];
    _button.layer.cornerRadius = 5;
    
    [_button setTitle:@"OK" forState:UIControlStateNormal];
    _button.titleLabel.textColor = [UIColor blackColor];
    _button.backgroundColor = [UIColor redColor];
    [_button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_button];
}

- (void) buttonClicked {
    [self close];
}

- (void) close {
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
