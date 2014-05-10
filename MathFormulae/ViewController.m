//
//  ViewController.m
//  MathFormulae
//
//  Created by Ganesh Somani on 5/10/14.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

UIWebView *myWebView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Example 0
    NSString *xContent = @"Consider the curve y = 1 = x,from x = 1 to x = 1. Rotate this curve around the x-axis to create a funnel-like surface of revolution. The volume of this funnel is $$V\\quad=\\quad\\int_{1}^{\\infty }{\\frac{\\pi}{{x}^{2}}dx\\quad=\\quad\\pi }$$ which is finite. The surface area, however, is $$A\\quad=\\quad\\int_{1}^{\\infty}{\\frac{2\\pi\\quad\\sqrt{(1+{y'}^{2}) } }{x} dx\\quad>\\quad\\int_{1}^{\\infty }{\\frac{2\\pi}{x}dx}}$$ which is infinite. So it seems like you can fill up the funnel with paint, but can't paint it. What is the solution to this";
    
    /*
     //Example 1
    //content copied from http://www.mathjax.org/demos/tex-samples/
    NSString *xContent = @"<p>\\["
    "\\left( \\sum_{k=1}^n a_k b_k \\right)^{\\!\\!2} \\leq"
    "\\left( \\sum_{k=1}^n a_k^2 \\right) \\left( \\sum_{k=1}^n b_k^2 \\right)"
    "\\]</p>"
    "<BR/>"
    "<p>\\["
    "\\frac{1}{(\\sqrt{\\phi \\sqrt{5}}-\\phi) e^{\\frac25 \\pi}} ="
    "1+\\frac{e^{-2\\pi}} {1+\\frac{e^{-4\\pi}} {1+\\frac{e^{-6\\pi}}"
    "|{1+\\frac{e^{-8\\pi}} {1+\\ldots} } } }"
    "\\]</p>";
    */
    
    
     //2nd example from http://www.mathjax.org/demos/mathml-samples/
/*     NSString *xContent =@"When <math><mi>a</mi><mo>&#x2260;</mo><mn>0</mn></math>,"
     "there are two solutions to <math>"
     "<mi>a</mi><msup><mi>x</mi><mn>2</mn></msup>"
     "<mo>+</mo> <mi>b</mi><mi>x</mi>"
     "<mo>+</mo> <mi>c</mi> <mo>=</mo> <mn>0</mn>"
     "</math> and they are"
     "<math mode='display'>"
     "<mi>x</mi> <mo>=</mo>"
     "<mrow>"
     "<mfrac>"
     "<mrow>"
     "<mo>&#x2212;</mo>"
     "<mi>b</mi>"
     "<mo>&#x00B1;</mo>"
     "<msqrt>"
     "<msup><mi>b</mi><mn>2</mn></msup>"
     "<mo>&#x2212;</mo>"
     "<mn>4</mn><mi>a</mi><mi>c</mi>"
     "</msqrt>"
     "</mrow>"
     "<mrow> <mn>2</mn><mi>a</mi> </mrow>"
     "</mfrac>"
     "</mrow>"
     "<mtext>.</mtext>"
     "</math>";
    */
    
    //temp file filename
    NSString *tmpFileName = @"test1.html";
    
    //temp dir
    NSString *tempDir = NSTemporaryDirectory();
    NSLog(@"tempDirectory: %@",tempDir);
    
    //create NSURL
    NSString *path4 = [tempDir stringByAppendingPathComponent:tmpFileName];
    NSURL* url = [NSURL fileURLWithPath:path4];
    NSLog(@"Path=%@, url=%@",path4,url);
    
    //setup HTML file contents
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MathJax" ofType:@"js" inDirectory:@"mathjax-lib"];
    NSLog(@"filePath = %@",filePath);
    
    //write to temp file "tempDir/tmpFileName", set MathJax JavaScript to use "filePath" as directory, add "xContent" as content of HTML file
    [self writeStringToFile:tempDir fileName:tmpFileName pathName:filePath content:xContent];
    
    //create UIWebView
    CGRect webRect = CGRectMake(10,10,300,400);
    myWebView =[[UIWebView alloc] initWithFrame:webRect];
    myWebView.scalesPageToFit = YES;
    myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    //[Update 21/03/2013] This step no longer required
    // myWebView.delegate = self;
    
    
    NSURLRequest* req = [[NSURLRequest alloc] initWithURL:url];
    
    //original request to show MathJax stuffs
    [myWebView loadRequest:req];
    
    [self.view addSubview:myWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)writeStringToFile:(NSString *)dir fileName:(NSString *)strFileName pathName:(NSString *)strPath content:(NSString *)strContent{
    
    NSLog(@" inside writeStringToFile, strPath=%@", strPath);
    
    NSString *path = [dir stringByAppendingPathComponent:strFileName];
    
    NSString *foo0 = @"<html><head><meta name='viewport' content='initial-scale=1.0' />"
    "<script type='text/javascript' src='";
    
    NSString *foo1 = @"?config=TeX-AMS-MML_HTMLorMML-full'></script>"
    "</head>"
    "<body>";
    NSString *foo2 = @"</body></html>";
    NSString *fooFinal = [NSString stringWithFormat:@"%@%@%@%@%@",foo0,strPath,foo1,strContent,foo2];
    
    
    NSLog(@"Final content is %@",fooFinal);
    
    [fooFinal writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}

@end
