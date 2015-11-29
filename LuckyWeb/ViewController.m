//
//  ViewController.m
//
#import "ViewController.h"
#import "ProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.webView.scalesPageToFit = YES;
        //self.webView.frame = self.view.bounds;
        //self.webView.frame = self.view.frame;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //_webView.delegate = (id)self;
    
    // left and right swipe
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(swipeRightAction:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    //swipeRight.delegate = self;
    [self.webView addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    //swipeLeft.delegate = self;
    [self.webView addGestureRecognizer:swipeLeft];

    
    // down pull refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.webView.scrollView addSubview:refreshControl];
    
    
    // load url
    NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://lucky521.github.io/"]];
    [self.webView loadRequest:request];

}


-(void)handleRefresh:(UIRefreshControl *)refresh {
    // Reload my data
    NSString *fullURL = self.webView.request.URL.absoluteString;
    if (fullURL == nil || fullURL.length == 0)
        fullURL = @"http://lucky521.github.io/";
    NSLog(@"handle refresh for current page. %@",  fullURL);
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
    [refresh endRefreshing];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)swipeRightAction:(id)ignored
{
    NSLog(@"Swipe Left.");
    //add Function
    if (_webView.canGoBack) {
        [_webView goBack];
        NSLog(@"Swipe go back");
    }
}

- (void)swipeLeftAction:(id)ignored
{
    NSLog(@"Swipe Right.");
    //add Function
    if (_webView.canGoForward) {
        [_webView goForward];
        NSLog(@"Swipe go Foward");
    }

}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/*
- (IBAction)loadurlAction:(id)sender
{
    NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://lucky521.github.com"]];
    [self.webView loadRequest:request];
}
*/


#pragma - mark UIWebView Delegate Methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"Loading URL :%@", request.URL.absoluteString);
    
    // i can make a url filter here
    //return FALSE; //to stop loading
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [ProgressHUD show:@"加载，加载一会..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [ProgressHUD showSuccess:@"加载完毕, 么么哒!"];
    //[ProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Failed to load with error :%@",[error debugDescription]);
    [ProgressHUD showError:@"出错了，快去告诉Lucky."];
    //[ProgressHUD dismiss];
    
}

@end
