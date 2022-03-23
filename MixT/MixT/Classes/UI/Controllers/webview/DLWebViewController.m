//
//  DLWebViewController.m
//  MixT
//
//  Created by zhoubingfeng on 23.7.21.
//  Copyright © 2021 周冰烽. All rights reserved.
//

#import "DLWebViewController.h"
#import <WebKit/WebKit.h>
@interface DLWebViewController ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, weak) WKWebView *webView;

@property(nonatomic, copy) void(^imageChose)(NSString *imageBase64);

@end

@implementation DLWebViewController

#pragma mark - life circle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWebView];
}

#pragma mark - private method

/// webview初始化
- (void)initWebView {
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.userContentController = [WKUserContentController new];
    [config.userContentController addScriptMessageHandler:self name:@"receiveJSMessage"];
    [config.userContentController addScriptMessageHandler:self name:@"uploadImage"];
    // 加载本地js
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView loadRequest:request];
//    NSString *reportUrlString = @"http://10.195.240.162:8081/ctm05ich5/th5/home";
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:reportUrlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
//    [webView loadRequest:request];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make edges];
    }];
    self.webView = webView;
}

#pragma WKUIDelegate

/// JS调用alert弹窗的时候需要原生这边实现runJavaScriptAlertPanelWithMessage方法, 原生这边可以自定义alert弹窗样式, 标题, 按钮等
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    if ([message.name isEqualToString:@"receiveJSMessage"]) {
        // JS调用了OC的receiveJSMessage方法执行逻辑
        NSLog(@"%@, %@", message.name, message.body);
        // OC调用JS
        NSDictionary *dict = @{@"1" : @"1111", @"2" : @"2222", @"3" : @"3333"};
        // 转成JSON字符串的时候, 记得不要使用NSJSONWritingPrettyPrinted, 这个关键字会额外换行及添加空格, 导致JS无法识别JSON, 使用kNilOptions即可
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
        NSString *dictStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *jsFunc = [NSString stringWithFormat:@"receiveOCMessage('%@')", dictStr];
        [self.webView evaluateJavaScript:jsFunc completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            if (error) {
                NSLog(@"receiveOCMessage error : %@", error);
            }
        }];
    } else if ([message.name isEqualToString:@"uploadImage"]) {
        [self uploadImage];
        __weak typeof(self) weakSelf = self;
        self.imageChose = ^(NSString *imageBase64) {
            NSString *jsFunc = [NSString stringWithFormat:@"receiveBase64('%@')", imageBase64];
            [weakSelf.webView evaluateJavaScript:jsFunc completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"receiveBase64 error: %@", error);
                }
            }];
        };
    }
}

- (void)uploadImage {
    //创建UIImagePickerController对象，并设置代理和可编辑
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.editing = YES;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    //创建sheet提示框，提示选择相机还是相册
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //相机选项
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //选择相机时，设置UIImagePickerController对象相关属性
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        //跳转到UIImagePickerController控制器弹出相机
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    //相册选项
    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //选择相册时，设置UIImagePickerController对象相关属性
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:@"public.movie",@"public.image", nil];
        //跳转到UIImagePickerController控制器弹出相册
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    //取消按钮
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    //添加各个按钮事件
    [alert addAction:camera];
    [alert addAction:photo];
    [alert addAction:cancel];
    
    //弹出sheet提示框
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.movie"]) {
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"%@", url);
        NSString *urlStr = url.absoluteString;
        self.imageChose(urlStr);
    } else {
        UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
        NSData *data = UIImageJPEGRepresentation(image, 1.0f);
        NSString *encodeStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        self.imageChose(encodeStr);
    }
}


@end
