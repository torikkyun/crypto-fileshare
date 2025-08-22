import { Module } from '@nestjs/common';
import { UsersModule } from './models/users/users.module';
import { ConfigModule } from '@nestjs/config';
import { FilesModule } from './models/files/files.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: [
        process.env.NODE_ENV === 'production'
          ? '.env.production.local'
          : '.env.development.local',
      ],
      expandVariables: true,
    }),
    UsersModule,
    FilesModule,
  ],
})
export class AppModule {}
