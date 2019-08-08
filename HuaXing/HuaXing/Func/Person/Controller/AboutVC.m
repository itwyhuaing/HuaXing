//
//  AboutVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/8.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "AboutVC.h"
#import <WebKit/WebKit.h>

@interface AboutVC () <WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *wkweb;

@end

@implementation AboutVC

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于";
    [self.view addSubview:self.wkweb];
    // 加载本地资源
    NSBundle *mainBudle = [NSBundle mainBundle];
    NSString *filePath  = [mainBudle pathForResource:@"abouthx" ofType:@"html"];
    NSString *htmlString= [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.wkweb loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:filePath]]; //此处 BaseURL 不可随意填写 [NSURL URLWithString:@"www.baidu.com"]

//    2.
//    [self.wkweb loadFileURL:[NSURL fileURLWithPath:filePath] allowingReadAccessToURL:[NSURL fileURLWithPath:filePath]];
    
    // 3.
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *htmlPath = [mainBudle pathForResource:@"abouthx" ofType:@"html"];
//    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]];
//    [self.wkweb loadRequest:req];
}

#pragma mark ------ WKNavigationDelegate

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"\n %s \n",__FUNCTION__);
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"\n %s \n",__FUNCTION__);
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"\n %s \n",__FUNCTION__);
}

-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"\n %s \n",__FUNCTION__);
}

#pragma mark ------ lazy load

-(WKWebView *)wkweb {
    if (!_wkweb) {
        WKWebViewConfiguration *webCfg = [[WKWebViewConfiguration alloc] init];
        _wkweb = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webCfg];
        _wkweb.backgroundColor = [UIColor redColor];
        _wkweb.navigationDelegate = (id)self;
    }
    return _wkweb;
}

@end
