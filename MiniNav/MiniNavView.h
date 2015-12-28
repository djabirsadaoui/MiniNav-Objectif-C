//
//  MiniNavView.h
//  MiniNav
//
//  Created by m2sar on 27/10/2014.
//  Copyright (c) 2014 m2sar. All rights reserved.
//

#import "UIKit/UIKit.h"

@interface MiniNavView : UIView <UIWebViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>

@property (retain, nonatomic) IBOutlet  UIWebView *wv;
@property (retain, nonatomic) IBOutlet  UIAlertView *alertURL, *alertURLHome;
@property (retain, nonatomic) IBOutlet  UIActionSheet *changedComfirm;
@property (retain, nonatomic) IBOutlet  UIToolbar *toolBar;
@property (retain, nonatomic) IBOutlet  UIBarButtonItem *backtbb, *forwdtbb, *hometbb, *changehometbb, *urltbb;
@property (retain, nonatomic) UIActivityIndicatorView *spinner;


@end