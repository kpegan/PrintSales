CREATE TABLE "departments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "login" varchar(40), "email" varchar(100), "crypted_password" varchar(40), "salt" varchar(40), "created_at" datetime, "updated_at" datetime, "remember_token" varchar(40), "remember_token_expires_at" datetime, "first_name" varchar(255), "last_name" varchar(255), "mica_id" varchar(255), "graduation" date, "phone" varchar(255), "grad_date" varchar(255), "role_id" varchar(255), "department_id" varchar(255), "position" varchar(255));
CREATE UNIQUE INDEX "index_users_on_login" ON "users" ("login");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20100512233849');

INSERT INTO schema_migrations (version) VALUES ('20100514011540');

INSERT INTO schema_migrations (version) VALUES ('20100514015238');

INSERT INTO schema_migrations (version) VALUES ('20100514201743');