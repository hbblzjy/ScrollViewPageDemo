//
//  ViewController.m
//  ScrollViewPageDemo
//
//  Created by healthmanage on 16/8/23.
//  Copyright © 2016年 healthmanager. All rights reserved.
//

#import "ViewController.h"
#import "HBChangeImg.h"

@interface ViewController ()

@property(nonatomic,strong)UIImageView *clickImgV;
@property(nonatomic,assign)NSInteger currentImgIndex;
@property(nonatomic,strong)NSArray *imgArray1;
@property(nonatomic,strong)NSArray *imgArray2;

@end

#define f_Device_w         [UIScreen mainScreen].bounds.size.width
#define f_Device_h  	    [UIScreen mainScreen].bounds.size.height
/// 根据iphone5 的效果图 尺寸比例 算出实际尺寸
#define f_i5real(f)              ( ( (int)( (f_Device_w * ((f)/320.f)) * 2 ) ) / 2.f )
/// 根据iphone6 的效果图 尺寸比例 算出实际尺寸
#define f_i6real(f)              ( ( (int)( (f_Device_w * ((f)/375.f)) * 2 ) ) / 2.f )
/// 根据iphone6 PLUS 的效果图 尺寸比例 算出实际尺寸
#define f_i6Preal(f)              ( ( (int)( (f_Device_w * ((f)/414.f)) * 2 ) ) / 2.f )

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _imgArray1 = @[@"11.jpg",@"22.jpg",@"33.jpg",@"44.jpg",@"55.jpg",@"66.jpg",@"77.jpg"];
    
    //添加一个通知，为了获取pageControl的索引值，从而获取到是哪张图
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateImgIndex:) name:@"imgClickImg" object:nil];
    
    //创建初始化,参数传：1，来回轮转
    HBChangeImg *hbCImg1 = [[HBChangeImg alloc] initWithFrame:CGRectMake(0, 20, f_Device_w, 200) imgArray:_imgArray1 styleStr:@"1"];
    //添加手势，可以实现点击图片进入详情界面
    UITapGestureRecognizer *tapGestureR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImg:)];
    [hbCImg1 setUserInteractionEnabled:YES];
    [hbCImg1 addGestureRecognizer:tapGestureR];
    [self.view addSubview:hbCImg1];
    UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, f_Device_w, 30)];
    titleLabel1.text = @"styleStr:1..表示来回轮转";
    titleLabel1.font = [UIFont systemFontOfSize:14];
    titleLabel1.textColor = [UIColor redColor];
    titleLabel1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel1];
    
    _clickImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 250, f_Device_w, 200)];
    _clickImgV.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_clickImgV];
    
    /*
     //注意两种方式不要放在一个界面中，否则点击事件无法判断执行
    //一个方向轮转
    _imgArray2 = @[@"77.jpg",@"66.jpg",@"55.jpg",@"44.jpg",@"33.jpg",@"22.jpg",@"11.jpg"];
    //创建初始化,参数传：2，一个方向轮转,默认为：一个方向轮转
    HBChangeImg *hbCImg2 = [[HBChangeImg alloc] initWithFrame:CGRectMake(0, 250, f_Device_w, 200) imgArray:_imgArray2 styleStr:@"2"];
    [self.view addSubview:hbCImg2];
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 450, f_Device_w, 30)];
    titleLabel2.text = @"styleStr:2或nil..表示一个方向轮转";
    titleLabel2.font = [UIFont systemFontOfSize:14];
    titleLabel2.textColor = [UIColor blueColor];
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel2];
     */
    
}
#pragma mark --- 点击图片执行的方法
-(void)clickImg:(UITapGestureRecognizer *)tapGestureR
{
    //第一种方式
    _clickImgV.image = [UIImage imageNamed:_imgArray1[_currentImgIndex]];
    //第二种方式
    //_clickImgV.image = [UIImage imageNamed:_imgArray2[_currentImgIndex]];
}
#pragma mark --- 通知的方法
-(void)updateImgIndex:(NSNotification *)nsnotifi
{
    NSDictionary *dic = nsnotifi.userInfo;
    NSString *imgIndexStr = dic[@"imgIndex"];
    //NSLog(@"输出此时是第几张图.......%@",imgIndexStr);
    _currentImgIndex = [imgIndexStr integerValue];
    //https://github.com/hbblzjy/ScrollViewPageDemo
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
