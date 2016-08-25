//
//  HBChangeImg.m
//  ScrollViewPageDemo
//
//  Created by healthmanage on 16/8/23.
//  Copyright © 2016年 healthmanager. All rights reserved.
//实现图片轮转

#import "HBChangeImg.h"

#define f_Device_w         [UIScreen mainScreen].bounds.size.width
#define f_Device_h  	    [UIScreen mainScreen].bounds.size.height
/// 根据iphone5 的效果图 尺寸比例 算出实际尺寸
#define f_i5real(f)              ( ( (int)( (f_Device_w * ((f)/320.f)) * 2 ) ) / 2.f )
/// 根据iphone6 的效果图 尺寸比例 算出实际尺寸
#define f_i6real(f)              ( ( (int)( (f_Device_w * ((f)/375.f)) * 2 ) ) / 2.f )
/// 根据iphone6 PLUS 的效果图 尺寸比例 算出实际尺寸
#define f_i6Preal(f)              ( ( (int)( (f_Device_w * ((f)/414.f)) * 2 ) ) / 2.f )

@implementation HBChangeImg

-(instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)aImgArray styleStr:(NSString *)aStyleStr
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //取数据
        _rectFrame = frame;
        _speedI = frame.size.width;
        _imgArray = [NSArray arrayWithArray:aImgArray];
        _styleStr = aStyleStr;
        
        //添加滑动视图
        _imgScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _rectFrame.size.width, _rectFrame.size.height)];
        _imgScrollV.backgroundColor = [UIColor lightGrayColor];
        _imgScrollV.delegate = self;
        _imgScrollV.showsVerticalScrollIndicator = NO;
        _imgScrollV.showsHorizontalScrollIndicator = NO;
        _imgScrollV.pagingEnabled = YES;
        _imgScrollV.contentSize = CGSizeMake(_rectFrame.size.width*aImgArray.count, _rectFrame.size.height);
        [self addSubview:_imgScrollV];
        
        //添加图片
        for (int i = 0; i < aImgArray.count; i++)
        {
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(_rectFrame.size.width*i, 0, _rectFrame.size.width, _rectFrame.size.height)];
            imgV.image = [UIImage imageNamed:aImgArray[i]];
            [_imgScrollV addSubview:imgV];
        }
        
        //添加动点
        _imgPageC = [[UIPageControl alloc] initWithFrame:CGRectMake(_rectFrame.size.width-110, _rectFrame.size.height-30, 100, 30)];
        //点数量
        _imgPageC.numberOfPages = aImgArray.count;
        //当前点的颜色
        _imgPageC.currentPageIndicatorTintColor = [UIColor redColor];
        //未选中点的颜色
        _imgPageC.pageIndicatorTintColor = [UIColor yellowColor];
        [self addSubview:_imgPageC];
        
        _timerR = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(imgMove) userInfo:nil repeats:YES];
    }
    return self;
}
#pragma mark ------- UIScrollViewDelegate方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _imgPageC.currentPage = _imgScrollV.contentOffset.x/_rectFrame.size.width;
    //发射一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"imgClickImg" object:self userInfo:@{@"imgIndex":[NSString stringWithFormat:@"%d",_imgPageC.currentPage]}];
}
#pragma mark ------- 定时器方法
-(void)imgMove
{
    if ([_styleStr isEqualToString:@"1"])
    {
        //来回轮转
        if (_imgScrollV.contentOffset.x>=_rectFrame.size.width*(_imgArray.count-1))
        {
            _speedI = -_rectFrame.size.width;
        }
        else if (_imgScrollV.contentOffset.x<=0)
        {
            _speedI = _rectFrame.size.width;
        }
        _imgScrollV.contentOffset = CGPointMake(_imgScrollV.contentOffset.x+_speedI, 0);
        _imgPageC.currentPage = _imgScrollV.contentOffset.x/(_rectFrame.size.width);
    }
    else
    {
        //一个方向轮转
        if (_imgScrollV.contentOffset.x>=_rectFrame.size.width*(_imgArray.count-1))
        {
            _imgScrollV.contentOffset = CGPointMake(0, 0);
            _imgPageC.currentPage = _imgScrollV.contentOffset.x/(_rectFrame.size.width);
        }
        else
        {
            _imgScrollV.contentOffset = CGPointMake(_imgScrollV.contentOffset.x+_speedI, 0);
            _imgPageC.currentPage = _imgScrollV.contentOffset.x/(_rectFrame.size.width);
        }
    }
    //发射一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"imgClickImg" object:self userInfo:@{@"imgIndex":[NSString stringWithFormat:@"%d",_imgPageC.currentPage]}];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
