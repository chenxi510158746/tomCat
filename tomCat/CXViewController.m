//
//  CXViewController.m
//  tomCat
//
//  Created by 陈溪 on 14-9-11.
//  Copyright (c) 2014年 chenxi. All rights reserved.
//

#import "CXViewController.h"

@interface CXViewController ()
{
    NSDictionary *_dict;
}
@end

@implementation CXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //获取系统目录
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"tom" ofType:@"plist"];
    
    //读取字典数据
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(UIButton *)sender {
    
    if (_tomCatImage.isAnimating) {
        return;
    }
    
    //获取按钮标题
    NSString *title = [sender titleForState:UIControlStateNormal];
    
    //在字典中找到标题对应的数量
    int count = [_dict[title] intValue];
    
    //调用动画方法
    [self doAnimation:count imgfix:title];
    
}

- (void)doAnimation:(int)count imgfix:(NSString *)imgfix
{
    NSMutableArray *imgArr = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        NSString *imgName = [NSString stringWithFormat:@"%@_%02d.jpg", imgfix, i];
        
        //有缓存加载图片，缓存不会被释放
        //UIImage *img = [UIImage imageNamed:imgName];
        
        //无缓存加载图片
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *imgPath = [bundle pathForResource:imgName ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:imgPath];
        
        [imgArr addObject:img];
    }
    
    //添加动画图片
    _tomCatImage.animationImages = imgArr;
    
    //设置动画播放次数
    _tomCatImage.animationRepeatCount = 1;
    
    //设置动画播放速度
    _tomCatImage.animationDuration = 0.1 * count;
    
    //开始动画
    [_tomCatImage startAnimating];
}

@end
