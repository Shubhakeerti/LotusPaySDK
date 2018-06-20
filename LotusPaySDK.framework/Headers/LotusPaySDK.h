//
//  LotusPaySDK.h
//  LotusPaySDK
//
//  Created by Shubhakeerti on 13/06/18.
//  Copyright © 2018 Shubhakeerti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//! Project version number for LotusPaySDK.
FOUNDATION_EXPORT double LotusPaySDKVersionNumber;

//! Project version string for LotusPaySDK.
FOUNDATION_EXPORT const unsigned char LotusPaySDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <LotusPaySDK/PublicHeader.h>

@interface LotusPaySDK : NSObject

+ (void)initializeWithPaymentURL:(NSString *)urlString onController:(UIViewController *)controller completionBlock:(void (^) (BOOL, NSString*))completionBlock;

+ (void)dismissSDK:(BOOL)animated;
@end
