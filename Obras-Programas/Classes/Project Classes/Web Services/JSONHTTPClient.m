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
#import "Impacto.h"
#import "Inaugurador.h"
#import "Clasificacion.h"
#import "Dependencia.h"
#import "Inversion.h"
#import "TipoObraPrograma.h"
#import "Obra.h"
#import "ListaReporteDependencia.h"
#import "ListaReporteEstado.h"
#import "ListaReporteGeneral.h"
#import "Programa.h"

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

-(void)performPOSTRequestWithParameters:(NSDictionary *)parameters toServlet:(NSString *)servletName withOptions:(NSString *)option{
    
    self.servletName = servletName;
    //Ejectuta la petición al servidor
    
    [self POST:servletName parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *JSONResponse = responseObject;
        //Estados
        
        
        if ([servletName isEqualToString:kServletEstados]) {
            
            NSArray *statesData = [self deserializeStatesFromJSON:JSONResponse];
            
            if ([self.delegate respondsToSelector:@selector(JSONHTTPClientDelegate:didResponseToStates:)]) {
                
                [self.delegate JSONHTTPClientDelegate:self didResponseToStates:statesData];
            }
        //Inauguradores
        }else if ([servletName isEqualToString:kServletInauguradores]){
            
            NSArray *inaugurators = [self deserializeInauguratorsFromJSON:JSONResponse];
            
            if ([self.delegate respondsToSelector:@selector(JSONHTTPClientDelegate:didResponseToInaugurators:)]) {
                
                [self.delegate JSONHTTPClientDelegate:self didResponseToInaugurators:inaugurators];
            }
        //Impactos
        }else if ([servletName isEqualToString:kServletImpactos]){
            
            NSArray *impacts = [self deserializeImpactsFromJSON:JSONResponse];

            if ([self.delegate respondsToSelector:@selector(JSONHTTPClientDelegate:didResponseToImpacts:)]) {
                
                [self.delegate JSONHTTPClientDelegate:self didResponseToImpacts:impacts];
            }
            
        //Clasificación
        }else if ([servletName isEqualToString:kServletConsultarClasificacion]){
            
            NSArray *clasifications = [self deserializeClasificationsFromJSON:JSONResponse];
            
            if ([self.delegate respondsToSelector:@selector(JSONHTTPClientDelegate:didResponseToClasifications:)]) {
                
                [self.delegate JSONHTTPClientDelegate:self didResponseToClasifications:clasifications];
            }
        // Dependencias
        }else if ([servletName isEqualToString:kServletConsultarDependencias]){
            
            NSArray *dependencies = [self deserializeDependenciesFromJSON:JSONResponse];
            
            if ([self.delegate respondsToSelector:@selector(JSONHTTPClientDelegate:didResponseToDependencies:)]) {
                
                [self.delegate JSONHTTPClientDelegate:self didResponseToDependencies:dependencies];
            }
        //Inversiones
            
        }else if ([servletName isEqualToString:kServletConsultarInversiones]){
            
            NSArray *invesments = [self deserializeInvesmentsFromJSON:JSONResponse];
            
            if ([self.delegate respondsToSelector:@selector(JSONHTTPClientDelegate:didResponseToTypesOfInvesments:)]) {
                
                [self.delegate JSONHTTPClientDelegate:self didResponseToTypesOfInvesments:invesments];
            }
        //Tipo Obras Programas
        }else if ([servletName isEqualToString:kServletConsultarTipoObraPrograma]){
            
            NSArray *worksProgramas = [self deserializeWorksProgramsFromJSON:JSONResponse];
            
            if ([self.delegate respondsToSelector:@selector(JSONHTTPClientDelegate:didResponseToTypesOfWorksAndPrograms:)]) {
                
                [self.delegate JSONHTTPClientDelegate:self didResponseToTypesOfWorksAndPrograms:worksProgramas];
            }
            
        //Buscar y Reportes
        }else if ([servletName isEqualToString:kServletBuscar]){
            
            NSDictionary *JSONResponseDic = responseObject;
            
            if ([option isEqualToString:@"obras"]) {
                
                //Resultado de las obras
                NSArray *JSONListaObras = JSONResponseDic[kKeyListaObras];
                
                if (!JSONListaObras) {
                    JSONListaObras = JSONResponseDic[kKeyListaProgramas];
                    JSONListaObras = [self deserializeProgramsFromJSON:JSONListaObras];

                }else{
                    JSONListaObras = [self deserializeWorksFromJSON:JSONListaObras];
                }
            
                //Resultado de listaReporteGeneral
                
                NSArray *JSONListaReporteGeneral= JSONResponseDic[kKeyListaReporteGeneral];
                
                JSONListaReporteGeneral = [self deserializeListGeneralReporteFromJSON:JSONListaReporteGeneral];
                
                //Resultado listaReporteEstado
                
                NSArray *JSONListaReporteEstados = JSONResponseDic[kKeyListaReporteEstado];
                JSONListaReporteEstados = [self deserializeListReporteStateFromJSON:JSONListaReporteEstados];

                //Resultado listaReporteDependencia
                
                NSArray *JSONListaReporteDepedencia = JSONResponseDic[kKeyListaReporteDependencia];
                JSONListaReporteDepedencia = [self deserializeListReportDependenciesromJSON:JSONListaReporteDepedencia];
                
                if ([self.delegate respondsToSelector:@selector(JSONHTTPClientDelegate:didResponseSearchWorks:)]) {
                    
                    NSDictionary *response = @{kKeyListaObras                   : JSONListaObras,
                                                  kKeyListaReporteDependencia   : JSONListaReporteDepedencia,
                                                  kKeyListaReporteEstado        : JSONListaReporteEstados,
                                                  kKeyListaReporteGeneral       : JSONListaReporteGeneral};
                    
                    [self.delegate JSONHTTPClientDelegate:self didResponseSearchWorks:response];
                }
            }
        }

        //El servidor notifica si la respuesta es valida o no
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        NSString *errorStr = [error localizedDescription];
        
        if ([self.delegate respondsToSelector:@selector(JSONHTTPClientDelegate:didFailResponseWithError:)]) {
            [self.delegate JSONHTTPClientDelegate:self didFailResponseWithError:error];
        }
        
        [TSMessage showNotificationWithTitle:@"Lo sentimos, se perdido la conexión con el servidor"
                                    subtitle:[NSString stringWithFormat:@"%@\nMensaje: %@", @"Por favor intentalo de nuevo o contacta al administrador", errorStr]
                                        type:TSMessageNotificationTypeWarning];
        
    }];
}

