-- CreateEnum
CREATE TYPE "public"."IamActionsEnum" AS ENUM ('create', 'read', 'update', 'delete', 'manage');

-- CreateTable
CREATE TABLE "public"."app_settings" (
    "id" UUID NOT NULL,
    "key" VARCHAR(45) NOT NULL,
    "value" VARCHAR(255) NOT NULL,
    "value_type" VARCHAR(45) NOT NULL,
    "description" VARCHAR(255),
    "start_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "app_settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."action" (
    "id" UUID NOT NULL,
    "name" "public"."IamActionsEnum" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "action_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."resource" (
    "id" UUID NOT NULL,
    "name" VARCHAR(45) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "resource_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."policy" (
    "id" UUID NOT NULL,
    "name" VARCHAR(45) NOT NULL,
    "action_id" UUID NOT NULL,
    "resource_id" UUID NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "policy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."role" (
    "id" UUID NOT NULL,
    "name" VARCHAR(45) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."role_policy" (
    "id" UUID NOT NULL,
    "role_id" UUID NOT NULL,
    "policy_id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "role_policy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."user_role" (
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "role_id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."user" (
    "id" UUID NOT NULL,
    "username" VARCHAR(120) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "temp_password" VARCHAR(255),
    "lock_until" TIMESTAMP(3),
    "failed_attempts" INTEGER NOT NULL DEFAULT 0,
    "is_first_login" BOOLEAN NOT NULL DEFAULT true,
    "deleted_reason" VARCHAR(500),
    "fcm_token" VARCHAR(255),
    "deleted_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."user_session" (
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "jwt_token" TEXT NOT NULL,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "user_session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."notification_type" (
    "id" UUID NOT NULL,
    "name" VARCHAR(45) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "notification_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."user_notification_type" (
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "notification_type_id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "user_notification_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."country" (
    "id" UUID NOT NULL,
    "name" VARCHAR(60) NOT NULL,
    "short_name" VARCHAR(4) NOT NULL,
    "phone_code" INTEGER NOT NULL,
    "currency" VARCHAR(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "country_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."city" (
    "id" UUID NOT NULL,
    "name" VARCHAR(60) NOT NULL,
    "country_id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "city_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."document_type" (
    "id" UUID NOT NULL,
    "name" VARCHAR(45) NOT NULL,
    "short_name" VARCHAR(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "document_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."person_type" (
    "id" UUID NOT NULL,
    "name" VARCHAR(45) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "person_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."person" (
    "id" UUID NOT NULL,
    "first_name" VARCHAR(50) NOT NULL,
    "last_name" VARCHAR(50) NOT NULL,
    "document_number" VARCHAR(11) NOT NULL,
    "email" VARCHAR(40),
    "phone" VARCHAR(15) NOT NULL,
    "image_url" VARCHAR(255),
    "person_type_id" UUID NOT NULL,
    "country_id" UUID NOT NULL,
    "city_id" UUID NOT NULL,
    "document_type_id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "person_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."user_person" (
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "person_id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "user_person_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "app_settings_key_key" ON "public"."app_settings"("key");

-- CreateIndex
CREATE INDEX "app_settings_key_index" ON "public"."app_settings"("key");

-- CreateIndex
CREATE UNIQUE INDEX "unique_app_settings_key_start_at" ON "public"."app_settings"("key", "start_at");

-- CreateIndex
CREATE UNIQUE INDEX "action_name_key" ON "public"."action"("name");

-- CreateIndex
CREATE INDEX "action_name_index" ON "public"."action"("name");

-- CreateIndex
CREATE UNIQUE INDEX "resource_name_key" ON "public"."resource"("name");

-- CreateIndex
CREATE INDEX "resource_name_index" ON "public"."resource"("name");

-- CreateIndex
CREATE UNIQUE INDEX "policy_name_key" ON "public"."policy"("name");

-- CreateIndex
CREATE INDEX "policy_name_index" ON "public"."policy"("name");

-- CreateIndex
CREATE INDEX "policy_action_id_resource_id_index" ON "public"."policy"("action_id", "resource_id");

-- CreateIndex
CREATE UNIQUE INDEX "unique_resource_action" ON "public"."policy"("resource_id", "action_id");

-- CreateIndex
CREATE UNIQUE INDEX "role_name_key" ON "public"."role"("name");

-- CreateIndex
CREATE INDEX "role_name_index" ON "public"."role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "unique_role_policy" ON "public"."role_policy"("role_id", "policy_id");

-- CreateIndex
CREATE UNIQUE INDEX "unique_user_role" ON "public"."user_role"("user_id", "role_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_username_key" ON "public"."user"("username");

-- CreateIndex
CREATE INDEX "user_username_index" ON "public"."user"("username");

-- CreateIndex
CREATE INDEX "user_id_index" ON "public"."user"("id");

-- CreateIndex
CREATE INDEX "user_fcm_token_index" ON "public"."user"("fcm_token");

-- CreateIndex
CREATE UNIQUE INDEX "user_session_jwt_token_key" ON "public"."user_session"("jwt_token");

-- CreateIndex
CREATE INDEX "user_session_user_id_index" ON "public"."user_session"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_session_user_id_jwt_token_unique" ON "public"."user_session"("user_id", "jwt_token");

-- CreateIndex
CREATE UNIQUE INDEX "notification_type_name_key" ON "public"."notification_type"("name");

-- CreateIndex
CREATE INDEX "notification_type_name_index" ON "public"."notification_type"("name");

-- CreateIndex
CREATE INDEX "user_notification_type_user_id_index" ON "public"."user_notification_type"("user_id");

-- CreateIndex
CREATE INDEX "user_notification_type_notification_type_id_index" ON "public"."user_notification_type"("notification_type_id");

-- CreateIndex
CREATE UNIQUE INDEX "unique_user_notification_type" ON "public"."user_notification_type"("user_id", "notification_type_id");

-- CreateIndex
CREATE UNIQUE INDEX "country_short_name_key" ON "public"."country"("short_name");

-- CreateIndex
CREATE INDEX "country_short_name_index" ON "public"."country"("short_name");

-- CreateIndex
CREATE INDEX "country_name_index" ON "public"."country"("name");

-- CreateIndex
CREATE INDEX "city_name_index" ON "public"."city"("name");

-- CreateIndex
CREATE INDEX "city_country_id_index" ON "public"."city"("country_id");

-- CreateIndex
CREATE UNIQUE INDEX "document_type_name_key" ON "public"."document_type"("name");

-- CreateIndex
CREATE UNIQUE INDEX "document_type_short_name_key" ON "public"."document_type"("short_name");

-- CreateIndex
CREATE INDEX "document_type_name_index" ON "public"."document_type"("name");

-- CreateIndex
CREATE UNIQUE INDEX "person_type_name_key" ON "public"."person_type"("name");

-- CreateIndex
CREATE INDEX "person_type_name_index" ON "public"."person_type"("name");

-- CreateIndex
CREATE UNIQUE INDEX "unique_email" ON "public"."person"("email");

-- CreateIndex
CREATE UNIQUE INDEX "unique_document_number" ON "public"."person"("document_number");

-- CreateIndex
CREATE UNIQUE INDEX "unique_user_person" ON "public"."user_person"("user_id", "person_id");

-- AddForeignKey
ALTER TABLE "public"."policy" ADD CONSTRAINT "fk_policy_action1" FOREIGN KEY ("action_id") REFERENCES "public"."action"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."policy" ADD CONSTRAINT "fk_policy_resource1" FOREIGN KEY ("resource_id") REFERENCES "public"."resource"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."role_policy" ADD CONSTRAINT "role_policy_policy_id_fkey" FOREIGN KEY ("policy_id") REFERENCES "public"."policy"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."role_policy" ADD CONSTRAINT "role_policy_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."role"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_role" ADD CONSTRAINT "fk_user_role_role1" FOREIGN KEY ("role_id") REFERENCES "public"."role"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."user_role" ADD CONSTRAINT "fk_user_role_user1" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."user_session" ADD CONSTRAINT "fk_session_user1" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."user_notification_type" ADD CONSTRAINT "user_notification_type_notification_type_id_fkey" FOREIGN KEY ("notification_type_id") REFERENCES "public"."notification_type"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_notification_type" ADD CONSTRAINT "fk_user_notification_type_user1" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."city" ADD CONSTRAINT "fk_city_country1" FOREIGN KEY ("country_id") REFERENCES "public"."country"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."person" ADD CONSTRAINT "fk_person_city1" FOREIGN KEY ("city_id") REFERENCES "public"."city"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."person" ADD CONSTRAINT "fk_person_country1" FOREIGN KEY ("country_id") REFERENCES "public"."country"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."person" ADD CONSTRAINT "fk_person_document_type1" FOREIGN KEY ("document_type_id") REFERENCES "public"."document_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."person" ADD CONSTRAINT "fk_person_person_type1" FOREIGN KEY ("person_type_id") REFERENCES "public"."person_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."user_person" ADD CONSTRAINT "fk_user_person_person1" FOREIGN KEY ("person_id") REFERENCES "public"."person"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."user_person" ADD CONSTRAINT "fk_user_person_user1" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
