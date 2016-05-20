//
//  DataViewController.h
//  application
//
//  Created by Linyou-IOS-1 on 16/5/11.
//  Copyright © 2016年 Linyou-IOS-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "application-Swift.h"
#import "HNImageManager.h"
#import "SDImageCache.h"
@interface DataViewController : UIViewController


//@property (strong, nonatomic) id dataObject;
@property(nonatomic,strong) UIImage *image;

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property(nonatomic,strong) NSString *edittingkey;

@property(nonatomic,strong)FadingLabel *quoteLabel;
@property(nonatomic,strong)UISwipeGestureRecognizer *downgesture;
@property(nonatomic,strong)UITapGestureRecognizer *tapgesture;

@property(nonatomic,strong)UITextField *edittextf;

@property (weak, nonatomic) IBOutlet UIView *contentview;

-(void)swipedown;
@end

