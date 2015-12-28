//
//  MiniNavView.m
//  MiniNav
//
//  Created by m2sar on 27/10/2014.
//  Copyright (c) 2014 m2sar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiniNavView.h"


@implementation MiniNavView

NSMutableString *homeURL ;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
        _wv = [[UIWebView alloc] init];
        [self addSubview:_wv];
        
        
        homeURL = [[NSMutableString alloc] initWithString:@"http://www.upmc.fr"];
        
        _spinner = [[UIActivityIndicatorView alloc]
                   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] ;
        
        [self addSubview:_spinner];
        
        
        
        
        _toolBar = [[UIToolbar alloc] init];
        [_toolBar setBarStyle:UIBarStyleDefault];
        [self addSubview:_toolBar];
        
        _backtbb = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(navBouttumTB:)];
        
        _forwdtbb = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(navBouttumTB:)];
        [self addSubview:_toolBar];
        
        [_backtbb setEnabled:false];
        [_forwdtbb setEnabled:false];
        
        
        _hometbb = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(homeTB:)];
        
        _changehometbb = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(changeHomeTB:)];
    
        
        _urltbb = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(urlTB:)];
        
        UIBarButtonItem *smallSp= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:@selector(alloc)];
        
        UIBarButtonItem *varSp= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:@selector(alloc)];
        
        [smallSp setWidth:20];
        
        
        [_toolBar setItems:[NSArray arrayWithObjects:_hometbb,varSp,_backtbb,smallSp,_urltbb,smallSp,_forwdtbb,varSp,_changehometbb, nil]];
        
        _alertURL = [[UIAlertView alloc] initWithTitle:@"URL" message:@"Entrez l'URL à charger" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"Ok", nil];
        [_alertURL setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [_alertURL setDelegate:self];
        _alertURL.tag = 1000;
        
        
        _alertURLHome = [[UIAlertView alloc] initWithTitle:@"URL home" message:@"Entrez l'URL par default" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"Ok", nil];
        [_alertURLHome setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [_alertURLHome setDelegate:self];
        _alertURLHome.tag = 2000;
        
        
        _changedComfirm = [[UIActionSheet alloc] initWithTitle:@"Confirmer le changement" delegate:self cancelButtonTitle:@"Non" destructiveButtonTitle:@"Oui" otherButtonTitles:nil];
        
        [_wv setDelegate:self];
        //Gestion de mémoire
        [_wv release];
        [_toolBar release];
        [_backtbb release];
        [_forwdtbb release];
        [_hometbb release];
        [_changehometbb release];
        [_urltbb release];
        [varSp release];
        [smallSp release];
        
        
    }
    return self;
}


- (IBAction)navBouttumTB:(UIBarButtonItem*)sender {
    
    if (sender == _backtbb) {
        [_wv goBack];
    } else {
        [_wv goForward];
    }
    
    [self setNeedsDisplay];
   
}

- (IBAction)homeTB:(id)sender {
    
    [self chargerPage:homeURL];
    
}

- (IBAction)changeHomeTB:(id)sender {
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [_changedComfirm showFromBarButtonItem:_changehometbb animated:YES];
        
    } else {
       [_changedComfirm showFromToolbar:_toolBar];
    }
    
    
    
}

- (IBAction)urlTB:(id)sender {
    [_alertURL show];
    
}


-(void) drawRect:(CGRect)rect {

    int x,y;
    x=0;
    y=28;
    
    [_toolBar setFrame:CGRectMake(x, y, rect.size.width, 40)];
    
    y+=40;
    [_wv setFrame:CGRectMake(x, y, rect.size.width, rect.size.height-y)];
    
    _spinner.center = self.window.rootViewController.view.center;
    

}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [_spinner stopAnimating];
    [_backtbb setEnabled:[_wv canGoBack]];
    [_forwdtbb setEnabled:[_wv canGoForward]];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [_spinner startAnimating];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    
    
    UIAlertView *ErreurAlert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:[NSString stringWithFormat:@"%@",[error localizedDescription]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    ErreurAlert.tag = 3000;
    [ErreurAlert autorelease];
    [ErreurAlert show];
}

-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
 
    if (alertView.tag == 1000){
        if (buttonIndex == 1) {
            
            [self chargerPage:[[NSMutableString alloc] initWithString:[[alertView textFieldAtIndex:0] text]]];
        }
    } else if (alertView.tag == 2000){
        
        if (buttonIndex == 1) {
            [homeURL setString:[[alertView textFieldAtIndex:0] text]];
            
        }
    } else if (alertView.tag == 3000) {
        
        if (buttonIndex == 0) {
            [_spinner stopAnimating];
            
        }
        
    }
    
    
   
}


-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [_alertURLHome show];
    }
}


-(void) chargerPage:(NSMutableString *) urlString {
    
    [_wv setScalesPageToFit:YES];
     NSURL *url= [NSURL URLWithString:urlString];
     NSURLRequest *r= [NSURLRequest requestWithURL:url];
    [_wv loadRequest:r];
    [self setNeedsDisplay];
    
}



@end


