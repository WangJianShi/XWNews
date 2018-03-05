//
//  XWPageViewController.m
//  StealTime
//
//  Created by 王剑石 on 2017/7/13.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "XWPageViewController.h"
#import "UIViewController+XWPageViewController.h"


@interface XWPageViewController ()<UIScrollViewDelegate>

@property(nonatomic, assign) NSInteger numberOfControllers;

@property(nonatomic, assign) NSInteger preIndex;

@property(nonatomic, assign) NSInteger currentIndex;

@property(nonatomic, assign) NSInteger potentialNextIndex;

@property(nonatomic, copy) NSMutableDictionary *cacheControllers;

@property(nonatomic, assign) CGPoint preContentOffset;

@property(nonatomic, assign) BOOL isDragging;

@property(nonatomic, assign) BOOL shouldNotice;

@property(nonatomic, assign) BOOL hasLayouted;

@property(nonatomic, assign) BOOL isScrollEnabled;

@property(nonatomic, copy) UIScrollView *containerView;

@end

@implementation XWPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    if (@available(iOS 11.0, *)) {
        self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    } else {
        // Fallback on earlier versions
    }
    
    self.shouldNotice = YES;
    
    [self.view addSubview:self.containerView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self controllerWillAppearAtIndex:self.currentIndex];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self controllerDidAppearAtIndex:self.currentIndex];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self controllerWillDisappearAtIndex:self.currentIndex];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [self controllerDidDisappearAtIndex:self.currentIndex];
}

-(void)viewDidLayoutSubviews {
    
    [self resetSubViewSize];
}

-(BOOL)shouldAutomaticallyForwardAppearanceMethods{
    
    return false;
}

-(UIViewController *)childControllerForIndex:(NSInteger)index{
    
    
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        
        UIViewController *vc = self.childViewControllers[i];
        if (vc.pageIndex == index) {
            
            return vc;
        }
    }
    
    return nil;
}

-(void)relayout {
    
    [self resetSubViewSize];
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfControllersInPageViewController:)]) {
        
        self.numberOfControllers = [self.dataSource numberOfControllersInPageViewController:self];
    }
    
    self.currentIndex = [self caculateCurrentIndex];
    
    if (self.dataSource && self.numberOfControllers > 0) {
        
        [self relayoutCurrentController];
        
        [self controllerWillAppearAtIndex:self.currentIndex];
        
        [self controllerDidAppearAtIndex:self.currentIndex];
        
        [self relayoutPreController];
        
        [self relayoutNextController];
    }
    

}

-(void)relayoutCurrentController {
    
    NSInteger index = self.currentIndex;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageViewControllerForIndex: andIndex:)]) {
        
        [self replaceWithController:[self.dataSource pageViewControllerForIndex:self andIndex:index] andIndex:index];
 
    }

}

-(void) relayoutCurrentControllerIfNeed  {
    
    NSInteger index = self.currentIndex;
    
    if (index < 0 || [self hasLayoutControllerAtIndex:index]) {
        
        return;
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageViewControllerForIndex: andIndex:)]) {
        
        [self replaceWithController:[self.dataSource pageViewControllerForIndex:self andIndex:index] andIndex:index];
        
    }

}
-(void)relayoutPreController{
    
    NSInteger index = self.currentIndex - 1;
    
    if (index <  0) {
        
        return;
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageViewControllerForIndex: andIndex:)]) {
        
        [self replaceWithController:[self.dataSource pageViewControllerForIndex:self andIndex:index] andIndex:index];
        
    }
    
}

-(void) relayoutPreControllerIfNeed  {
    
    NSInteger index = self.currentIndex - 1;
    
    if (index < 0 || [self hasLayoutControllerAtIndex:index]) {
        
        return;
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageViewControllerForIndex: andIndex:)]) {
        
        [self replaceWithController:[self.dataSource pageViewControllerForIndex:self andIndex:index] andIndex:index];
        
    }
    
}

-(void)relayoutNextController{
    
    NSInteger index = self.currentIndex + 1;
    
    if (index >=  self.numberOfControllers) {
        
        
        return;
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageViewControllerForIndex: andIndex:)]) {
        
        [self replaceWithController:[self.dataSource pageViewControllerForIndex:self andIndex:index] andIndex:index];
        
    }
    
}

-(void) relayoutNextControllerIfNeed  {
    
    NSInteger index = self.currentIndex + 1;
    
    if (index < 0 || index >= self.numberOfControllers || [self hasLayoutControllerAtIndex:index]) {
        
        return;
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageViewControllerForIndex: andIndex:)]) {
        
        [self replaceWithController:[self.dataSource pageViewControllerForIndex:self andIndex:index] andIndex:index];
        
    }
    
}

