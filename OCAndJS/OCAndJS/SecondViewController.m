//
//  SecondViewController.m
//  OCAndJS
//
//  Created by DayHR on 2016/11/4.
//  Copyright © 2016年 lisiye. All rights reserved.
//

#import "SecondViewController.h"
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface SecondViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;//
@property(nonatomic,strong)WebViewJavascriptBridge * bridge;//桥接对象

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加webView
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    //加载H5页面
    NSString *resoucePath = [[NSBundle mainBundle] resourcePath];
    NSString * filePath = [resoucePath stringByAppendingPathComponent:@"index.html"];
    NSString * html = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    //js与oc交互传值---打开方式WebViewJavascriptBridge
    [WebViewJavascriptBridge enableLogging];//开启日志
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];// 给哪个webview建立JS与OjbC的沟通桥梁
    [_bridge setWebViewDelegate:self];//设置webView代理
    //js与oc交互传值---OC给JS传值
    [self.bridge callHandler:@"testJavascriptHandler" data:@{@"latitude":[NSNumber numberWithFloat:28.199439],@"lontitude":[NSNumber numberWithFloat:113.022366],@"cityName":@"长沙"}];
    //js与oc交互传值---注册接收从js传传过来的值的理者，唯一标识是“ testObjcCallback”，与js中代码相对应
    [self.bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        //这里面获取在H5界面返回的值，在data中
        NSLog(@"%@",data);
        responseCallback(@"Response from testObjcCallback");//block里面的值可以传到js中去，可以不写
    }];
    //添加一个返回的按钮
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];\
    [button setFrame:CGRectMake(10, 30, 55, 44)];
    [button setTitle:@"返回" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(backAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)backAction:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
