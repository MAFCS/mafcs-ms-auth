import { Catch, ExceptionFilter, HttpStatus, Logger } from '@nestjs/common';
import { RpcException } from '@nestjs/microservices';
import { Observable, throwError } from 'rxjs';

@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
  private readonly logger = new Logger(AllExceptionsFilter.name);

  catch(exception: any): Observable<any> {
    this.logger.error(exception);

    if (exception instanceof RpcException) {
      return throwError(() => exception);
    }

    let statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
    let message = 'Internal server error';

    if (exception?.response?.statusCode && exception?.response?.message) {
      statusCode = exception.response.statusCode;
      message = exception.response.message;
    } else if (exception instanceof Error) {
      message = exception.message || message;
    }

    const error = {
      statusCode: statusCode,
      message,
    };

    return throwError(() => new RpcException(error));
  }
}