-(BOOL) hasLayoutControllerAtIndex:(NSInteger)index {
    
    for (UIViewController * chlidvc in self.childViewControllers) {
        
        if (chlidvc.pageIndex == index) {
            
            return YES;
        }
    
    }
    
       return NO;
 
}

-(void)replaceWithController:(UIViewController *)controller andIndex: (NSInteger)index {
    
    if (controller == nil || index < 0 || index > self.numberOfControllers) {
        
        return;
    }
    
    if ([self hasLayoutControllerAtIndex:index]) {
        
        return;
    }
    
    controller.pageIndex = index;
    
    [self addChildViewController:controller];
    
    [controller didMoveToParentViewController:self];
    
    CGRect frame  = controller.view.frame;
    
    frame.origin.x = controller.pageIndex * self.containerView.frame.size.width;
    
    frame.origin.y = 0;
    
    frame.size.width = self.containerView.frame.size.width;
    
    frame.size.height = self.containerView.frame.size.height;
    
    controller.view.frame = frame;

    [self.containerView addSubview:controller.view];
    
}

-(NSInteger)caculateCurrentIndex {
    
    return self.numberOfControllers > 0 ? self.containerView.contentOffset.x / (self.containerView.contentSize.width / self.numberOfControllers) : 0;
}

-(void)resetSubViewSize{
    
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfControllersInPageViewController:)]) {
        
        self.numberOfControllers = [self.dataSource numberOfControllersInPageViewController:self];
    }
    
    if (self.numberOfControllers > 0) {
        
        self.containerView.contentSize = CGSizeMake(self.view.frame.size.width * self.numberOfControllers, self.view.frame.size.height);
        
    }
    
    self.containerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    for (UIViewController *controller  in self.childViewControllers) {
        
        CGRect frame  = controller.view.frame;
        
        frame.origin.x = controller.pageIndex * self.containerView.frame.size.width;
        
        frame.origin.y = 0;
        
        frame.size.width = self.containerView.frame.size.width;
        
        frame.size.height = self.containerView.frame.size.height;
        
        controller.view.frame = frame;
        
        
    }
    
    
}

 //----------------------------------public方法--------------------------------//

-(void)gotoPageWithIndex:(NSInteger)index animated: (BOOL)animated{
    
    
    if (index < 0 || index > self.numberOfControllers || self.currentIndex == index) {
        
        return;
    }
    
    self.preIndex = self.currentIndex;
    
    self.currentIndex = index;
    
    [self controllerWillDisappearAtIndex:self.preIndex];
    
    [self controllerDidDisappearAtIndex:self.preIndex];
    
    [self relayoutCurrentControllerIfNeed];
    
    [self controllerWillAppearAtIndex:self.currentIndex];
    
    if (!animated) {
        
        [self controllerDidAppearAtIndex:self.currentIndex];
    }
    
    [self relayoutPreControllerIfNeed];
    
    [self relayoutNextControllerIfNeed];
    
    self.shouldNotice = NO;
    
    [self.containerView setContentOffset:CGPointMake(index * self.containerView.frame.size.width, 0) animated:YES];
    
}

 //----------------------------------delegate--------------------------------//

-(void)updateControllersAppearanceStautsWhenEndCelerating{
    
    [self controllerWillAppearAtIndex:self.currentIndex];
    [self controllerDidAppearAtIndex:self.currentIndex];
    
    [self controllerWillDisappearAtIndex:self.currentIndex - 1];
    [self controllerDidDisappearAtIndex:self.currentIndex - 1];
    
    [self controllerWillDisappearAtIndex:self.currentIndex + 1];
    [self controllerDidDisappearAtIndex:self.currentIndex + 1];
    
    if (self.preIndex < self.currentIndex - 1 || self.preIndex > self.currentIndex + 1) {
        
        [self controllerWillDisappearAtIndex:self.preIndex];
        [self controllerDidDisappearAtIndex:self.preIndex];
    }
}

