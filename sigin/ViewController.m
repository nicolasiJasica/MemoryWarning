//
//  ViewController.m
//  sigin
//
//  Created by weiliang on 14-1-15.
//  Copyright (c) 2014年 weiliang. All rights reserved.
//

#import "ViewController.h"
#import "BBViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    
    UILabel* lable = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 60)];
    lable.backgroundColor = [UIColor clearColor];
    lable.textColor = [UIColor blackColor];
    lable.font = [UIFont boldSystemFontOfSize:20];
    lable.text = @"内存警告demo";
    [self.view addSubview:lable];
 
	// Do any additional setup after loading the view, typically from a nib.
    UIButton* playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn addTarget:self action:@selector(pushview) forControlEvents:UIControlEventTouchUpInside];
    playBtn.backgroundColor = [UIColor greenColor];
    [playBtn setTitle:@"开始" forState:UIControlStateNormal];
    playBtn.frame = CGRectMake(100, 300, 50, 50);
    [self.view addSubview:playBtn];
    

}
-(void) pushview
{
    BBViewController *recipePhotoViewController = [[BBViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:recipePhotoViewController];
//    [self presentViewController:navigationController animated:YES completion:nil];
    [self presentViewController:navigationController animated:YES completion:nil];
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
