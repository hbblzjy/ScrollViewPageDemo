//
//  HBChangeImg.h
//  ScrollViewPageDemo
//
//  Created by healthmanage on 16/8/23.
//  Copyright © 2016年 healthmanager. All rights reserved.
//实现图片轮转,方式一：来回轮转，方式二：一个方向轮转

#import <UIKit/UIKit.h>

@interface HBChangeImg : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *imgScrollV;//图片轮转滑动视图
@property(nonatomic,strong)NSArray *imgArray;//图片数组
@property(nonatomic,strong)UIPageControl *imgPageC;//动点
@property(nonatomic,strong)NSTimer *timerR;//定时器
@property(nonatomic,copy)NSString *styleStr;//1：表示来回轮转，2：表示一个方向轮转
@property(nonatomic,assign)CGRect rectFrame;//方位值
@property(nonatomic,assign)NSInteger speedI;//滑动速度

//初始化方法,三个参数必须填写
-(instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)aImgArray styleStr:(NSString *)aStyleStr;

@end
