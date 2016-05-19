//
//  ViewController.m
//  addTextToImage
//
//  Created by Linyou-IOS-1 on 16/5/17.
//  Copyright © 2016年 Linyou-IOS-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UITextField *textf;
@property(nonatomic,strong)NSString *textget;
@property(nonatomic,strong)UIImageView *imagview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:scroll];
    scroll.maximumZoomScale=2;
    scroll.minimumZoomScale=0.8;
    
    
    self.textf=[[UITextField alloc]initWithFrame:CGRectMake(0, 90, self.view.frame.size.width/2, 50)];
    
    
    _imagview=[[UIImageView alloc]initWithFrame:self.view.frame];
    [scroll addSubview:_imagview];
    _imagview.userInteractionEnabled=YES;
    
    
    UIImage *image=[UIImage imageNamed:@"one.png"];
    [_imagview setImage:image];
    UIImage *image2= [self drawFront:image text:@"sdfaerdgfergad" atPoint:CGPointMake(50, 100)];
    [_imagview setImage:image2];
    _imagview.userInteractionEnabled=YES;
    _imagview.multipleTouchEnabled=YES;

    
    [_imagview addSubview:self.textf];
    self.textf.backgroundColor=[UIColor blueColor];
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.textf addGestureRecognizer:pan];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textf resignFirstResponder];
}
-(void)pan:(UIPanGestureRecognizer *)pangesture{
    CGPoint point=[pangesture translationInView:self.textf];
    pangesture.view.center = CGPointMake(pangesture.view.center.x + point.x,
                                         pangesture.view.center.y + point.y);
    [pangesture setTranslation:CGPointZero inView:self.textf];
}

-(UIImage *)addText:(UIImage *)img text:(NSString *)text1
{
    //上下文的大小
    int w = img.size.width;
    int h = img.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//创建颜色
    //创建上下文
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);//将img绘至context上下文中
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);//设置颜色
    char* text = (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Georgia", 30, kCGEncodingMacRoman);//设置字体的大小
    CGContextSetTextDrawingMode(context, kCGTextFill);//设置字体绘制方式
    CGContextSetRGBFillColor(context, 255, 0, 0, 1);//设置字体绘制的颜色
//    CGContextShowTextAtPoint(context, w/2-strlen(text)*5, h/2, text, strlen(text));//设置字体绘制的位置
    CGContextShowTextAtPoint(context, 0, 90, text, strlen(text));//设置字体绘制的位置

    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);//创建CGImage
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];//获得添加水印后的图片   
}


-(UIImage*)drawFront:(UIImage*)image text:(NSString*)text atPoint:(CGPoint)point
{
   UIFont *font = [UIFont fontWithName:@"Copperplate" size:28];
    NSLog(@"%@",[UIFont familyNames]);
    //UIFont *font = [UIFont systemFontOfSize:20];
//    Copperplate,
//    "Heiti SC",
//    "Iowan Old Style",
//    "Kohinoor Telugu",
//    Thonburi,
//    "Heiti TC",
//    "Courier New",
//    "Gill Sans",
//    "Apple SD Gothic Neo",
//    "Marker Felt",
//    "Avenir Next Condensed",
//    "Tamil Sangam MN",
//    "Helvetica Neue",
//    "Gurmukhi MN",
//    "Times New Roman",
//    Georgia,
//    "Apple Color Emoji",
//    "Arial Rounded MT Bold",
//    Kailasa,
//    "Kohinoor Devanagari",
//    "Kohinoor Bangla",
//    "Chalkboard SE",
//    "Sinhala Sangam MN",
//    "PingFang TC",
//    "Gujarati Sangam MN",
//    Damascus,
//    Noteworthy,
//    "Geeza Pro",
//    Avenir,
//    "Academy Engraved LET",
//    Mishafi,
//    Futura,
//    Farah,
//    "Kannada Sangam MN",
//    "Arial Hebrew",
//    Arial,
//    "Party LET",
//    Chalkduster,
//    "Hoefler Text",
//    Optima,
//    Palatino,
//    "Lao Sangam MN",
//    "Malayalam Sangam MN",
//    "Al Nile",
//    "Bradley Hand",
//    "PingFang HK",
//    "Trebuchet MS",
//    Helvetica,
//    Courier,
//    Cochin,
//    "Hiragino Mincho ProN",
//    "Devanagari Sangam MN",
//    "Oriya Sangam MN",
//    "Snell Roundhand",
//    "Zapf Dingbats",
//    "Bodoni 72",
//    Verdana,
//    "American Typewriter",
//    "Avenir Next",
//    Baskerville,
//    "Khmer Sangam MN",
//    Didot,
//    "Savoye LET",
//    "Bodoni Ornaments",
//    Symbol,
//    Menlo,
//    "Bodoni 72 Smallcaps",
//    Papyrus,
//    "Hiragino Sans",
//    "PingFang SC",
//    "Euphemia UCAS",
//    "Telugu Sangam MN",
//    "Bangla Sangam MN",
//    Zapfino,
//    "Bodoni 72 Oldstyle"
    
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, (point.y - 5), image.size.width, image.size.height);
    [[UIColor whiteColor] set];
    
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = NSMakeRange(0, [attString length]);
    
    [attString addAttribute:NSFontAttributeName value:font range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:range];
    
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor darkGrayColor];
    shadow.shadowOffset = CGSizeMake(1.0f, 1.5f);
    [attString addAttribute:NSShadowAttributeName value:shadow range:range];
    
    [attString drawInRect:CGRectIntegral(rect)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



-(UIImage *)addImageLogo:(UIImage *)img text:(UIImage *)logo
{
    //get image width and height
    int w = img.size.width;
    int h = img.size.height;
    int logoWidth = logo.size.width;
    int logoHeight = logo.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextDrawImage(context, CGRectMake(w-logoWidth, 0, logoWidth, logoHeight), [logo CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
    // CGContextDrawImage(contextRef, CGRectMake(100, 50, 200, 80), [smallImg CGImage]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
