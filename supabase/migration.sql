-- ============================================================
-- Flash Cards — Supabase migration
-- Run this once in your Supabase SQL editor
-- ============================================================

-- Folders metadata table
CREATE TABLE IF NOT EXISTS folders (
  id          TEXT        PRIMARY KEY,
  name        TEXT        NOT NULL,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Allow anon (public) read/write — site is protected by app-level password
ALTER TABLE folders ENABLE ROW LEVEL SECURITY;

CREATE POLICY "anon_all" ON folders
  FOR ALL TO anon
  USING (true)
  WITH CHECK (true);


-- ============================================================
-- RPC: create the words table for a new folder
-- ============================================================
CREATE OR REPLACE FUNCTION create_folder_table(p_folder_id TEXT)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  EXECUTE format(
    'CREATE TABLE IF NOT EXISTS words_%s (
       id         TEXT        PRIMARY KEY,
       spanish    TEXT        NOT NULL,
       english    TEXT        NOT NULL,
       enabled    BOOLEAN     NOT NULL DEFAULT TRUE,
       created_at TIMESTAMPTZ DEFAULT NOW()
     )',
    replace(p_folder_id, '-', '_')
  );
  -- Grant the anon role full access on the dynamically created table
  EXECUTE format(
    'GRANT SELECT, INSERT, UPDATE, DELETE ON words_%s TO anon',
    replace(p_folder_id, '-', '_')
  );
END;
$$;

GRANT EXECUTE ON FUNCTION create_folder_table TO anon;


-- ============================================================
-- RPC: drop the words table when a folder is deleted
-- ============================================================
CREATE OR REPLACE FUNCTION drop_folder_table(p_folder_id TEXT)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  EXECUTE format(
    'DROP TABLE IF EXISTS words_%s',
    replace(p_folder_id, '-', '_')
  );
END;
$$;

GRANT EXECUTE ON FUNCTION drop_folder_table TO anon;


-- ============================================================
-- RPC: get all words from a folder's table (ordered newest first)
-- ============================================================
CREATE OR REPLACE FUNCTION get_folder_words(p_folder_id TEXT)
RETURNS TABLE(id TEXT, spanish TEXT, english TEXT, enabled BOOLEAN)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY EXECUTE format(
    'SELECT id, spanish, english, enabled
       FROM words_%s
      ORDER BY created_at DESC',
    replace(p_folder_id, '-', '_')
  );
END;
$$;

GRANT EXECUTE ON FUNCTION get_folder_words TO anon;


-- ============================================================
-- RPC: insert or update a word in a folder's table
-- ============================================================
CREATE OR REPLACE FUNCTION upsert_folder_word(
  p_folder_id TEXT,
  p_id        TEXT,
  p_spanish   TEXT,
  p_english   TEXT,
  p_enabled   BOOLEAN
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  EXECUTE format(
    'INSERT INTO words_%s (id, spanish, english, enabled)
          VALUES ($1, $2, $3, $4)
     ON CONFLICT (id) DO UPDATE
           SET spanish = $2,
               english = $3,
               enabled = $4',
    replace(p_folder_id, '-', '_')
  ) USING p_id, p_spanish, p_english, p_enabled;
END;
$$;

GRANT EXECUTE ON FUNCTION upsert_folder_word TO anon;


-- ============================================================
-- RPC: toggle enabled flag on a word
-- ============================================================
CREATE OR REPLACE FUNCTION toggle_folder_word(
  p_folder_id TEXT,
  p_word_id   TEXT,
  p_enabled   BOOLEAN
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  EXECUTE format(
    'UPDATE words_%s SET enabled = $1 WHERE id = $2',
    replace(p_folder_id, '-', '_')
  ) USING p_enabled, p_word_id;
END;
$$;

GRANT EXECUTE ON FUNCTION toggle_folder_word TO anon;


-- ============================================================
-- RPC: delete a word from a folder's table
-- ============================================================
CREATE OR REPLACE FUNCTION delete_folder_word(
  p_folder_id TEXT,
  p_word_id   TEXT
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  EXECUTE format(
    'DELETE FROM words_%s WHERE id = $1',
    replace(p_folder_id, '-', '_')
  ) USING p_word_id;
END;
$$;

GRANT EXECUTE ON FUNCTION delete_folder_word TO anon;
