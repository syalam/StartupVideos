#import "SVHTTPClient.h"

#import "AFJSONRequestOperation.h"

static NSString * const kBMHTTPClientBaseURLString = @"http://warm-mountain-5009.herokuapp.com/apps/";

@implementation SVHTTPClient

+ (SVHTTPClient *)sharedClient {
    static SVHTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SVHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kBMHTTPClientBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setParameterEncoding:AFJSONParameterEncoding];
    
    return self;
}

- (void)postPath:(NSString *)path 
      parameters:(NSDictionary *)parameters 
            data:(NSData*)data
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
{
    NSURLRequest *request = [self requestWithMethod:@"POST" path:path     parameters:parameters data:data];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self enqueueHTTPRequestOperation:operation];
}

- (void)putPath:(NSString *)path 
     parameters:(NSDictionary *)parameters 
           data:(NSData*)data
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
{
    NSURLRequest *request = [self requestWithMethod:@"PUT" path:path parameters:parameters data:data];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self enqueueHTTPRequestOperation:operation];
}

-(NSMutableURLRequest*)requestWithMethod:(NSString *)method 
                                    path:(NSString *)path 
                              parameters:(NSDictionary *)parameters 
                                    data:(NSData*)data;
{
    NSMutableURLRequest* request = [super requestWithMethod:method 
                                                       path:path 
                                                 parameters:parameters];
    
    [request setHTTPBody:data];
    
    return request;
}


@end
