import { MicroserviceOptions, Transport } from '@nestjs/microservices';
import { Logger, ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import validationOptions from './common/utils/validation-options';
import { AllExceptionsFilter, RpcCustomExceptionFilter } from './common/filters';
import { envs } from './config/schema/app.schema';
import { AppModule } from './app.module';

async function bootstrap() {
  const logger = new Logger('Request Microservice');

  const app = await NestFactory.createMicroservice<MicroserviceOptions>(AppModule, {
    transport: Transport.NATS,
    options: {
      servers: envs.NATS_SERVER,
    },  
  });

  app.useGlobalPipes(new ValidationPipe(validationOptions));
  app.useGlobalFilters(new AllExceptionsFilter(), new RpcCustomExceptionFilter());

  await app.listen();

  logger.log('Application is running on: ' + envs.PORT);
}
bootstrap();
