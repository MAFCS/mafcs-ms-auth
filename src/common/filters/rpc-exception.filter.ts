import { Catch, ArgumentsHost, ExceptionFilter, Logger, HttpStatus } from '@nestjs/common';
import { RpcException } from '@nestjs/microservices';

@Catch(RpcException)
export class RpcCustomExceptionFilter implements ExceptionFilter {
  private readonly logger = new Logger(RpcCustomExceptionFilter.name);

  catch(exception: RpcException, host: ArgumentsHost) {
    const rpcError = exception.getError();
    this.logger.error(rpcError); 

    if (host.getType() === 'http') {
      const ctx = host.switchToHttp();

      if (typeof rpcError === 'object' && 'status' in rpcError && 'message' in rpcError) { 
        const status = isNaN(+rpcError.status) ? HttpStatus.INTERNAL_SERVER_ERROR : +rpcError.status;
      }

    }

    if (typeof rpcError === 'object' && 'statusCode' in rpcError && 'message' in rpcError) {
      return rpcError;
    }

    return {
      statusCode: HttpStatus.INTERNAL_SERVER_ERROR,
      message: rpcError,
    };
  }
}
