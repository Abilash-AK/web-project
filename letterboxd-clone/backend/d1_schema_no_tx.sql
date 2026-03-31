--
-- Create model User
--
CREATE TABLE "users" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "password" varchar(128) NOT NULL, "last_login" datetime NULL, "is_superuser" bool NOT NULL, "username" varchar(150) NOT NULL UNIQUE, "first_name" varchar(150) NOT NULL, "last_name" varchar(150) NOT NULL, "email" varchar(254) NOT NULL, "is_staff" bool NOT NULL, "is_active" bool NOT NULL, "date_joined" datetime NOT NULL, "bio" text NOT NULL, "profile_image" varchar(500) NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users_groups" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" bigint NOT NULL REFERENCES "users" ("id") DEFERRABLE INITIALLY DEFERRED, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "users_user_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" bigint NOT NULL REFERENCES "users" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE UNIQUE INDEX "users_groups_user_id_group_id_fc7788e8_uniq" ON "users_groups" ("user_id", "group_id");
CREATE INDEX "users_groups_user_id_f500bee5" ON "users_groups" ("user_id");
CREATE INDEX "users_groups_group_id_2f3517aa" ON "users_groups" ("group_id");
CREATE UNIQUE INDEX "users_user_permissions_user_id_permission_id_3b86cbdf_uniq" ON "users_user_permissions" ("user_id", "permission_id");
CREATE INDEX "users_user_permissions_user_id_92473840" ON "users_user_permissions" ("user_id");
CREATE INDEX "users_user_permissions_permission_id_6d08dcd2" ON "users_user_permissions" ("permission_id");

--
-- Create model MovieCache
--
CREATE TABLE "movie_cache" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "tmdb_id" integer NOT NULL UNIQUE, "title" varchar(255) NOT NULL, "poster_path" varchar(255) NOT NULL, "backdrop_path" varchar(255) NOT NULL, "overview" text NOT NULL, "release_date" date NULL, "genres" text NOT NULL CHECK ((JSON_VALID("genres") OR "genres" IS NULL)), "vote_average" real NOT NULL, "vote_count" integer NOT NULL, "cached_at" datetime NOT NULL);

--
-- Create model Review
--
CREATE TABLE "reviews" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "movie_id" integer NOT NULL, "rating" integer NOT NULL, "review_text" text NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
--
-- Create model ReviewLike
--
CREATE TABLE "review_likes" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "created_at" datetime NOT NULL);
--
-- Create model Watched
--
CREATE TABLE "watched" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "movie_id" integer NOT NULL, "watched_date" date NOT NULL, "created_at" datetime NOT NULL);
CREATE INDEX "reviews_movie_id_838b3811" ON "reviews" ("movie_id");
CREATE INDEX "watched_movie_id_21663e3d" ON "watched" ("movie_id");

--
-- Add field user to watched
--
CREATE TABLE "new__watched" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" bigint NOT NULL REFERENCES "users" ("id") DEFERRABLE INITIALLY DEFERRED, "movie_id" integer NOT NULL, "watched_date" date NOT NULL, "created_at" datetime NOT NULL);
INSERT INTO "new__watched" ("id", "movie_id", "watched_date", "created_at", "user_id") SELECT "id", "movie_id", "watched_date", "created_at", NULL FROM "watched";
DROP TABLE "watched";
ALTER TABLE "new__watched" RENAME TO "watched";
CREATE INDEX "watched_user_id_a84a67a3" ON "watched" ("user_id");
CREATE INDEX "watched_movie_id_21663e3d" ON "watched" ("movie_id");
--
-- Add field review to reviewlike
--
CREATE TABLE "new__review_likes" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "created_at" datetime NOT NULL, "review_id" bigint NOT NULL REFERENCES "reviews" ("id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "new__review_likes" ("id", "created_at", "review_id") SELECT "id", "created_at", NULL FROM "review_likes";
DROP TABLE "review_likes";
ALTER TABLE "new__review_likes" RENAME TO "review_likes";
CREATE INDEX "review_likes_review_id_5eb31dcf" ON "review_likes" ("review_id");
--
-- Add field user to reviewlike
--
CREATE TABLE "new__review_likes" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "created_at" datetime NOT NULL, "review_id" bigint NOT NULL REFERENCES "reviews" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" bigint NOT NULL REFERENCES "users" ("id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "new__review_likes" ("id", "created_at", "review_id", "user_id") SELECT "id", "created_at", "review_id", NULL FROM "review_likes";
DROP TABLE "review_likes";
ALTER TABLE "new__review_likes" RENAME TO "review_likes";
CREATE INDEX "review_likes_review_id_5eb31dcf" ON "review_likes" ("review_id");
CREATE INDEX "review_likes_user_id_fea3a517" ON "review_likes" ("user_id");
--
-- Add field user to review
--
CREATE TABLE "new__reviews" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "movie_id" integer NOT NULL, "rating" integer NOT NULL, "review_text" text NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "user_id" bigint NOT NULL REFERENCES "users" ("id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "new__reviews" ("id", "movie_id", "rating", "review_text", "created_at", "updated_at", "user_id") SELECT "id", "movie_id", "rating", "review_text", "created_at", "updated_at", NULL FROM "reviews";
DROP TABLE "reviews";
ALTER TABLE "new__reviews" RENAME TO "reviews";
CREATE INDEX "reviews_movie_id_838b3811" ON "reviews" ("movie_id");
CREATE INDEX "reviews_user_id_c23b0903" ON "reviews" ("user_id");
--
-- Alter unique_together for watched (1 constraint(s))
--
CREATE UNIQUE INDEX "watched_user_id_movie_id_51bec378_uniq" ON "watched" ("user_id", "movie_id");
--
-- Alter unique_together for reviewlike (1 constraint(s))
--
CREATE UNIQUE INDEX "review_likes_user_id_review_id_2392837c_uniq" ON "review_likes" ("user_id", "review_id");
--
-- Alter unique_together for review (1 constraint(s))
--
CREATE UNIQUE INDEX "reviews_user_id_movie_id_2e3b67eb_uniq" ON "reviews" ("user_id", "movie_id");

