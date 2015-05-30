//
//  PQMenuBar.h
//  Pods
//
//  Created by pqteru on 2015/5/30.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PQMenuBarItem.h"

@class PQMenuBar;

@protocol PQMenuBarDelegate <NSObject>

@optional
- (void)menuBar:(PQMenuBar *)menubar didSelectAtIndex:(int)index;

@end

@interface PQMenuBar : UIView {
@private
    UIScrollView *containerView;
    UIPageControl *pageControl;
    NSInteger pages;
}

@property (nonatomic, assign) id<PQMenuBarDelegate> delegate;
@property (nonatomic, strong) PQMenuBarItem *selectedItem;
@property (nonatomic, retain, readonly) NSMutableArray *items;
@property (nonatomic, assign, readonly) NSInteger column;
@property (nonatomic, assign, readonly) NSInteger row;
@property (nonatomic, assign, readonly) BOOL isOpen;

- (void)setColumn:(NSInteger)numCol andRow:(NSInteger)numRow;
- (void)addMenuItem:(PQMenuBarItem *)item;
- (void)hidePaging:(BOOL)hide;
- (void)show;
- (void)dismiss;

@end