- (NSArray *)deserializeWorksFromJSON:(NSArray *)worksJSON
{
    NSError *error;
    NSArray *works = [MTLJSONAdapter modelsOfClass:[Obra class] fromJSONArray:worksJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert Obras JSON to Obra models: %@", error);
        return nil;
    }
    
    return works;
}

- (NSArray *)deserializeProgramsFromJSON:(NSArray *)worksJSON
{
    NSError *error;
    NSArray *works = [MTLJSONAdapter modelsOfClass:[Programa class] fromJSONArray:worksJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert Obras JSON to Obra models: %@", error);
        return nil;
    }
    
    return works;
}



- (NSArray *)deserializeStatesFromJSON:(NSArray *)statesJSON
{
    NSError *error;
    NSArray *states = [MTLJSONAdapter modelsOfClass:[Estado class] fromJSONArray:statesJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert app infos JSON to Estado models: %@", error);
        return nil;
    }
    
    return states;
}

- (NSArray *)deserializeInauguratorsFromJSON:(NSArray *)inauguratorsJSON
{
    NSError *error;
    NSArray *inaugurators = [MTLJSONAdapter modelsOfClass:[Inaugurador class] fromJSONArray:inauguratorsJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert inauguradores JSON to Inauguradores models: %@", error);
        return nil;
    }
    
    return inaugurators;
}

- (NSArray *)deserializeImpactsFromJSON:(NSArray *)impactsJSON
{
    NSError *error;
    NSArray *impacts = [MTLJSONAdapter modelsOfClass:[Impacto class] fromJSONArray:impactsJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert impactos JSON to Impact models: %@", error);
        return nil;
    }
    return impacts;
}

- (NSArray *)deserializeClasificationsFromJSON:(NSArray *)impactsJSON
{
    NSError *error;
    NSArray *clasifications = [MTLJSONAdapter modelsOfClass:[Clasificacion class] fromJSONArray:impactsJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert clasificaciones JSON to Clasificacion models: %@", error);
        return nil;
    }
    
    return clasifications;
}

- (NSArray *)deserializeDependenciesFromJSON:(NSArray *)impactsJSON
{
    NSError *error;
    NSArray *dependencies = [MTLJSONAdapter modelsOfClass:[Dependencia class] fromJSONArray:impactsJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert dependencias JSON to Clasificacion models: %@", error);
        return nil;
    }
    
    return dependencies;
}

- (NSArray *)deserializeInvesmentsFromJSON:(NSArray *)invesmentsJSON
{
    NSError *error;
    NSArray *dependencies = [MTLJSONAdapter modelsOfClass:[Inversion class] fromJSONArray:invesmentsJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert Inversiones JSON to Inversión models: %@", error);
        return nil;
    }
    
    return dependencies;
}

- (NSArray *)deserializeWorksProgramsFromJSON:(NSArray *)typeWorkProgramJSON
{
    NSError *error;
    NSArray *programasObras = [MTLJSONAdapter modelsOfClass:[TipoObraPrograma class] fromJSONArray:typeWorkProgramJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert Programas Obras JSON to Programas Obras models: %@", error);
        return nil;
    }
    
    return programasObras;
}


- (NSArray *)deserializeListReportDependenciesromJSON:(NSArray *)typeWorkProgramJSON
{
    NSError *error;
    NSArray *programasObras = [MTLJSONAdapter modelsOfClass:[ListaReporteDependencia class] fromJSONArray:typeWorkProgramJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert Programas Obras JSON to Programas Obras models: %@", error);
        return nil;
    }
    
    return programasObras;
}


- (NSArray *)deserializeListReporteStateFromJSON:(NSArray *)typeWorkProgramJSON
{
    NSError *error;
    NSArray *programasObras = [MTLJSONAdapter modelsOfClass:[ListaReporteEstado class] fromJSONArray:typeWorkProgramJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert Programas Obras JSON to Programas Obras models: %@", error);
        return nil;
    }
    
    return programasObras;
}

- (NSArray *)deserializeListGeneralReporteFromJSON:(NSArray *)typeWorkProgramJSON
{
    NSError *error;
    NSArray *programasObras = [MTLJSONAdapter modelsOfClass:[ListaReporteGeneral class] fromJSONArray:typeWorkProgramJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert Programas Obras JSON to Programas Obras models: %@", error);
        return nil;
    }
    
    return programasObras;
}



@end
