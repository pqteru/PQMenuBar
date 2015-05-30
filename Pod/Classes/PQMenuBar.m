//
//  PQMenuBar.m
//  Pods
//
//  Created by pqteru on 2015/5/30.
//
//

#import "PQMenuBar.h"

static const int defaultColumns = 4;
static const int defaultRows = 2;
static const CGFloat pageControlDefaultHeight = 30.0f;

@interface PQMenuBar() <UIScrollViewDelegate, PQMenuBarDelegate>

- (void)initMenuBar;
- (void)presentModelView;
- (void)dismissModelView;
- (void)resetSubviewsLayout;
- (void)resetContainerViewLayout;

@end

@implementation PQMenuBar

@synthesize column, row;

- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
        [self initMenuBar];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerNotifications];
        [self initialize];
        [self setColumn:defaultColumns andRow:defaultRows];
        [self initMenuBar];
        [self resetSubviewsLayout];
    }
    return self;
}

- (void)dealloc {
    [self removeNotifications];
}

- (void)initialize
{
    _isOpen = false;
    _items = [NSMutableArray arrayWithCapacity:0];
}

- (void)setColumn:(NSInteger)numCol andRow:(NSInteger)numRow
{
    column = numCol;
    row = numRow;
    [self resetSubviewsLayout];
}

- (void)addMenuItem:(PQMenuBarItem *)item
{
    NSAssert([item isKindOfClass:[PQMenuBarItem class]], @"item is not a PQMenuBarItem class!");
    [_items addObject:item];
}

- (void)hidePaging:(BOOL)hide {
    pageControl.hidden = hide;
}

- (void)initMenuBar
{
    // scrollView
    CGFloat containerViewHeight = self.bounds.size.height;
    CGFloat containerViewWidth = self.bounds.size.width;
    containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   containerViewWidth,
                                                                   containerViewHeight)];
    containerView.contentSize = CGSizeMake(containerViewWidth, containerViewHeight);
    containerView.pagingEnabled = YES;
    containerView.backgroundColor = [UIColor darkGrayColor];
    containerView.delegate = self;
    [self addSubview:containerView];
    
    // pageControl
    CGFloat pageControlHeight = pageControlDefaultHeight;
    CGFloat pageControlPointY = containerView.frame.size.height;
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,
                                                                  pageControlPointY,
                                                                  self.bounds.size.width,
                                                                  pageControlHeight)];
    pageControl.numberOfPages = 1;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    pageControl.backgroundColor =  [UIColor grayColor];
    [self addSubview:pageControl];
}

- (void)resetContainerViewLayout
{
    if (pages > 1) {
        containerView.scrollEnabled = TRUE;
    } else {
        containerView.scrollEnabled = FALSE;
    }
    
    containerView.contentSize = CGSizeMake(pages * containerView.bounds.size.width,
                                           containerView.bounds.size.height);
}

- (void)resetSubviewsLayout
{
    if (_items.count == 0) {
        return;
    }
    pages = ceil((double)_items.count / (double)(row * column));
    
    CGFloat itemWidth = containerView.frame.size.width / column;
    CGFloat itemHeight = containerView.frame.size.height / row;
    
    if (pageControl) {
        pageControl.numberOfPages = pages;
        pageControl.currentPage = 0;
    }
    
    [self resetContainerViewLayout];
    
    int itemsPerPage = (int)row * (int)column;
    for (int page=0; page < pages; page++) {
        UIView *pageContent = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       containerView.frame.size.width,
                                                                       containerView.frame.size.height)];
        
        for (int index = (page * itemsPerPage); index < (page * itemsPerPage) + itemsPerPage; index++) {
            if (index == _items.count) break;
            
            PQMenuBarItem *item = [_items objectAtIndex:index];
            [item layoutSubviewsWithWidth:itemWidth height:itemHeight];
            item.itemIndex = index;
            
            CGFloat itemWidth = item.containView.frame.size.width;
            CGFloat itemHeight = item.containView.frame.size.height;
            int relativeColumn = index%column;
            int relativeRow = round(index/column) - (page * row);
            
            [item.containView setFrame:CGRectOffset(item.containView.frame,
                                                    itemWidth*relativeColumn,
                                                    itemHeight*relativeRow)];
            
            [pageContent addSubview:item.containView];
            pageContent.userInteractionEnabled = YES;
        }
        
        [pageContent setFrame:CGRectOffset(pageContent.frame, page * pageContent.bounds.size.width, 0)];
        [containerView addSubview:pageContent];
    }
}

- (void)presentModelView
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    if (![keywindow.subviews containsObject:self]) {
        [keywindow addSubview:self];
        UIView * modal = [keywindow.subviews objectAtIndex:keywindow.subviews.count-1];
        [UIView animateWithDuration:2.0 animations:^{
            modal.frame = CGRectMake(self.frame.origin.x,
                                     self.frame.origin.y,
                                     modal.frame.size.width,
                                     modal.frame.size.height);
        }];
    }
}

- (void)dismissModelView
{
    UIWindow * keywindow = [[[UIApplication sharedApplication] delegate] window];
    if (keywindow.subviews.count > 0) {
        UIView * modal = [keywindow.subviews objectAtIndex:keywindow.subviews.count-1];
        [UIView animateWithDuration:2.0 animations:^{
            modal.frame = CGRectMake(self.frame.origin.x,
                                     self.frame.origin.y,
                                     modal.frame.size.width,
                                     modal.frame.size.height);
        } completion:^(BOOL finished) {
            [modal removeFromSuperview];
        }];
    }
}

- (void)show
{
    [self resetSubviewsLayout];
    [self presentModelView];
    _isOpen = true;
}

- (void)dismiss
{
    [self dismissModelView];
    _isOpen = false;
}

#pragma mark - UIPageControl Delegate

- (void)pageTurn:(UIPageControl *)aPageControl
{
    int whichPage = (int)aPageControl.currentPage;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    containerView.contentOffset = CGPointMake(containerView.bounds.size.width * whichPage, 0.0f);
    [UIView commitAnimations];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender
{
    uint page = sender.contentOffset.x / containerView.frame.size.width;
    [pageControl setCurrentPage:page];
}

#pragma mark - Notification

- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedItemIndexNotification:)
                                                 name:@"getItemIndex"
                                               object:nil];
}

- (void)removeNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receivedItemIndexNotification:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    id<PQMenuBarDelegate> strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(menuBar:didSelectAtIndex:)]) {
        int idx = [[userInfo objectForKey:@"itemIndex"] intValue];
        [strongDelegate menuBar:self didSelectAtIndex:idx];
    }
}

@end
