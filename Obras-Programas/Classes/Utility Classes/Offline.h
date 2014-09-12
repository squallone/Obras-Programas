//
//  Offline.h
//  cintermex
//
//  Created by Juan Pablo Gonzalez Hermosillo Cires on 02/09/12.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Offline : NSObject

@property BOOL hideStartActivityIndicator;
@property BOOL hideEndActivityIndicator;

- (NSString *)applicationDocumentsDirectory;
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

-(void)CloseDB;
-(void)OpenDB;
-(BOOL)AutoExecute:(NSString *)strSQL;
-(BOOL)ExecuteSQL:(NSString *)strSQL;
-(NSArray *)Consulta:(NSString *)strSQL;
-(NSArray *)AutoConsulta:(NSString *)strSQL;

@end
