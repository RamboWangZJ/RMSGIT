//
//  NewsDetailViewController.m
//  jjrms
//
//  Created by user on 16/10/24.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "Commen.h"
@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController
{
    UIWebView *_webView;

}

- (void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navBarView.titleLab.text=NSLocalizedString(@"xiaoxixiangqing_new",nil);
    self.navBarView.backBut.hidden=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _webView.scrollView.bounces=NO;
    _webView.delegate=self;
    [self.view addSubview:_webView];
    _webView.scalesPageToFit = YES;

    NSString *str=[NSString stringWithFormat:@"%@appwap/noticedetail?sn=%@",HOSTAPI_H5,_model.notice_sn];
    NSURL* url = [NSURL URLWithString:str];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_webView loadRequest:request];//加载
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%s",__func__);
    [SVProgressHUD show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
    //NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0,width=device-width, maximum-scale=1.0, user-scalable=no\"", webView.frame.size.width];
    //[webView stringByEvaluatingJavaScriptFromString:meta];
    //[webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '60%'"];//修改百分比即可

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
