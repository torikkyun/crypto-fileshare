-- CreateEnum
CREATE TYPE "public"."FilePermissionType" AS ENUM ('READ', 'WRITE', 'DOWNLOAD');

-- CreateEnum
CREATE TYPE "public"."FilePermissionStatus" AS ENUM ('ACTIVE', 'EXPIRED', 'REVOKED');

-- CreateTable
CREATE TABLE "public"."users" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "wallet_address" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."files" (
    "id" TEXT NOT NULL,
    "owner_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "size" BIGINT,
    "type" TEXT,
    "ipfs_hash" TEXT NOT NULL,
    "tx_hash" TEXT NOT NULL,
    "encryption_key" TEXT NOT NULL,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "files_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."file_permissions" (
    "id" TEXT NOT NULL,
    "file_id" TEXT NOT NULL,
    "shared_with" TEXT NOT NULL,
    "type" "public"."FilePermissionType" NOT NULL,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "status" "public"."FilePermissionStatus" NOT NULL DEFAULT 'ACTIVE',
    "shared_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revoked_at" TIMESTAMP(3),

    CONSTRAINT "file_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."access_logs" (
    "id" TEXT NOT NULL,
    "file_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tx_hash" TEXT NOT NULL,

    CONSTRAINT "access_logs_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "public"."users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_wallet_address_key" ON "public"."users"("wallet_address");

-- CreateIndex
CREATE UNIQUE INDEX "files_ipfs_hash_key" ON "public"."files"("ipfs_hash");

-- CreateIndex
CREATE UNIQUE INDEX "files_tx_hash_key" ON "public"."files"("tx_hash");

-- AddForeignKey
ALTER TABLE "public"."files" ADD CONSTRAINT "files_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "public"."users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."file_permissions" ADD CONSTRAINT "file_permissions_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "public"."files"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."file_permissions" ADD CONSTRAINT "file_permissions_shared_with_fkey" FOREIGN KEY ("shared_with") REFERENCES "public"."users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."access_logs" ADD CONSTRAINT "access_logs_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "public"."files"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."access_logs" ADD CONSTRAINT "access_logs_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
