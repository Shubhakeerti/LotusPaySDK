//
//  LPUtility.h
//  LotusPay
//
//  Created by Shubhakeerti on 12/06/18.
//  Copyright © 2018 Shubhakeerti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ CompletionBlock)(BOOL, NSString *);

@interface LPUtility : NSObject

@property (nonatomic, copy) CompletionBlock completionBlock;
@property (nonatomic, weak) UIViewController *clientPresentingViewController;
@property (nonatomic, strong) NSString *paymentURL;
@property (nonatomic, weak) UIViewController *webViewController;

+ (nonnull LPUtility *)sharedUtility;
- (NSBundle *)getFrameworkBundle;
- (void)presentViewController;
@end
