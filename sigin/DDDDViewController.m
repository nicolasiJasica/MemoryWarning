//
//  DDDDViewController.m
//  sigin
//
//  Created by weiliang on 14-1-15.
//  Copyright (c) 2014年 weiliang. All rights reserved.
//

#import "DDDDViewController.h"

@interface DDDDViewController ()
{
    UILabel* lable;
    float    counta;
    NSTimer *timer;
}
@end

@implementation DDDDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

 
    }
    return self;
}

-(void)start
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10 target:self selector:@selector(leaks) userInfo:nil repeats:YES];//(57s 收到警告)
}
-(void)stop
{
    [timer invalidate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
	// Do any additional setup after loading the view.
    
    lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 30)];
    lable.backgroundColor = [UIColor grayColor];
    lable.text = @"频率：0";
    [self.view addSubview:lable];
  
    UIButton* playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn addTarget:self action:@selector(preViewStart) forControlEvents:UIControlEventTouchUpInside];
    playBtn.showsTouchWhenHighlighted = YES;
    playBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [playBtn setTitle:@"上一个页面" forState:UIControlStateNormal];
    playBtn.backgroundColor = [UIColor greenColor];
    playBtn.frame = CGRectMake(150, 10, 80, 30);
    [self.view addSubview:playBtn];
    
    UIButton* playBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn2 addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    playBtn2.showsTouchWhenHighlighted = YES;
    playBtn2.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [playBtn2 setTitle:@"本页面" forState:UIControlStateNormal];
    playBtn2.backgroundColor = [UIColor greenColor];
    playBtn2.frame = CGRectMake(240, 10, 50, 30);
    [self.view addSubview:playBtn2];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationOB:) name:@"CCCViewControllerLeaks" object:nil];
}
-(void)preViewStart
{
    if (self.previewController) {
        [self.previewController leaksStart];
    }
}
-(void)notificationOB:(NSNotification*)noti
{
    NSNumber* num = noti.object;
    lable.text = [NSString stringWithFormat:@"频率：%0.lf",[num floatValue]];
}
-(void)leaks
{
    counta++;
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"image2" ofType:@"jpg"];
  
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath2];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60 + 25 * counta, self.view.frame.size.width - 20, self.view.frame.size.height - 50)];
    imageView.image = image;
    [self.view addSubview:imageView];

    lable.text = [NSString stringWithFormat:@"频率：%0.lf",counta];
}

- (void) loadView {
    [super loadView];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。
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
