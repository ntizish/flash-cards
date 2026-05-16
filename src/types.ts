export type VocabularyWord = {
  id: string;
  spanish: string;
  translation: string;
  enabled: boolean;
};

export type VocabularyFolder = {
  id: string;
  name: string;
  words: VocabularyWord[];
};

export type DraftWord = {
  spanish: string;
  translation: string;
};
