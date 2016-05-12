//
//  DataViewController.m
//  application
//
//  Created by Linyou-IOS-1 on 16/5/11.
//  Copyright © 2016年 Linyou-IOS-1. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()


@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
    self.dataLabel.backgroundColor=[UIColor redColor];
    self.contentview.backgroundColor=[UIColor brownColor];
    self.imageview=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.imageview];
    self.imageview.userInteractionEnabled=YES;
    
    self.downgesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipedown)];
    self.downgesture.direction=UISwipeGestureRecognizerDirectionDown;
    [self.imageview addGestureRecognizer:self.downgesture];
    [self.view addGestureRecognizer:self.downgesture];
    
    
    
    self.tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapimage)];
    self.tapgesture.numberOfTapsRequired=1;
    [self.imageview addGestureRecognizer:self.tapgesture];
    

    
    
}

#pragma mark tapimage
-(void)tapimage
{
    NSLog(@"taptaptaptap");
    if (self.navigationController.navigationBar.isHidden==YES) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        return;
        
    }
    if (self.navigationController.navigationBar.isHidden==NO) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        return;
    }
}
-(void)swipedown
{
    if (self.navigationController.navigationBar.isHidden==YES) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    }
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
    [self.imageview setImage:self.image];
}

@end