-(void)updateControllersAppearanceStautsWhenDraging {
    
    if (!self.isDragging) {
        
        return;
    }
    
    if (self.potentialNextIndex == self.currentIndex - 1 && self.potentialNextIndex > 0) {
        
        [self controllerWillAppearAtIndex:self.potentialNextIndex];
        [self controllerWillDisappearAtIndex:self.currentIndex];
        [self controllerWillDisappearAtIndex:self.currentIndex + 1];
        [self controllerDidDisappearAtIndex:self.currentIndex + 1];
    }else if (self.potentialNextIndex == self.currentIndex + 1 && self.potentialNextIndex < self.numberOfControllers) {
        
        [self controllerWillAppearAtIndex:self.potentialNextIndex];
        [self controllerWillDisappearAtIndex:self.currentIndex];
        [self controllerWillDisappearAtIndex:self.currentIndex - 1];
        [self controllerDidDisappearAtIndex:self.currentIndex - 1];
        
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.preIndex = self.currentIndex;
    self.preContentOffset = self.containerView.contentOffset;
    self.isDragging = YES;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    self.isDragging = NO;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self controllerDidAppearAtIndex:self.currentIndex];
    
    self.shouldNotice = YES;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    self.hasProcessForwardAppearance = false;
    self.currentIndex = [self caculateCurrentIndex];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewControllerPageChange: andPageChange:)]) {
        
        [self.delegate pageViewControllerPageChange:self andPageChange:self.currentIndex];
    }
    
    if (self.dataSource != nil) {
        
        if (self.preIndex != self.currentIndex) {
            
            [self relayoutCurrentControllerIfNeed];
            [self updateControllersAppearanceStautsWhenEndCelerating];
            [self relayoutPreControllerIfNeed];
            [self relayoutNextControllerIfNeed];
        }else {
            
            [self updateControllersAppearanceStautsWhenEndCelerating];
        }
    }
    
    self.shouldNotice = YES;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetX = 4;
    
    if (self.shouldNotice) {
    
        CGFloat width = self.containerView.frame.size.width;
        CGFloat cusX = self.containerView.contentOffset.x;
        NSInteger fromPage = self.currentIndex;
        CGFloat pageX = fromPage * width;
        CGFloat progress = (cusX - pageX) / width;
        if (progress != -1 && progress != 1) {
            
            fromPage += (NSInteger)progress;
            progress = progress - (NSInteger)progress;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewControllerScrollProgress: andProgress: andFromPage:)]) {
            
            [self.delegate pageViewControllerScrollProgress:self andProgress:progress andFromPage:fromPage];
        }
        
        if (self.containerView.contentOffset.x - self.preContentOffset.x > offsetX) {
            
            if (self.potentialNextIndex < self.currentIndex || !self.hasProcessForwardAppearance) {
                
                self.potentialNextIndex = self.currentIndex + 1;
                [self updateControllersAppearanceStautsWhenDraging];
                self.hasProcessForwardAppearance = YES;
            }
        }else if (self.containerView.contentOffset.x - self.preContentOffset.x < - offsetX){
            
            if (self.potentialNextIndex > self.currentIndex || !self.hasProcessForwardAppearance) {
                
                self.potentialNextIndex = self.currentIndex - 1;
                [self updateControllersAppearanceStautsWhenDraging];
                self.hasProcessForwardAppearance = YES;
            }

        }
        
    }
}

 //----------------------------------子控制器生命周期--------------------------------//

-(void)controllerWillAppearAtIndex:(NSInteger)index{
    
    UIViewController *controller = [self childControllerForIndex:index];
    
    if (controller != nil) {
        
        if (controller.appearanceStatus == willAppearStatus || controller.appearanceStatus == didAppearStatus) {
            
            return;
        }
        
        [controller notifyWillAppear:true];
    }
}

-(void)controllerDidAppearAtIndex:(NSInteger)index{
    
    UIViewController *controller = [self childControllerForIndex:index];
    
    if (controller != nil) {
        
        if (controller.appearanceStatus == didAppearStatus) {
            
            return;
        }
        
        [controller notifyDidAppear:true];
    }

}

-(void)controllerWillDisappearAtIndex:(NSInteger)index{
    
    UIViewController *controller = [self childControllerForIndex:index];
    
    if (controller != nil) {
        
        if (controller.appearanceStatus == willDisappearStatus || controller.appearanceStatus == didDisappearStatus) {
            
            return;
        }
        
        [controller notifyWillDisappear:true];
    }
    

}

-(void)controllerDidDisappearAtIndex:(NSInteger)index{
    
    UIViewController *controller = [self childControllerForIndex:index];
    
    if (controller != nil) {
        
        if (controller.appearanceStatus == didDisappearStatus) {
            
            return;
        }
        
        [controller notifyDidDisappear:true];
    }

}

#pragma set/get

-(void)setIsScrollEnabled:(BOOL)isScrollEnabled{
    
    _isScrollEnabled = isScrollEnabled;
}

-(void)setDataSource:(id<XWPageViewControllerDataSource>)dataSource{
    
    _dataSource = dataSource;
    
    [self relayout];
}

-(UIScrollView *)containerView{
    
    if (_containerView == nil) {
        
        _containerView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _containerView.showsVerticalScrollIndicator = NO;
        _containerView.showsHorizontalScrollIndicator = NO;
        [_containerView setPagingEnabled:YES];
        _containerView.alwaysBounceVertical = NO;
        _containerView.bouncesZoom = NO;
        _containerView.bounces = NO;
        _containerView.delegate = self;
        
    }
    
    return _containerView;
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
