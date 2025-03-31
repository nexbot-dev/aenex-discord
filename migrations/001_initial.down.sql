DROP INDEX IF EXISTS "index_users_user_id";

DROP INDEX IF EXISTS "index_weapons_code";

DROP INDEX IF EXISTS "index_armors_code";

DROP INDEX IF EXISTS "index_heals_code";

DROP INDEX IF EXISTS "index_rarities_code";

DROP INDEX IF EXISTS "index_elements_code";

DROP INDEX IF EXISTS "index_inventories_user_id";

DROP TABLE IF EXISTS "inventories";

DROP TYPE IF EXISTS "item_types";

DROP TABLE IF EXISTS "heal_item_relations";

DROP TABLE IF EXISTS "armor_item_relations";

DROP TABLE IF EXISTS "weapon_item_relations";

DROP TABLE IF EXISTS "elements";

DROP TABLE IF EXISTS "rarities";

DROP TABLE IF EXISTS "heals";

DROP TABLE IF EXISTS "armors";

DROP TABLE IF EXISTS "weapons";

DROP TABLE IF EXISTS "users";