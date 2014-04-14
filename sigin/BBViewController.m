//
//  BBViewController.m
//  sigin
//
//  Created by weiliang on 14-1-15.
//  Copyright (c) 2014年 weiliang. All rights reserved.
//

#import "BBViewController.h"
#import "CCCViewController.h"
@interface BBViewController ()
{
    UIButton* playBtn;
}
@end

@implementation BBViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    UIButton *backbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 31)];
    [backbutton setTitle:NSLocalizedString(@"返回",nil) forState:UIControlStateNormal];
    [backbutton.titleLabel setShadowOffset:CGSizeMake(0, 1)];
    [backbutton.titleLabel setTextColor:[UIColor whiteColor]];
    [backbutton.titleLabel setFont:[UIFont fontWithName:@"Baskerville-SemiBoldItalic" size:14]];
    [backbutton.titleLabel setBackgroundColor:[UIColor clearColor]];
    [backbutton addTarget:self action:@selector(NavPopControllerSelf) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[[UIBarButtonItem alloc] initWithCustomView:backbutton] autorelease];
    self.navigationItem.leftBarButtonItem =backItem;

    playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn addTarget:self action:@selector(pushview) forControlEvents:UIControlEventTouchUpInside];
    [playBtn setTitle:@"B" forState:UIControlStateNormal];
    playBtn.backgroundColor = [UIColor greenColor];
    playBtn.frame = CGRectMake(100, 300, 50, 50);
    [self.view addSubview:playBtn];
	// Do any additional setup after loading the view.
}
-(void)NavPopControllerSelf
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void) pushview
{
    CCCViewController *recipePhotoViewController = [[CCCViewController alloc] init];
    [self.navigationController pushViewController:recipePhotoViewController animated:YES];
}

- (void) loadView {
    UIView * myView = [[UIView alloc] init];
    self.view = myView;
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
