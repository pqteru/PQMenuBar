//
//  PQViewController.m
//  PQMenuBar
//
//  Created by pqteru on 05/29/2015.
//  Copyright (c) 2014 pqteru. All rights reserved.
//

#import "PQViewController.h"
#import "PQMenuBar.h"

@interface PQViewController () <PQMenuBarDelegate>

@end

@implementation PQViewController {
    PQMenuBar *menu;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"expend" style:UIBarButtonItemStylePlain target:self action:@selector(expend:)];
    self.navigationItem.rightBarButtonItem = button;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)expend:(id)sender
{
    if (menu && [menu isOpen]) {
        [menu dismiss];
        
    } else {
        // set any frame size you want
        menu = [[PQMenuBar alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 180)];
        
        // set columns and rows, default columns:4 and rows:2
        //[menu setColumn:3 andRow:3];
        
        // set hide paging, default is NO
        //[menu hidePaging:YES];
        
        // adding PQMenuBarItems
        PQMenuBarItem *itemA = [[PQMenuBarItem alloc] initWithTitle:@"testA"
                                                              image:[UIImage imageNamed:@"photo"]
                                                             target:self
                                                             action:@selector(actionA:)];
        
        PQMenuBarItem *itemB = [[PQMenuBarItem alloc] initWithTitle:@"testB" image:nil target:self action:@selector(actionB:)];
        PQMenuBarItem *itemC = [[PQMenuBarItem alloc] initWithTitle:@"testC" image:nil target:self action:@selector(actionC:)];
        PQMenuBarItem *itemD = [[PQMenuBarItem alloc] initWithTitle:@"testD" image:nil target:self action:@selector(actionD:)];
        PQMenuBarItem *itemE = [[PQMenuBarItem alloc] initWithTitle:@"testE" image:nil target:self action:@selector(actionE:)];
        PQMenuBarItem *itemF = [[PQMenuBarItem alloc] initWithTitle:@"testF" image:nil target:self action:@selector(actionF:)];
        PQMenuBarItem *itemG = [[PQMenuBarItem alloc] initWithTitle:@"testG" image:nil target:self action:@selector(actionG:)];
        PQMenuBarItem *itemH = [[PQMenuBarItem alloc] initWithTitle:@"testH" image:nil target:self action:@selector(actionH:)];
        PQMenuBarItem *itemI = [[PQMenuBarItem alloc] initWithTitle:@"testI" image:nil target:self action:@selector(actionI:)];
        
        [menu addMenuItem:itemA];
        [menu addMenuItem:itemB];
        [menu addMenuItem:itemC];
        [menu addMenuItem:itemD];
        [menu addMenuItem:itemE];
        [menu addMenuItem:itemF];
        [menu addMenuItem:itemG];
        [menu addMenuItem:itemH];
        [menu addMenuItem:itemI];
        
        menu.delegate = self;
        [menu show];
    }
}

- (void)actionA:(id)sender {
    NSLog(@"%s at line %d %s", __FILE__, __LINE__, __func__);
}

- (void)actionB:(id)sender {
    NSLog(@"%s at line %d %s", __FILE__, __LINE__, __func__);
}

- (void)actionC:(id)sender {
    NSLog(@"%s at line %d %s", __FILE__, __LINE__, __func__);
}

- (void)actionD:(id)sender {
    NSLog(@"%s at line %d %s", __FILE__, __LINE__, __func__);
}

- (void)actionE:(id)sender {
    NSLog(@"%s at line %d %s", __FILE__, __LINE__, __func__);
}

- (void)actionF:(id)sender {
    NSLog(@"%s at line %d %s", __FILE__, __LINE__, __func__);
}

- (void)actionG:(id)sender {
    NSLog(@"%s at line %d %s", __FILE__, __LINE__, __func__);
}

- (void)actionH:(id)sender {
    NSLog(@"%s at line %d %s", __FILE__, __LINE__, __func__);
}

- (void)actionI:(id)sender {
    NSLog(@"%s at line %d %s", __FILE__, __LINE__, __func__);
}

#pragma mark - PQMenuBarDelegate

- (void)menuBar:(PQMenuBar *)menubar didSelectAtIndex:(int)index
{
    // do anything you want...
    // for example:
    //PQMenuBarItem *item = (PQMenuBarItem *)[menubar.items objectAtIndex:index];
    //item.containView.backgroundColor = [UIColor greenColor];
}

@end
