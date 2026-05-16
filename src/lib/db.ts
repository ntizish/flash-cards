import { supabase } from "./supabase";
import type { VocabularyFolder, VocabularyWord } from "../types";

type WordRow = {
  id: string;
  spanish: string;
  english: string;
  enabled: boolean;
};

export async function loadAll(): Promise<VocabularyFolder[]> {
  const { data: folderRows, error: foldersError } = await supabase
    .from("folders")
    .select("id, name")
    .order("created_at", { ascending: false });

  if (foldersError) throw foldersError;

  const result: VocabularyFolder[] = [];

  for (const row of folderRows ?? []) {
    const { data: wordRows, error: wordsError } = await supabase.rpc(
      "get_folder_words",
      { p_folder_id: row.id },
    );

    if (wordsError) throw wordsError;

    result.push({
      id: row.id,
      name: row.name,
      words: (wordRows as WordRow[] ?? []).map((w) => ({
        id: w.id,
        spanish: w.spanish,
        translation: w.english,
        enabled: w.enabled,
      })),
    });
  }

  return result;
}

export async function createFolder(folder: VocabularyFolder): Promise<void> {
  const { error: rpcError } = await supabase.rpc("create_folder_table", {
    p_folder_id: folder.id,
  });
  if (rpcError) throw rpcError;

  const { error } = await supabase
    .from("folders")
    .insert({ id: folder.id, name: folder.name });
  if (error) throw error;
}

export async function renameFolder(id: string, name: string): Promise<void> {
  const { error } = await supabase
    .from("folders")
    .update({ name })
    .eq("id", id);
  if (error) throw error;
}

export async function deleteFolder(id: string): Promise<void> {
  const { error: rpcError } = await supabase.rpc("drop_folder_table", {
    p_folder_id: id,
  });
  if (rpcError) throw rpcError;

  const { error } = await supabase.from("folders").delete().eq("id", id);
  if (error) throw error;
}

export async function upsertWord(
  folderId: string,
  word: VocabularyWord,
): Promise<void> {
  const { error } = await supabase.rpc("upsert_folder_word", {
    p_folder_id: folderId,
    p_id: word.id,
    p_spanish: word.spanish,
    p_english: word.translation,
    p_enabled: word.enabled,
  });
  if (error) throw error;
}

export async function deleteWord(
  folderId: string,
  wordId: string,
): Promise<void> {
  const { error } = await supabase.rpc("delete_folder_word", {
    p_folder_id: folderId,
    p_word_id: wordId,
  });
  if (error) throw error;
}

export async function toggleWord(
  folderId: string,
  wordId: string,
  enabled: boolean,
): Promise<void> {
  const { error } = await supabase.rpc("toggle_folder_word", {
    p_folder_id: folderId,
    p_word_id: wordId,
    p_enabled: enabled,
  });
  if (error) throw error;
}
