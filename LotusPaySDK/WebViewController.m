//
//  WebViewController.m
//  LotusPay
//
//  Created by Shubhakeerti on 06/06/18.
//  Copyright © 2018 Shubhakeerti. All rights reserved.
//

#import "WebViewController.h"
#import "LPUtility.h"

@interface WebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *loadingIndicatorView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

//#if DEBUG

@implementation NSURLRequest (NSURLRequestWithIgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}

@end

//#endif

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
    [self setupNavigation];
    [self showLoadingIndicator];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl]];
    [self.webView loadRequest:urlRequest];
    // Do any additional setup after loading the view.
}

#pragma mark - UI Methods

- (void)initialSetup {
    self.loadingIndicatorView.hidden = true;
    self.webView.delegate = self;
}

- (void)setupNavigation {
    self.title = @"LotusPay";
    [self setBackButton];
}

- (void)setBackButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [UIImage imageNamed:@"close" inBundle:[[LPUtility sharedUtility] getFrameworkBundle] compatibleWithTraitCollection:nil];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    button.frame = CGRectMake(0, 0, 50.0, 40.0);
    [button addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
}

- (void)backButtonTapped {
    if (self.navigationController.viewControllers.count == 1)
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Helper methods

- (void)showLoadingIndicator {
    self.loadingIndicatorView.hidden = false;
    [self.loadingIndicator startAnimating];
}

- (void)hideLoadingIndicator {
    self.loadingIndicatorView.hidden = true;
    [self.loadingIndicator stopAnimating];
}

- (void)handleResponse:(NSDictionary *)responseDict {
    NSInteger code = [responseDict[@"code"] integerValue];
    NSString *message = responseDict[@"message"];
    BOOL success;
    if (code == 200) {
        success = true;
    } else {
        success = false;
    }
    [LPUtility sharedUtility].completionBlock(success, message);
}

#pragma mark - WebView Delegates

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self showLoadingIndicator];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *jsonString = [_webView stringByEvaluatingJavaScriptFromString:@"str"];
    if (jsonString && [jsonString length] > 0) {
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [self handleResponse:jsonDictionary];
    }
    [self hideLoadingIndicator];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error : %@", error.description);
    NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:@"400", @"code", error.localizedDescription, @"message", nil];
    [self handleResponse:errorDict];
    [self hideLoadingIndicator];
}
@end
