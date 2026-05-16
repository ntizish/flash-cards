-- ============================================================
-- Flash Cards — data migration
-- Migrates the default words.json vocabulary into Supabase.
--
-- Run AFTER migration.sql.
--
-- If you have custom words saved in your browser's localStorage,
-- open the browser console on the old site and run:
--   console.log(JSON.stringify(JSON.parse(localStorage.getItem('spanish-vocabulary-folders')), null, 2))
-- then adapt the INSERT statements below with your own data.
-- ============================================================


-- ── Folder: Basics ──────────────────────────────────────────
SELECT create_folder_table('basics-folder');

INSERT INTO folders (id, name) VALUES ('basics-folder', 'Basics')
  ON CONFLICT (id) DO NOTHING;

INSERT INTO words_basics_folder (id, spanish, english, enabled) VALUES
  ('casa-house',  'casa',  'house',  true),
  ('agua-water',  'agua',  'water',  true),
  ('libro-book',  'libro', 'book',   true)
ON CONFLICT (id) DO NOTHING;


-- ── Folder: Travel ──────────────────────────────────────────
SELECT create_folder_table('travel-folder');

INSERT INTO folders (id, name) VALUES ('travel-folder', 'Travel')
  ON CONFLICT (id) DO NOTHING;

INSERT INTO words_travel_folder (id, spanish, english, enabled) VALUES
  ('tren-train',   'tren',   'train',  true),
  ('hotel-hotel',  'hotel',  'hotel',  true)
ON CONFLICT (id) DO NOTHING;
