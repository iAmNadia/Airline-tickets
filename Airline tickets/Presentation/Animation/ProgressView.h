//
//  ProgressView.h
//  Airline tickets
//
//  Created by NadiaMorozova on 27.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

+ (instancetype)sharedInstance;

- (void)show:(void (^)(void))completion;
- (void)dismiss:(void (^)(void))completion;

@end

