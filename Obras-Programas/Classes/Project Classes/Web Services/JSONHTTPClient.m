//
//  JSONHTTPClient.m
//  Versailles
//
//  Created by Abdiel on 7/11/14.
//  Copyright (c) 2014 Smartthinking. All rights reserved.
//

#import "JSONHTTPClient.h"
#import "TSMessage.h"
#import "Estado.h"

//Parametro que usa el Servlet para saber si la peticion proviene del movil


@implementation JSONHTTPClient

+ (JSONHTTPClient *)sharedJSONAPIClient
{
    static JSONHTTPClient *_sharedJSONAPIClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedJSONAPIClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAppURL]];
    });
    
    return _sharedJSONAPIClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

//Realiza la petición POST al servidor para traer la información del usuario

-(void)performPOSTRequestWithParameters:(NSDictionary *)parameters toServlet:(NSString *)servletName{
    
    //Ejectuta la petición al servidor
    
    [self POST:servletName parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *JSONResponse = responseObject;
        
        if ([servletName isEqualToString:kServletEstados]) {
            
            NSArray *statesData = [self deserializeStatesFromJSON:JSONResponse];
            
            if ([self.delegate respondsToSelector:@selector(JSONHTTPClientDelegate:didResponseToStates:)]) {
                
                [self.delegate JSONHTTPClientDelegate:self didResponseToStates:statesData];
            }
            
        }else if ([servletName isEqualToString:kServletInauguradores]){
            if ([self.delegate respondsToSelector:@selector(JSONHTTPClientDelegate:didResponseToInaugurators:)]) {
                
                [self.delegate JSONHTTPClientDelegate:self didResponseToInaugurators:JSONResponse];
            }
        }
        
        //El servidor notifica si la respuesta es valida o no

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        NSString *errorStr = [error localizedDescription];
        
        if ([self.delegate respondsToSelector:@selector(JSONHTTPClientDelegate:didFailResponseWithError:)]) {
            [self.delegate JSONHTTPClientDelegate:self didFailResponseWithError:error];
        }
        
        [TSMessage showNotificationWithTitle:@"Error"
                                    subtitle:[NSString stringWithFormat:@"%@\n%@", @"Mensaje", errorStr]
                                        type:TSMessageNotificationTypeWarning];        
        
    }];
}

- (NSArray *)deserializeStatesFromJSON:(NSArray *)statesJSON
{
    NSError *error;
    NSArray *appInfos = [MTLJSONAdapter modelsOfClass:[Estado class] fromJSONArray:statesJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert app infos JSON to ChoosyAppInfo models: %@", error);
        return nil;
    }
    
    return appInfos;
}

- (NSArray *)deserializeInauguratorsFromJSON:(NSArray *)inauguratorsJSON
{
    NSError *error;
    NSArray *appInfos = [MTLJSONAdapter modelsOfClass:[Estado class] fromJSONArray:inauguratorsJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert inauguradores JSON to Inauguradores models: %@", error);
        return nil;
    }
    
    return appInfos;
}

@end
