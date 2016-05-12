//
//  ViewController.m
//  saveimage
//
//  Created by Linyou-IOS-1 on 16/5/12.
//  Copyright © 2016年 Linyou-IOS-1. All rights reserved.
//

#import "ViewController.h"
 static  int i=0;
dispatch_queue_t qDb;
@interface ViewController ()

@property(nonatomic,strong)HNDatabaseQueue * queueasy;
@property(nonatomic,strong)NSMutableArray *imagearr;
@property(nonatomic,strong)NSMutableArray *labletext;


@property(nonatomic,strong)NSMutableArray*imageGetarr;
@end

@implementation ViewController
-(NSMutableArray *)imageGetarr
{
    if (!_imageGetarr) {
        _imageGetarr=[NSMutableArray array];
    }
    return _imageGetarr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr=[NSArray arrayWithObjects:@"one",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight",@"nine",@"ten",@"one",@"two", nil];

    self.imagearr=[NSMutableArray arrayWithArray:arr];
    self.labletext=[NSMutableArray arrayWithArray:arr];

    
    NSString *docasy=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filenameasy= [docasy stringByAppendingPathComponent:@"noticAsy.sqlite"];
    self.queueasy = [HNDatabaseQueue databaseQueueWithPath:filenameasy];
    qDb = dispatch_queue_create("qDb", NULL);

    dispatch_async(qDb, ^{
        [self.queueasy inDatabase:^(HNDatabase *db2) {
            
            
            
            NSString *strpathasy= [db2 databasePath];
            NSLog(@"strpathasy:%@\n%@",strpathasy,[NSThread currentThread]);
            //                NSString * name = [NSString stringWithFormat:@"jack %d", i];
            //                NSString * age = [NSString stringWithFormat:@"%d", 10+i];
            
            self.db=db2;
            if ([self.db open]) {
               
                NSString *createtableLanguage=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS t_asy (id integer PRIMARY KEY AUTOINCREMENT, imagedata blob NOT NULL,content text);"];
                BOOL results=[self.db executeUpdate:createtableLanguage];
                // [self.db executeUpdate:@"DELETE FROM t_teacherasy WHERE ID>50 AND ID<70 ;"];
                
                if (results) {
                    NSLog(@"创表成功");
                }else
                {
                    NSLog(@"t_teacherasy创表失败");
                }
                
            }
            
            
        }];
        
    });
    
    for (NSString *name in self.imagearr) {
     
               UIImage *image=[UIImage imageNamed:name];
        NSData *data=UIImagePNGRepresentation(image);
        
        NSString *updateLanguage=[NSString stringWithFormat:@"INSERT INTO t_asy (imagedata,content) VALUES(?,?);"];
        if (i==self.labletext.count) {
            i-=1;
        }
        [self.db executeUpdate:updateLanguage,data,self.labletext[i]];
        
        i+=1;
        

    }
    
    
    
    NSString *SELECTLanguage=[NSString stringWithFormat:@"SELECT * FROM t_asy  ORDER BY id DESC"];
    HNResultSet *resultSet= [self.db executeQuery:SELECTLanguage];
   
    while ([resultSet next]) {
        NSData *data=[resultSet dataForColumn:@"imagedata"];
        NSString *res=[resultSet stringForColumn:@"content"];
        
        UIImage *iamge=[UIImage imageWithData:data];
        
        [self.imageGetarr addObject:iamge];
    }
    
    for (int i=0; i<self.imageGetarr.count; i++) {
        
     
                UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(60*i,20, 60, 60)];
                [but setImage:self.imageGetarr[i] forState:UIControlStateNormal];
                [self.view addSubview:but];

        
           }
    

    NSLog(@"************************%@",self.imageGetarr);
    
    


    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
