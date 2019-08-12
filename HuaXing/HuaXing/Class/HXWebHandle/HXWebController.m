//
//  HXWebController.m
//  HuaXing
//
//  Created by hxwyh on 2019/8/9.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXWebController.h"
#import <WebKit/WebKit.h>
#import "JXWKWeb.h"

@interface HXWebController ()<WKNavigationDelegate>

@property (nonatomic,strong) JXWKWeb                *wkweb;
@property (nonatomic,strong) UIProgressView         *progressview;

@end

@implementation HXWebController

#pragma mark ------ life cycle

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self addObserver];
}

- (void)setupUI {
    [self.view addSubview:self.wkweb];
    [self.view addSubview:self.progressview];
    self.wkweb.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    self.progressview.sd_layout
    .leftEqualToView(self.wkweb)
    .topEqualToView(self.wkweb)
    .rightEqualToView(self.wkweb)
    .heightIs(1.0);
    self.progressview.hidden = FALSE;
}

-(void)dealloc {
    [self removeObserver];
}

#pragma mark ------ load data source

-(void)setURLString:(NSString *)URLString {
    if (URLString) {
        _URLString = URLString;
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
        [self.wkweb loadRequest:req];
    }
}

-(void)setFilePath:(NSString *)filePath {
    if (filePath) {
        _filePath = filePath;
        // 加载本地资源
        // 1.
        // NSString *htmlString= [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        // [self.wkweb loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:filePath]]; //此处 BaseURL 不可随意填写 [NSURL URLWithString:@"www.baidu.com"]
        
        // 2.
        // [self.wkweb loadFileURL:[NSURL fileURLWithPath:filePath] allowingReadAccessToURL:[NSURL fileURLWithPath:filePath]];
        
        // 3.
         NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]];
         [self.wkweb loadRequest:req];
    }
}

#pragma mark ------ observer

- (void)addObserver {
    [self.wkweb addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)removeObserver {
    [self.wkweb removeObserver:self forKeyPath:@"estimatedProgress"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"] && self.wkweb) {
        self.progressview.progress = self.wkweb.estimatedProgress;
        self.progressview.hidden   = self.wkweb.estimatedProgress >= 1.0 ? TRUE : FALSE;
    }
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


#pragma mark ------

#pragma mark ------ lazy load

-(JXWKWeb *)wkweb {
    if (!_wkweb) {
        WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
        //cfg.allowsInlineMediaPlayback = TRUE;
        //cfg.preferences.minimumFontSize = 9.0;
        _wkweb = [[JXWKWeb alloc] initWithFrame:CGRectZero configuration:cfg];
        _wkweb.navigationDelegate = (id)self;
        //_wkweb.allowsBackForwardNavigationGestures = TRUE;
        //_wkweb.opaque = FALSE;
        if (@available(iOS 11.0, *)) {
            _wkweb.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _wkweb;
}


-(UIProgressView *)progressview {
    if (!_progressview) {
        _progressview = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressview.backgroundColor = [UIColor clearColor];
        _progressview.tintColor = [UIAdapter mainBlue];
        _progressview.trackTintColor = [UIColor clearColor];
        _progressview.progress = 0.f;
    }
    return _progressview;
}

@end
