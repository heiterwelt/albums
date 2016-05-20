//
//  DataViewController.h
//  application
//
//  Created by Linyou-IOS-1 on 16/5/11.
//  Copyright © 2016年 Linyou-IOS-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "application-Swift.h"
@interface DataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
//@property (strong, nonatomic) id dataObject;
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,strong)UIImageView *imageview;

@property(nonatomic,strong)FadingLabel *quoteLabel;
@property(nonatomic,strong)UISwipeGestureRecognizer *downgesture;
@property(nonatomic,strong)UITapGestureRecognizer *tapgesture;


@property (weak, nonatomic) IBOutlet UIView *contentview;

-(void)swipedown;
@end

