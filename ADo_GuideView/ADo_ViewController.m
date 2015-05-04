//
//  ADo_ViewController.m
//  ADo_GuideView
//
//  Created by dwx on 15/5/1.
//  Copyright (c) 2015年 Nododo. All rights reserved.
//

#import "ADo_ViewController.h"
#import "ADo_SecViewController.h"
#import "UIView+Extension.h"
#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height
@interface ADo_ViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *guideView;
@property (nonatomic,strong)UIImageView *picView;
@property (nonatomic,strong)UIImageView *paiView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)UIScrollView *topView;
@end

@implementation ADo_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backView = [[UIImageView alloc]initWithFrame:self.view.frame];
    backView.image = [UIImage imageNamed:@"page_bg_35"];
   
    [self.view addSubview:backView];

    UIScrollView *ado_guideView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    ado_guideView.contentSize = CGSizeMake(screenW * 5, screenH);
    ado_guideView.bounces = NO;
    ado_guideView.pagingEnabled = YES;
    ado_guideView.delegate = self;
    ado_guideView.showsHorizontalScrollIndicator = NO;
    
    
    UIImageView *picView = [[UIImageView alloc] init];
    picView.width = 2330 / 2.0;
    picView.height = 2330 / 2.0;
    picView.centerX = screenW / 2;
    picView.centerY = screenH + 200;
    picView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    picView.image = [UIImage imageNamed:@"guider_qiu_35"];
    
    
    UIImageView *paiView = [[UIImageView alloc] init];
    paiView.width = 2330 / 2.0;
    paiView.height = 2330 / 2.0;
    paiView.centerX = screenW / 2 ;
    paiView.centerY = screenH + 200;
    paiView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    paiView.image = [UIImage imageNamed:@"guider_pai_35"];
    
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(screenW / 2 - 50, screenH - 20, 100, 20)];
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [backView addSubview:pageControl];
    
    
    UIScrollView *topView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, screenW, 70)];
    topView.contentSize = CGSizeMake(screenW * 5, 70);
    topView.bounces = NO;
    topView.pagingEnabled = YES;
    for (int i = 0; i < 5; i ++) {
        UIImageView *topPic =  [[UIImageView alloc] init];
        topPic.width = 112;
        topPic.height = 70;
        topPic.centerX = i * screenW + screenW / 2;
        topPic.y = 0;
        NSString *picName = [NSString stringWithFormat:@"page_top_%d",i];
        topPic.image = [UIImage imageNamed:picName];
        [topView addSubview:topPic];
    }
    [backView addSubview:topView];
    self.topView = topView;
    
    self.pageControl = pageControl;
    [self.view addSubview:paiView];
    [self.view addSubview:picView];
    [self.view addSubview:ado_guideView];
    self.guideView = ado_guideView;
    self.picView = picView;
    self.paiView = paiView;

}


- (void)go2MainVC:(UIButton *)btn
{
    ADo_SecViewController *secVC = [[ADo_SecViewController alloc] init];
    secVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:secVC animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offSetX = scrollView.contentOffset.x;
    self.picView.layer.transform = CATransform3DMakeRotation(-offSetX*(M_PI)/screenW / 3, 0, 0, 1);
    self.paiView.layer.transform = CATransform3DMakeRotation(-offSetX*(M_PI)/screenW / 3, 0, 0, 1);
    self.pageControl.currentPage = scrollView.contentOffset.x / screenW;
    
   
    if (self.pageControl.currentPage == 4) {
        UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenW / 2  + offSetX - 70, screenH - 121, 140, 35)];
        [nextBtn addTarget:self action:@selector(go2MainVC:) forControlEvents:UIControlEventTouchUpInside];
        nextBtn.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:nextBtn];
    }
   

    self.topView.contentOffset = CGPointMake(offSetX, 0);
}

@end
