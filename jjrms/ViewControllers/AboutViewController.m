//
//  AboutViewController.m
//  jjrms
//
//  Created by user on 16/10/25.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
{
    UIWebView *_webView;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //状态栏
    /*
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor colorWithHexString:@"#343b47"];
    }
     */
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarView.backBut.hidden=NO;
    self.navBarView.titleLab.text=NSLocalizedString(@"about_my",nil);
    self.view.backgroundColor=[UIColor whiteColor];
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, self.navBarView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _webView.scrollView.bounces=NO;
    _webView.delegate=self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    NSString *str=[NSString stringWithFormat:@"%@%@",HOSTAPI_H5,@"appwap/aboutus"];
    NSURL* url = [NSURL URLWithString:str];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_webView loadRequest:request];//加载

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //[webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];//修改百分比即可
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
