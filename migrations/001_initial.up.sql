CREATE TABLE IF NOT EXISTS
    "users" (
        "id" VARCHAR PRIMARY KEY NOT NULL,
        "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- base data
        "user_id" VARCHAR UNIQUE NOT NULL,
        "username" VARCHAR NOT NULL,
        -- player data
        "hit_point" NUMERIC NOT NULL,
        "experience" NUMERIC DEFAULT 0
    );

CREATE INDEX "index_users_user_id" ON "users" ("user_id");

CREATE TABLE IF NOT EXISTS
    "weapons" (
        "id" VARCHAR PRIMARY KEY NOT NULL,
        "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- item data
        "name" VARCHAR NOT NULL,
        "code" VARCHAR UNIQUE NOT NULL,
        "type" VARCHAR NOT NULL,
        "attack" NUMERIC NOT NULL,
        "power" NUMERIC NOT NULL,
        "hit" NUMERIC NOT NULL,
        -- shop data
        "price" NUMERIC NOT NULL,
        "is_hidden" BOOLEAN DEFAULT FALSE
    );

CREATE INDEX "index_weapons_code" ON "weapons" ("code");

CREATE TABLE IF NOT EXISTS
    "armors" (
        "id" VARCHAR PRIMARY KEY NOT NULL,
        "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- item data
        "name" VARCHAR NOT NULL,
        "code" VARCHAR UNIQUE NOT NULL,
        "type" VARCHAR NOT NULL,
        "hit_point" NUMERIC NOT NULL,
        "defense" NUMERIC NOT NULL,
        "hit_mod" NUMERIC NOT NULL,
        -- shop data
        "price" NUMERIC NOT NULL,
        "is_hidden" BOOLEAN DEFAULT FALSE
    );

CREATE INDEX "index_armors_code" ON "armors" ("code");

CREATE TABLE IF NOT EXISTS
    "heals" (
        "id" VARCHAR PRIMARY KEY NOT NULL,
        "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- item data
        "name" VARCHAR NOT NULL,
        "code" VARCHAR UNIQUE NOT NULL,
        "heal" NUMERIC NOT NULL,
        -- shop data
        "price" NUMERIC NOT NULL,
        "is_hidden" BOOLEAN DEFAULT FALSE
    );

CREATE INDEX "index_heals_code" ON "heals" ("code");

CREATE TABLE IF NOT EXISTS
    "rarities" (
        "id" VARCHAR PRIMARY KEY NOT NULL,
        "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- base data
        "name" VARCHAR NOT NULL,
        "code" VARCHAR UNIQUE NOT NULL,
        "rarity" NUMERIC NOT NULL,
        -- weapon
        "attack_mod" NUMERIC NOT NULL,
        "hit_mod" NUMERIC NOT NULL,
        -- armor
        "hp_mod" NUMERIC NOT NULL,
        "def_mod" NUMERIC NOT NULL,
        -- heal
        "heal_mod" NUMERIC NOT NULL
    );

CREATE INDEX "index_rarities_code" ON "rarities" ("code");

CREATE TABLE IF NOT EXISTS
    "elements" (
        "id" VARCHAR PRIMARY KEY NOT NULL,
        "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- base data
        "name" VARCHAR NOT NULL,
        "code" VARCHAR UNIQUE NOT NULL,
        "strength" VARCHAR[] NOT NULL DEFAULT '{}',
        "strength_mod" NUMERIC NOT NULL,
        "weakness" VARCHAR[] NOT NULL DEFAULT '{}',
        "weakness_mod" NUMERIC NOT NULL
    );

CREATE INDEX "index_elements_code" ON "elements" ("code");

CREATE TABLE IF NOT EXISTS
    "weapon_item_relations" (
        "id" VARCHAR PRIMARY KEY NOT NULL,
        "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- base data
        "weapon_id" VARCHAR NOT NULL,
        "rarity_id" VARCHAR, -- null, if the item not have rarity
        "element_id" VARCHAR, -- null, if the item not have element or base type
        -- relation
        FOREIGN KEY ("weapon_id") REFERENCES "weapons" ("id") ON DELETE RESTRICT,
        FOREIGN KEY ("rarity_id") REFERENCES "rarities" ("id") ON DELETE RESTRICT,
        FOREIGN KEY ("element_id") REFERENCES "elements" ("id") ON DELETE RESTRICT
    );

CREATE TABLE IF NOT EXISTS
    "armor_item_relations" (
        "id" VARCHAR PRIMARY KEY NOT NULL,
        "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- base data
        "armor_id" VARCHAR NOT NULL,
        "rarity_id" VARCHAR, -- null, if the item not have rarity
        "element_id" VARCHAR -- null, if the item not have element or base type
        -- relation
        FOREIGN KEY ("armor_id") REFERENCES "armors" ("id") ON DELETE RESTRICT,
        FOREIGN KEY ("rarity_id") REFERENCES "rarities" ("id") ON DELETE RESTRICT,
        FOREIGN KEY ("element_id") REFERENCES "elements" ("id") ON DELETE RESTRICT
    );

CREATE TABLE IF NOT EXISTS
    "heal_item_relations" (
        "id" VARCHAR PRIMARY KEY NOT NULL,
        "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- base data
        "heal_id" VARCHAR NOT NULL,
        "rarity_id" VARCHAR, -- null, if the item not have rarity
        "element_id" VARCHAR -- null, if the item not have element or base type
        -- relation
        FOREIGN KEY ("heal_id") REFERENCES "heals" ("id") ON DELETE RESTRICT,
        FOREIGN KEY ("rarity_id") REFERENCES "rarities" ("id") ON DELETE RESTRICT,
        FOREIGN KEY ("element_id") REFERENCES "elements" ("id") ON DELETE RESTRICT
    );

CREATE TYPE "item_types" AS ENUM('weapon', 'armor', 'heal');

CREATE TABLE IF NOT EXISTS
    "inventories" (
        "id" VARCHAR PRIMARY KEY NOT NULL,
        "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- base data
        "user_id" VARCHAR UNIQUE NOT NULL,
        "item_type" "item_types" NOT NULL,
        "item_id" VARCHAR NOT NULL,
        "amount" NUMERIC NOT NULL DEFAULT 0,
        -- relation
        FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT
    );

CREATE INDEX "index_inventories_user_id" ON "inventories" ("user_id");