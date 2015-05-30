//
//  PQMenuBarItem.m
//  PQMenuBar
//
//  Created by pqteru on 2015/5/30.
//  Copyright (c) 2015年 pqteru. All rights reserved.
//

#import "PQMenuBarItem.h"

@implementation PQMenuBarItem

- (id)initWithTitle:(NSString *)title
              image:(UIImage *)image
             target:(id)target
             action:(SEL)action
{
    if (self = [super init]) {
        
        _containView = [[UIControl alloc] initWithFrame:CGRectZero];
        [_containView addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        if (title) {
            NSString *t = [NSString stringWithFormat:@"%@", title];
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.textColor = [UIColor whiteColor];
            
            [_titleLabel setTextAlignment:NSTextAlignmentCenter];
            [_titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
            
            _titleLabel.numberOfLines = 1;
            _titleLabel.font = [UIFont systemFontOfSize:13.f];
            _titleLabel.text = t;
            [_titleLabel sizeToFit];
            [_containView addSubview:_titleLabel];
        }
        
        if (image) {
            _imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:image.CGImage]];
            [_containView addSubview:_imageView];
        }
        
        [self setup];
        
    }
    return self;
}

- (void)setup
{
    _containView.backgroundColor = [UIColor darkGrayColor];
    
    [_containView addTarget:self
                     action:@selector(addHighlight)
           forControlEvents: UIControlEventTouchDown];
    
    [_containView addTarget:self
                     action:@selector(handleSelectEvent)
           forControlEvents: UIControlEventTouchDown];
    
    [_containView addTarget:self
                     action:@selector(removeHighlight)
           forControlEvents: UIControlEventTouchCancel | UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
}

- (void)addHighlight
{
    _containView.backgroundColor = [UIColor lightGrayColor];
}

- (void)removeHighlight
{
    _containView.backgroundColor = [UIColor darkGrayColor];
}

- (void)layoutSubviewsWithWidth:(CGFloat)width height:(CGFloat)height {
    _containView.frame = CGRectMake(0, 0, width, height);
    _titleLabel.center = _containView.center;
    
    // centralized contains
    if (_imageView.image) {
        _imageView.center = _containView.center;
        CGFloat padding = 5.0f;
        CGFloat ost = _imageView.frame.size.height + _titleLabel.frame.size.height + padding;
        _imageView.frame = CGRectOffset(_imageView.frame, 0, -(ost/2 - _imageView.frame.size.height/2));
        _titleLabel.frame = CGRectOffset(_titleLabel.frame, 0, ost/2 - _titleLabel.frame.size.height/2);
    }
}

#pragma mark - Touch Handler

- (void)handleSelectEvent
{
    NSDictionary *userInfo = @{@"itemIndex": [NSNumber numberWithInt:_itemIndex]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getItemIndex" object:self userInfo:userInfo];
}

@end