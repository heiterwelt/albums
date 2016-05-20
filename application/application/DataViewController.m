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
@synthesize quoteLabel=_quoteLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
   
    self.contentview.backgroundColor=[UIColor brownColor];
    //self.imageview=[[UIImageView alloc]initWithFrame:self.view.frame];
   // [self.view addSubview:self.imageview];
    self.imageview.userInteractionEnabled=YES;
    self.imageview.multipleTouchEnabled=YES;

    
    self.downgesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipedown)];
    self.downgesture.direction=UISwipeGestureRecognizerDirectionDown;
    [self.imageview addGestureRecognizer:self.downgesture];
    [self.view addGestureRecognizer:self.downgesture];
    
    
    
    self.tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapimage)];
    self.tapgesture.numberOfTapsRequired=1;
    [self.imageview addGestureRecognizer:self.tapgesture];
    //(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
    _quoteLabel = [[FadingLabel alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
    
    self.quoteLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _quoteLabel.textAlignment = NSTextAlignmentCenter;
    //_quoteLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
    self.quoteLabel.font=[UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
    _quoteLabel.textColor = [UIColor whiteColor];
    _quoteLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    _quoteLabel.numberOfLines = 0;
    
    [self.view addSubview:_quoteLabel];
    
    
    
    self.edittextf=[[UITextField alloc]initWithFrame:CGRectMake(0, 90, self.view.frame.size.width/2, 50)];
    self.edittextf.backgroundColor=[UIColor brownColor];
     [self.imageview addSubview:self.edittextf];
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.edittextf addGestureRecognizer:pan];
    self.edittextf.hidden=YES;
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapandSave)];
    tap.numberOfTapsRequired=2;
    [self.imageview addGestureRecognizer:tap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showedittextf) name:@"SHOWTEXTFIELD" object:nil];

//
//    self.view.addSubview(quoteLabel)
//    
//    // Constraints.
//    NSLayoutConstraint.activateConstraints([
//                                            quoteLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor),
//                                            quoteLabel.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor),
//                                            quoteLabel.widthAnchor.constraintEqualToConstant(self.view.frame.width / 1.25)
//                                            ])

    
    
}

-(void)showedittextf
{
    self.edittextf.hidden=NO;
}

-(void)pan:(UIPanGestureRecognizer *)pangesture{
    [self.edittextf resignFirstResponder];
    CGPoint point=[pangesture translationInView:self.edittextf];
    pangesture.view.center = CGPointMake(pangesture.view.center.x + point.x,
                                         pangesture.view.center.y + point.y);
    [pangesture setTranslation:CGPointZero inView:self.edittextf];
}

-(void)tapandSave{
    [self.edittextf resignFirstResponder];
    UIImage *image=  [self drawFront:self.imageview.image text:self.edittextf.text atPoint:self.edittextf.frame.origin];
    if (image) {
         [self.imageview setImage:image];
    }
   
}


-(UIImage*)drawFront:(UIImage*)image text:(NSString*)text atPoint:(CGPoint)point
{
    UIFont *font = [UIFont fontWithName:@"Palatino" size:40];
    NSLog(@"%@",[UIFont familyNames]);
    if (self.edittextf.hidden==YES) {
        return nil;
    }
  
    NSInteger dex=[[HNImageManager shareInterface].imageArray indexOfObject:image];
    self.edittingkey=[HNImageManager shareInterface].keyArray[dex];
    
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x,point.y, image.size.width, image.size.height);
    // [image drawInRect:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    
    // CGRect rect = CGRectMake(self.textf.center.x,self.textf.center.y, self.view.frame.size.width, self.view.frame.size.height);
    [[UIColor whiteColor] set];
    
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = NSMakeRange(0, [attString length]);
    
    [attString addAttribute:NSFontAttributeName value:font range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:range];
    
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor darkGrayColor];
    shadow.shadowOffset = CGSizeMake(1.0f, 1.5f);
    [attString addAttribute:NSShadowAttributeName value:shadow range:range];
    //[attString drawAtPoint:self.textf.center];
    [attString drawInRect:CGRectIntegral(rect)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //
    [[SDImageCache sharedImageCache] storeImage:newImage forKey:self.edittingkey];
    
    return newImage;
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
    //self.dataLabel.text = [self.dataObject description];
    [self.imageview setImage:self.image];
}

@end
