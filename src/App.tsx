import { FormEvent, useEffect, useMemo, useRef, useState } from "react";
import type { DraftWord, VocabularyFolder, VocabularyWord } from "./types";
import * as db from "./lib/db";

const MAX_CORRECT_PER_SESSION = 4;
const AUTH_KEY = "flash-cards-auth";

const EMPTY_WORD_DRAFT: DraftWord = {
  spanish: "",
  translation: "",
};

function normalizeAnswer(value: string) {
  return value.trim().replace(/\s+/g, " ").toLowerCase();
}

function chooseRandomWord(
  words: VocabularyWord[],
  previousId: string | null,
  correctCounts: Record<string, number>,
) {
  const eligibleWords = words.filter(
    (word) => (correctCounts[word.id] ?? 0) < MAX_CORRECT_PER_SESSION,
  );

  if (eligibleWords.length === 0) {
    return null;
  }

  const pool =
    eligibleWords.length > 1 && previousId
      ? eligibleWords.filter((word) => word.id !== previousId)
      : eligibleWords;

  return pool[Math.floor(Math.random() * pool.length)] ?? null;
}

type ModalState =
  | null
  | { type: "folder"; folderId: string | null }
  | { type: "word"; wordId: string | null };

function App() {
  // ── Auth ────────────────────────────────────────────────────
  const [isAuthenticated, setIsAuthenticated] = useState(
    () => sessionStorage.getItem(AUTH_KEY) === "true",
  );
  const [passwordDraft, setPasswordDraft] = useState("");
  const [passwordError, setPasswordError] = useState(false);

  // ── Data ────────────────────────────────────────────────────
  const [folders, setFolders] = useState<VocabularyFolder[]>([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);

  // ── Navigation ──────────────────────────────────────────────
  const [view, setView] = useState<"folders" | "words" | "study">("folders");
  const [selectedFolderId, setSelectedFolderId] = useState<string | null>(null);
  const [modal, setModal] = useState<ModalState>(null);
  const [folderNameDraft, setFolderNameDraft] = useState("");
  const [wordDraft, setWordDraft] = useState<DraftWord>(EMPTY_WORD_DRAFT);

  // ── Study session ───────────────────────────────────────────
  const [reverseLanguages, setReverseLanguages] = useState(false);
  const [activeWord, setActiveWord] = useState<VocabularyWord | null>(null);
  const [answer, setAnswer] = useState("");
  const [feedback, setFeedback] = useState<"correct" | "incorrect" | null>(null);
  const [studiedCount, setStudiedCount] = useState(0);
  const [correctCounts, setCorrectCounts] = useState<Record<string, number>>({});

  const answerInputRef = useRef<HTMLInputElement | null>(null);
  const modalInputRef = useRef<HTMLInputElement | null>(null);

  // ── Load all data on auth ───────────────────────────────────
  useEffect(() => {
    if (!isAuthenticated) return;

    async function init() {
      setLoading(true);
      try {
        setFolders(await db.loadAll());
      } catch (e) {
        console.error(e);
        alert("Failed to load data from Supabase. Check your env vars.");
      } finally {
        setLoading(false);
      }
    }

    void init();
  }, [isAuthenticated]);

  // ── Focus helpers ───────────────────────────────────────────
  useEffect(() => {
    if (modal) {
      window.setTimeout(() => modalInputRef.current?.focus(), 20);
    }
  }, [modal]);

  useEffect(() => {
    if (view === "study") {
      window.setTimeout(() => answerInputRef.current?.focus(), 20);
    }
  }, [activeWord, feedback, view]);

  // ── Derived state ───────────────────────────────────────────
  const selectedFolder = useMemo(
    () => folders.find((folder) => folder.id === selectedFolderId) ?? null,
    [folders, selectedFolderId],
  );

  const editingFolder =
    modal?.type === "folder" && modal.folderId
      ? folders.find((folder) => folder.id === modal.folderId) ?? null
      : null;

  const editingWord =
    modal?.type === "word" && modal.wordId && selectedFolder
      ? selectedFolder.words.find((word) => word.id === modal.wordId) ?? null
      : null;

  const studyWords = selectedFolder?.words.filter((word) => word.enabled) ?? [];

  // ── Guard: auto-leave views when folder disappears ──────────
  useEffect(() => {
    if (!selectedFolder && view !== "folders") {
      setView("folders");
      setActiveWord(null);
      setFeedback(null);
      setAnswer("");
      setStudiedCount(0);
      setCorrectCounts({});
      return;
    }

    if (selectedFolder && selectedFolder.words.length === 0 && view === "study") {
      setView("words");
      setActiveWord(null);
      setFeedback(null);
      setAnswer("");
      setStudiedCount(0);
      setCorrectCounts({});
    }

    if (
      activeWord &&
      selectedFolder &&
      !studyWords.some((word) => word.id === activeWord.id)
    ) {
      setActiveWord(chooseRandomWord(studyWords, activeWord.id, correctCounts));
      setFeedback(null);
      setAnswer("");
    }
  }, [activeWord, correctCounts, selectedFolder, studyWords, view]);

  useEffect(() => {
    if (view === "study" && selectedFolder && studyWords.length > 0 && !activeWord) {
      setActiveWord(chooseRandomWord(studyWords, null, correctCounts));
    }
  }, [activeWord, correctCounts, selectedFolder, studyWords, view]);

  const promptText = activeWord
    ? reverseLanguages
      ? activeWord.translation
      : activeWord.spanish
    : "";
  const expectedAnswer = activeWord
    ? reverseLanguages
      ? activeWord.spanish
      : activeWord.translation
    : "";

  // ── Auth ────────────────────────────────────────────────────
  function handlePasswordSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    if (passwordDraft === import.meta.env.VITE_APP_PASSWORD) {
      sessionStorage.setItem(AUTH_KEY, "true");
      setIsAuthenticated(true);
      setPasswordError(false);
    } else {
      setPasswordError(true);
      setPasswordDraft("");
    }
  }

  // ── Modal helpers ───────────────────────────────────────────
  function openFolderModal(folder?: VocabularyFolder) {
    setModal({ type: "folder", folderId: folder?.id ?? null });
    setFolderNameDraft(folder?.name ?? "");
  }

  function openWordModal(word?: VocabularyWord) {
    setModal({ type: "word", wordId: word?.id ?? null });
    setWordDraft(
      word ? { spanish: word.spanish, translation: word.translation } : EMPTY_WORD_DRAFT,
    );
  }

  function closeModal() {
    setModal(null);
    setFolderNameDraft("");
    setWordDraft(EMPTY_WORD_DRAFT);
  }

  function enterFolder(folderId: string) {
    setSelectedFolderId(folderId);
    setView("words");
    setActiveWord(null);
    setFeedback(null);
    setAnswer("");
    setStudiedCount(0);
    setCorrectCounts({});
  }

  function leaveFolder() {
    setView("folders");
    setSelectedFolderId(null);
    setActiveWord(null);
    setFeedback(null);
    setAnswer("");
    setStudiedCount(0);
    setCorrectCounts({});
  }

  // ── Folder CRUD ─────────────────────────────────────────────
  async function handleSaveFolder(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const name = folderNameDraft.trim();
    if (!name) return;

    setSaving(true);
    try {
      if (editingFolder) {
        await db.renameFolder(editingFolder.id, name);
        setFolders((current) =>
          current.map((f) => (f.id === editingFolder.id ? { ...f, name } : f)),
        );
      } else {
        const nextFolder: VocabularyFolder = {
          id: crypto.randomUUID(),
          name,
          words: [],
        };
        await db.createFolder(nextFolder);
        setFolders((current) => [nextFolder, ...current]);
        setSelectedFolderId(nextFolder.id);
      }
      closeModal();
    } catch (e) {
      console.error(e);
      alert("Failed to save folder. Please try again.");
    } finally {
      setSaving(false);
    }
  }

  async function handleDeleteFolder(folder: VocabularyFolder) {
    const confirmed = window.confirm(`Delete folder "${folder.name}"?`);
    if (!confirmed) return;

    setSaving(true);
    try {
      await db.deleteFolder(folder.id);
      setFolders((current) => current.filter((f) => f.id !== folder.id));
      if (selectedFolderId === folder.id) leaveFolder();
    } catch (e) {
      console.error(e);
      alert("Failed to delete folder. Please try again.");
    } finally {
      setSaving(false);
    }
  }

  // ── Word CRUD ───────────────────────────────────────────────
  async function handleSaveWord(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    if (!selectedFolder) return;

    const spanish = wordDraft.spanish.trim();
    const translation = wordDraft.translation.trim();
    if (!spanish || !translation) return;

    setSaving(true);
    try {
      if (editingWord) {
        const updated: VocabularyWord = { ...editingWord, spanish, translation };
        await db.upsertWord(selectedFolder.id, updated);
        setFolders((current) =>
          current.map((folder) =>
            folder.id !== selectedFolder.id
              ? folder
              : {
                  ...folder,
                  words: folder.words.map((w) =>
                    w.id === editingWord.id ? updated : w,
                  ),
                },
          ),
        );
      } else {
        const newWord: VocabularyWord = {
          id: crypto.randomUUID(),
          spanish,
          translation,
          enabled: true,
        };
        await db.upsertWord(selectedFolder.id, newWord);
        setFolders((current) =>
          current.map((folder) =>
            folder.id !== selectedFolder.id
              ? folder
              : { ...folder, words: [newWord, ...folder.words] },
          ),
        );
      }
      closeModal();
    } catch (e) {
      console.error(e);
      alert("Failed to save word. Please try again.");
    } finally {
      setSaving(false);
    }
  }

  async function handleDeleteWord(word: VocabularyWord) {
    if (!selectedFolder) return;
    const confirmed = window.confirm(`Delete "${word.spanish} / ${word.translation}"?`);
    if (!confirmed) return;

    setSaving(true);
    try {
      await db.deleteWord(selectedFolder.id, word.id);
      setFolders((current) =>
        current.map((folder) =>
          folder.id !== selectedFolder.id
            ? folder
            : { ...folder, words: folder.words.filter((w) => w.id !== word.id) },
        ),
      );
    } catch (e) {
      console.error(e);
      alert("Failed to delete word. Please try again.");
    } finally {
      setSaving(false);
    }
  }

  function toggleWordEnabled(wordId: string) {
    if (!selectedFolder) return;
    const word = selectedFolder.words.find((w) => w.id === wordId);
    if (!word) return;

    const nextEnabled = !word.enabled;

    // Optimistic update — fire and forget
    setFolders((current) =>
      current.map((folder) =>
        folder.id !== selectedFolder.id
          ? folder
          : {
              ...folder,
              words: folder.words.map((w) =>
                w.id === wordId ? { ...w, enabled: nextEnabled } : w,
              ),
            },
      ),
    );

    void db.toggleWord(selectedFolder.id, wordId, nextEnabled).catch((e) => {
      console.error(e);
      // Revert on error
      setFolders((current) =>
        current.map((folder) =>
          folder.id !== selectedFolder.id
            ? folder
            : {
                ...folder,
                words: folder.words.map((w) =>
                  w.id === wordId ? { ...w, enabled: !nextEnabled } : w,
                ),
              },
        ),
      );
    });
  }

  // ── Study ───────────────────────────────────────────────────
  function startStudy() {
    if (!selectedFolder || studyWords.length === 0) return;
    const nextCorrectCounts: Record<string, number> = {};
    setView("study");
    setFeedback(null);
    setAnswer("");
    setStudiedCount(0);
    setCorrectCounts(nextCorrectCounts);
    setActiveWord(
      chooseRandomWord(studyWords, activeWord?.id ?? null, nextCorrectCounts),
    );
  }

  function leaveStudy() {
    setView("words");
    setFeedback(null);
    setAnswer("");
    setActiveWord(null);
    setCorrectCounts({});
    setStudiedCount(0);
  }

  function checkAnswer() {
    if (!activeWord) return;
    const isCorrect = normalizeAnswer(answer) === normalizeAnswer(expectedAnswer);
    setFeedback(isCorrect ? "correct" : "incorrect");
    setStudiedCount((count) => count + 1);
    if (isCorrect) {
      setCorrectCounts((current) => ({
        ...current,
        [activeWord.id]: (current[activeWord.id] ?? 0) + 1,
      }));
    }
  }

  function moveToNextWord() {
    if (!selectedFolder || !activeWord) return;
    setActiveWord(chooseRandomWord(studyWords, activeWord.id, correctCounts));
    setAnswer("");
    setFeedback(null);
  }

  function handleStudySubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    if (feedback) {
      moveToNextWord();
      return;
    }
    checkAnswer();
  }

  // ── Render: password gate ───────────────────────────────────
  if (!isAuthenticated) {
    return (
      <div className="app-shell">
        <main className="page">
          <section className="panel">
            <div className="panel-header">
              <div>
                <p className="panel-label">Access</p>
                <h1 className="page-title">Vocabulary Folders</h1>
              </div>
            </div>
            <form className="editor-form" onSubmit={handlePasswordSubmit}>
              <label className="field-label" htmlFor="password">
                Password
              </label>
              <input
                id="password"
                className="brutalist-input"
                type="password"
                autoFocus
                autoComplete="current-password"
                value={passwordDraft}
                onChange={(e) => {
                  setPasswordDraft(e.target.value);
                  setPasswordError(false);
                }}
                placeholder="Enter password"
              />
              {passwordError && (
                <p style={{ color: "red", margin: "4px 0 0" }}>Incorrect password.</p>
              )}
              <div className="button-row">
                <button className="primary-button" type="submit">
                  Enter
                </button>
              </div>
            </form>
          </section>
        </main>
      </div>
    );
  }

  // ── Render: loading ─────────────────────────────────────────
  if (loading) {
    return (
      <div className="app-shell">
        <main className="page">
          <section className="panel">
            <p className="panel-meta">Loading…</p>
          </section>
        </main>
      </div>
    );
  }

  // ── Render: main app ────────────────────────────────────────
  return (
    <div className="app-shell">
      {view === "folders" && (
        <main className="page">
          <section className="panel">
            <div className="panel-header">
              <div>
                <p className="panel-label">Folders</p>
                <h1 className="page-title">Vocabulary Folders</h1>
              </div>
              <button
                className="text-button"
                type="button"
                disabled={saving}
                onClick={() => openFolderModal()}
              >
                Create New Folder
              </button>
            </div>

            {folders.length === 0 ? (
              <div className="empty-state">
                <p>No folders yet. Create your first folder.</p>
              </div>
            ) : (
              <div className="list-table" role="table" aria-label="Vocabulary folders">
                <div className="list-head" role="rowgroup">
                  <div className="list-row list-row-head folder-row" role="row">
                    <span role="columnheader">Folder</span>
                    <span role="columnheader">Words</span>
                    <span role="columnheader">Actions</span>
                  </div>
                </div>
                <div role="rowgroup">
                  {folders.map((folder) => (
                    <article className="list-row folder-row" key={folder.id} role="row">
                      <button
                        className="folder-link"
                        type="button"
                        onClick={() => enterFolder(folder.id)}
                      >
                        {folder.name}
                      </button>
                      <span className="folder-count" role="cell">
                        {folder.words.length}
                      </span>
                      <span className="row-actions" role="cell">
                        <button
                          className="text-button"
                          type="button"
                          disabled={saving}
                          onClick={() => openFolderModal(folder)}
                        >
                          Edit
                        </button>
                        <button
                          className="text-button"
                          type="button"
                          disabled={saving}
                          onClick={() => handleDeleteFolder(folder)}
                        >
                          Delete
                        </button>
                      </span>
                    </article>
                  ))}
                </div>
              </div>
            )}
          </section>
        </main>
      )}

      {view === "words" && selectedFolder && (
        <main className="page">
          <section className="panel">
            <div className="panel-header">
              <div>
                <button className="text-button back-link" type="button" onClick={leaveFolder}>
                  Back to folders
                </button>
                <h1 className="page-title">{selectedFolder.name}</h1>
              </div>
              <p className="panel-meta">{selectedFolder.words.length} words</p>
            </div>

            {selectedFolder.words.length === 0 ? (
              <div className="empty-state">
                <p>No words added yet. Add your first word.</p>
              </div>
            ) : (
              <div className="list-table" role="table" aria-label="Vocabulary words">
                <div className="list-head" role="rowgroup">
                  <div className="list-row list-row-head word-row" role="row">
                    <span role="columnheader">Study</span>
                    <span role="columnheader">Spanish word</span>
                    <span role="columnheader">Translation</span>
                    <span role="columnheader">Actions</span>
                  </div>
                </div>
                <div role="rowgroup">
                  {selectedFolder.words.map((word) => (
                    <article className="list-row word-row" key={word.id} role="row">
                      <label
                        className="word-checkbox"
                        aria-label={`Include ${word.spanish} in study`}
                      >
                        <input
                          type="checkbox"
                          checked={word.enabled}
                          onChange={() => toggleWordEnabled(word.id)}
                        />
                      </label>
                      <span className="word-primary" role="cell">
                        {word.spanish}
                      </span>
                      <span className="word-secondary" role="cell">
                        {word.translation}
                      </span>
                      <span className="row-actions" role="cell">
                        <button
                          className="text-button"
                          type="button"
                          disabled={saving}
                          onClick={() => openWordModal(word)}
                        >
                          Edit
                        </button>
                        <button
                          className="text-button"
                          type="button"
                          disabled={saving}
                          onClick={() => handleDeleteWord(word)}
                        >
                          Delete
                        </button>
                      </span>
                    </article>
                  ))}
                </div>
              </div>
            )}

            <div className="button-row">
              <button
                className="primary-button"
                type="button"
                onClick={startStudy}
                disabled={studyWords.length === 0}
              >
                Study
              </button>
              <button
                className="text-button"
                type="button"
                disabled={saving}
                onClick={() => openWordModal()}
              >
                Add New Word
              </button>
            </div>
          </section>
        </main>
      )}

      {view === "study" && selectedFolder && (
        <main className="page study-page">
          <header className="study-topbar">
            <label className="toggle">
              <input
                type="checkbox"
                checked={reverseLanguages}
                onChange={(event) => setReverseLanguages(event.target.checked)}
              />
              <span>Reverse Languages</span>
            </label>

            <button className="text-button" type="button" onClick={leaveStudy}>
              Leave the folder
            </button>
          </header>

          <section className="study-card">
            <div className="study-meta">
              <div>
                <p className="panel-label">Folder</p>
                <p className="panel-meta">{selectedFolder.name}</p>
              </div>
              <p className="panel-meta">Studied this session: {studiedCount}</p>
            </div>

            {activeWord ? (
              <>
                <div className="study-prompt-wrap">
                  <p className="prompt-label">
                    {reverseLanguages ? "Translate to Spanish" : "Translate to English"}
                  </p>
                  <h2 className="study-prompt">{promptText}</h2>
                </div>

                <form className="study-form" onSubmit={handleStudySubmit}>
                  <label className="field-label" htmlFor="study-answer">
                    Your answer
                  </label>
                  <input
                    id="study-answer"
                    ref={answerInputRef}
                    className="brutalist-input"
                    type="text"
                    autoComplete="off"
                    value={answer}
                    onChange={(event) => setAnswer(event.target.value)}
                    placeholder="Type translation"
                  />

                  <div className="button-row study-actions">
                    <button className="primary-button" type="submit">
                      {feedback ? "Next random word" : "Check Answer"}
                    </button>
                  </div>
                </form>

                {feedback && (
                  <div
                    className={`feedback-block ${
                      feedback === "correct" ? "feedback-correct" : "feedback-incorrect"
                    }`}
                  >
                    <p className="feedback-title">
                      {feedback === "correct" ? "Correct" : "Incorrect"}
                    </p>
                    {feedback === "incorrect" && (
                      <p className="feedback-answer">Correct answer: {expectedAnswer}</p>
                    )}
                  </div>
                )}
              </>
            ) : (
              <div className="study-empty">
                <p className="prompt-label">Session complete</p>
                <h2 className="study-prompt">
                  {studyWords.length === 0
                    ? "No checked words available for study."
                    : "All checked words reached 4 correct answers."}
                </h2>
                <div className="button-row study-actions">
                  <button className="primary-button" type="button" onClick={leaveStudy}>
                    Leave the folder
                  </button>
                </div>
              </div>
            )}
          </section>
        </main>
      )}

      {modal && (
        <div className="modal-backdrop" onClick={closeModal}>
          <div
            className="modal-card"
            onClick={(event) => event.stopPropagation()}
            role="dialog"
            aria-modal="true"
            aria-labelledby="editor-modal-title"
          >
            <div className="panel-header modal-header">
              <p className="panel-label">
                {modal.type === "folder" ? "Folder editor" : "Vocabulary editor"}
              </p>
              <button className="text-button" type="button" onClick={closeModal}>
                Cancel
              </button>
            </div>

            <h2 id="editor-modal-title">
              {modal.type === "folder"
                ? editingFolder
                  ? "Edit Folder"
                  : "New Folder"
                : editingWord
                  ? "Edit Word"
                  : "Add New Word"}
            </h2>

            {modal.type === "folder" ? (
              <form className="editor-form" onSubmit={handleSaveFolder}>
                <label className="field-label" htmlFor="folder-name">
                  Folder name
                </label>
                <input
                  id="folder-name"
                  ref={modalInputRef}
                  className="brutalist-input"
                  type="text"
                  value={folderNameDraft}
                  onChange={(event) => setFolderNameDraft(event.target.value)}
                  placeholder="Travel words"
                />

                <div className="button-row">
                  <button className="primary-button" type="submit" disabled={saving}>
                    {saving ? "Saving…" : "Save"}
                  </button>
                  <button className="text-button" type="button" onClick={closeModal}>
                    Cancel
                  </button>
                </div>
              </form>
            ) : (
              <form className="editor-form" onSubmit={handleSaveWord}>
                <label className="field-label" htmlFor="spanish-word">
                  Spanish word
                </label>
                <input
                  id="spanish-word"
                  ref={modalInputRef}
                  className="brutalist-input"
                  type="text"
                  value={wordDraft.spanish}
                  onChange={(event) =>
                    setWordDraft((current) => ({
                      ...current,
                      spanish: event.target.value,
                    }))
                  }
                  placeholder="casa"
                />

                <label className="field-label" htmlFor="translation">
                  Translation
                </label>
                <input
                  id="translation"
                  className="brutalist-input"
                  type="text"
                  value={wordDraft.translation}
                  onChange={(event) =>
                    setWordDraft((current) => ({
                      ...current,
                      translation: event.target.value,
                    }))
                  }
                  placeholder="house"
                />

                <div className="button-row">
                  <button className="primary-button" type="submit" disabled={saving}>
                    {saving ? "Saving…" : "Save"}
                  </button>
                  <button className="text-button" type="button" onClick={closeModal}>
                    Cancel
                  </button>
                </div>
              </form>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

export default App;
