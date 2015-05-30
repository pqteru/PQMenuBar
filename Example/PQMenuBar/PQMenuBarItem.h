//
//  PQMenuBarItem.h
//  PQMenuBar
//
//  Created by pqteru on 2015/5/30.
//  Copyright (c) 2015年 pqteru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PQMenuBarItem : NSObject

@property (nonatomic, retain) UIControl *containView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, assign) int itemIndex;

- (id)initWithTitle:(NSString *)title
              image:(UIImage *)image
             target:(id)target
             action:(SEL)action;

- (void)layoutSubviewsWithWidth:(CGFloat)width height:(CGFloat)height;

@end

