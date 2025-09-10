import { Injectable, Logger, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {
  private readonly logger = new Logger(PrismaService.name);

  async onModuleInit() {
    this.logger.log('[INFO] Conectando a la base de datos');
    await this.$connect();
  }

  async onModuleDestroy() {
    this.logger.log('[INFO] Desconectando a la base de datos');
    await this.$disconnect();
  }
}
