//
//  HomeViewController.m
//  XWNews
//
//  Created by serein on 2018/2/24.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsFeedViewController.h"
#import "HomeMenuView.h"

@interface HomeViewController ()<XWPageViewControllerDataSource,XWPageViewControllerDelegate,XWMenuViewDelegate>

@property (nonatomic,strong) HomeMenuView *menuView;

@property (nonatomic,strong) XWPageViewController *pageViewController;

@property (nonatomic,strong) NSArray<NSString *> *titles;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBar];
    [self setUpUI];
    // Do any additional setup after loading the view.
}

-(void)setNaviBar{
    
    [self xw_setNavBarBarTintColor:MainColor];
    [self xw_setNavBarShadowImageHidden:YES];
}

-(void)setUpUI{
    
    self.titles = @[@"关注",@"推荐",@"深圳",@"视频",@"热点",@"新时代",@"问答",@"娱乐",@"图片",@"科技",@"懂车帝",@"体育",@"段子"];
    self.view.backgroundColor = white_Color;
    [self.view addSubview:self.menuView];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];


}

#pragma mark -
#pragma mark   datasource/delegate

-(NSInteger)numberOfControllersInPageViewController:(XWPageViewController *)pageViewController{
    
    return self.titles.count;
}

-(UIViewController *)pageViewControllerForIndex:(XWPageViewController *)pageViewController andIndex:(NSInteger)index{
    
    return [[NewsFeedViewController alloc] initWithIndex:index];
}

-(void)pageViewControllerPageChange:(XWPageViewController *)pageViewController andPageChange:(NSInteger)pageChange{
    
    [self.menuView updateSelectValue:pageChange];
}

-(void)pageViewControllerScrollProgress:(XWPageViewController *)pageViewController andProgress:(CGFloat)progress andFromPage:(NSInteger)fromPage{
    
    [self.menuView updateProgressValue:progress andFromPage:fromPage];
}

-(void)menuView:(XWMenuView *)menuView didSelesctedIndex:(NSInteger)index{
    
    [self.pageViewController gotoPageWithIndex:index animated:NO];
}

#pragma mark -
#pragma mark   set/get

-(HomeMenuView *)menuView{
    
    if (_menuView == nil) {
        
        _menuView = [[HomeMenuView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _menuView.titles = self.titles;
        _menuView.delegate = self;
    }
    return _menuView;
}

-(XWPageViewController *)pageViewController{
    
    if (_pageViewController == nil) {
        
        _pageViewController = [[XWPageViewController alloc] init];
        _pageViewController.view.frame = CGRectMake(0, self.menuView.bottom, kScreenWidth, self.view.height - self.menuView.height);
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
    }
    return _pageViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
