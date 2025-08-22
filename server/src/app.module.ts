import { Module } from '@nestjs/common';
import { UsersModule } from './models/users/users.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: [
        process.env.NODE_ENV === 'production'
          ? '.env'
          : '.env.development.local',
      ],
      expandVariables: true,
    }),
    UsersModule,
  ],
})
export class AppModule {}
