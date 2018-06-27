//
//  ViewController.m
//  CoBkzProject
//
//  Created by leo on 2018/6/19.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ViewController.h"
#import "TodayTaskView.h"
#import "SDAutoLayout.h"
#import "TaskListView.h"
#import "EveryDayView.h"
#import "WordViewController.h"
#import "NetWorkRequest.h"
#import "TopView.h"

#define RGB2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0)  alpha:1]

@interface ViewController ()

@end

@implementation ViewController{
    
    UIScrollView *baseScrollView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"学习主页";
    
    baseScrollView = [UIScrollView new];
    baseScrollView.alwaysBounceVertical = YES;
    baseScrollView.alwaysBounceHorizontal = NO;
    baseScrollView.showsVerticalScrollIndicator = NO;
    baseScrollView.showsHorizontalScrollIndicator = NO;
    baseScrollView.backgroundColor = RGB2UIColor(246, 246, 246);
    [self.view addSubview:baseScrollView];
    baseScrollView.sd_layout.
    topSpaceToView(self.view, 0).
    leftSpaceToView(self.view, 0).
    rightSpaceToView(self.view, 0).
    bottomSpaceToView(self.view, 0);
    
//    EveryDayView *everyView = [EveryDayView new];
//    everyView.backgroundColor = [UIColor whiteColor];
////    [baseScrollView addSubview:everyView];
//    everyView.sd_layout.
//    leftSpaceToView(baseScrollView, 0).
//    rightSpaceToView(baseScrollView, 0).
//    topSpaceToView(listView, 10);
    
    
    
    [self loadRequestion];
}

- (void)loadRequestion{
    
    [NetWorkRequest getDataShowHUD:YES withUrl:nil parameter:nil andResponse:^(NSInteger code, id contentData, NSDictionary *exData) {
        
        [self buildUI:contentData];        
    }];
}

- (void)buildUI:(NSArray *)listArray{
    
    TopView *topView = [[TopView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    topView.backgroundColor = [UIColor whiteColor];
    [baseScrollView addSubview:topView];
    topView.sd_layout.
    topSpaceToView(baseScrollView, 0).
    leftSpaceToView(baseScrollView, 0).
    rightSpaceToView(baseScrollView, 0);
    
    TodayTaskView *dayTaskView = [[TodayTaskView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    dayTaskView.backgroundColor = [UIColor whiteColor];
    [baseScrollView addSubview:dayTaskView];
    dayTaskView.sd_layout.
    topSpaceToView(topView, 10).
    leftSpaceToView(baseScrollView, 0).
    rightSpaceToView(baseScrollView, 0);
    
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoWordVC)];
    [dayTaskView addGestureRecognizer:pan];
    
    TaskListView *listView = [[TaskListView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)withArray:listArray withSuperView:self];
    listView.userInteractionEnabled = YES;
    listView.backgroundColor = [UIColor whiteColor];
    [baseScrollView addSubview:listView];
    listView.sd_layout.
    topSpaceToView(dayTaskView, 1).
    leftSpaceToView(baseScrollView, 0).
    rightSpaceToView(baseScrollView, 0);

    [baseScrollView setupAutoContentSizeWithBottomView:listView bottomMargin:20];

}

- (void)gotoWordVC{
    
    WordViewController *VC = [[WordViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
