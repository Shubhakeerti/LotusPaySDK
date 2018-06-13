//
//  LotusPaySDK.m
//  LotusPaySDK
//
//  Created by Shubhakeerti on 13/06/18.
//  Copyright © 2018 Shubhakeerti. All rights reserved.
//

#import "LotusPaySDK.h"
#import "LPUtility.h"

@implementation LotusPaySDK

+ (void)initializeWithPaymentURL:(NSString *)urlString onController:(UIViewController *)controller completionBlock:(void (^) (BOOL, NSString*))completionBlock {
    [[LPUtility sharedUtility] setCompletionBlock:completionBlock];
    [[LPUtility sharedUtility] setClientPresentingViewController:controller];
    [[LPUtility sharedUtility] setPaymentURL:urlString];
    
    [[LPUtility sharedUtility] presentViewController];
}

@end
