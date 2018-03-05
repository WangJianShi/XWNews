//
//  NewsFeedViewController.m
//  XWNews
//
//  Created by serein on 2018/2/24.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "NewsFeedViewController.h"

@interface NewsFeedViewController ()

@property (nonatomic,strong) XWCollectionView *cv;

@end

@implementation NewsFeedViewController

-(instancetype)initWithIndex:(NSInteger)index{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        
        self.index = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.cv beginRefreshing];
}

-(void)setUpUI{
    
    self.view.backgroundColor = white_Color;
    [self.view addSubview:self.cv];
    [self.cv mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.top.bottom.trailing.mas_equalTo(0);
    }];
}

#pragma mark -
#pragma mark   set/get

-(XWCollectionView *)cv{
    
    if (_cv == nil) {
        
        _cv = [XWCollectionView createWithFlowLayout];
        _cv.backgroundColor = kColor(@"f6f6f6");
        _cv.refreshType = XWCollectionViewRefreshTypeHeaderFooter;
        
    }
    return _cv;
    
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
