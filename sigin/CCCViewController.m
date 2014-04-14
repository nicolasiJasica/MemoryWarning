//
//  CCCViewController.m
//  sigin
//
//  Created by weiliang on 14-1-15.
//  Copyright (c) 2014年 weiliang. All rights reserved.
//

#import "CCCViewController.h"
#import "DDDDViewController.h"
@interface CCCViewController ()
{
    UIButton* playBtn;
    NSTimer *timer;
    UIView* tempView;
    
    NSMutableArray* tempArray;
}
@end

@implementation CCCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _counta = 0;
        tempArray = [[NSMutableArray alloc] initWithCapacity:2];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor yellowColor];
//    tempView = [[UIView alloc] init];
//    tempView.frame = self.view.frame;
//    tempView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:tempView];
    
    
    playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [playBtn addTarget:self action:@selector(pushview) forControlEvents:UIControlEventTouchUpInside];
    [playBtn setTitle:@"C" forState:UIControlStateNormal];
    playBtn.backgroundColor = [UIColor greenColor];
    playBtn.frame = CGRectMake(100, 300, 50, 50);
    [self.view addSubview:playBtn];
}
-(void) pushview
{
    DDDDViewController *recipePhotoViewController = [[DDDDViewController alloc] init];
    recipePhotoViewController.previewController = self;
    [self.navigationController pushViewController:recipePhotoViewController animated:YES];
}
-(void)leaksStart
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
//    timer = nil;
//    NSDate *fireDate=[NSDate dateWithTimeIntervalSinceNow:0];
//    timer = [[NSTimer alloc] initWithFireDate:fireDate interval:1.0/10 target:self selector:@selector(leaks) userInfo:nil repeats:YES];
//    [timer fire];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10 target:self selector:@selector(leaks) userInfo:nil repeats:YES];//(57s 收到警告)
}
-(void)leaks
{
    self.counta++;
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"image2" ofType:@"jpg"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath2];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60 + self.counta * 25, self.view.frame.size.width - 20, self.view.frame.size.height - 50)];
    imageView.image = image;
    [tempArray addObject:imageView];
    imageView.tag = 1000 + self.counta;
    [self.view addSubview:imageView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CCCViewControllerLeaks" object:[NSNumber numberWithFloat:self.counta]];
}

- (void) loadView {
    [super loadView];
}

-(void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。
    // Add code to clean up any of your own resources that are no longer necessary.
    
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    [tempArray removeAllObjects];
//    NSInteger indec = 0;
//    NSInteger count = [self.view subviews].count;
//    for (int i = 0; i < count; i++) {
//        if (i < count - 2) {
//            if ([[[self.view subviews] objectAtIndex:2] isKindOfClass:[UIImageView class]]) {
//                UIImageView* VVVV = (UIImageView*)[[self.view subviews] objectAtIndex:2];
//                if (VVVV.tag >= 1000) {
//                    [VVVV removeFromSuperview];
//                }
//                VVVV = nil;
////                indec++;
////                count = [self.view subviews].count;
//            }
//        }
//        else
//        {
//            break;
//
//        }
//    }
//    NSInteger count2 = [self.view subviews].count;
    
    
    // 此处做兼容处理需要加上ios6.0的宏开关，保证是在6.0下使用的,6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidUnLoad
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载 ，在WWDC视频也忽视这一点。
        if (self.isViewLoaded && !self.view.window)// 是否是正在使用的视图
        {
            // Add code to preserve data stored in the views that might be
            // needed later.
            
            // Add code to clean up other strong references to the view in
            // the view hierarchy.
            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
        }
    }
}
 
@end
