//
//  LPUtility.m
//  LotusPay
//
//  Created by Shubhakeerti on 12/06/18.
//  Copyright © 2018 Shubhakeerti. All rights reserved.
//

#import "LPUtility.h"
#import "WebViewController.h"

@implementation LPUtility
static LPUtility *sharedUtility = nil;

+ (nonnull instancetype)sharedUtility{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUtility = [[self alloc] init];
    });
    return sharedUtility;
}

- (NSBundle *)getFrameworkBundle {
    return [NSBundle bundleForClass:[LPUtility class]];
}

- (UIStoryboard *)getStoryBoardInstance {
    return [UIStoryboard storyboardWithName:@"Main" bundle:[self getFrameworkBundle]];
}

- (void)presentViewController {
    WebViewController *webViewController = [[self getStoryBoardInstance] instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.requestUrl = self.paymentURL;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webViewController];
    [self setWebViewController: navigationController];
    [self.clientPresentingViewController presentViewController:navigationController animated:true completion:nil];
}
@end
