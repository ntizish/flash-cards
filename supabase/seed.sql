-- ============================================================
-- Flash Cards — full data migration from localStorage
-- Run AFTER migration.sql
-- ============================================================

-- ── new words (12.05) ────────────────────────────────────────
SELECT create_folder_table('ad57f0bf-f9b4-4b32-bfa1-19635a4b30b8');
INSERT INTO folders (id, name) VALUES ('ad57f0bf-f9b4-4b32-bfa1-19635a4b30b8', 'new words (12.05)') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_ad57f0bf_f9b4_4b32_bfa1_19635a4b30b8 (id, spanish, english, enabled) VALUES
  ('89abe9f7-0ba3-4bdb-8fe0-2dbb20aa62a1', 'odio', 'hate', true),
  ('6a5a6a2f-d925-4d8d-9fc3-0154073db5de', 'no me gusta nada', 'I don''t like it at all', true),
  ('b6679fc0-4c7a-4772-a3bd-019ad06d9258', 'no me gusta', 'I don''t like it', true),
  ('c4dd84d0-9d01-4bc5-b1d1-d49a9cdccf5e', 'no me gusta mucho', 'I don''t like it very much', true),
  ('d4ac4e70-09e3-465c-ae5c-97e833891bee', 'me gusta', 'I like', true),
  ('5e16ecc2-17db-4721-8218-43ffff1f65c8', 'me gusta bastante', 'I like it quite a lot', true),
  ('e13dfbdd-8f11-4afb-b691-31dd49772f09', 'me gusta mucho', 'I like it a lot', true),
  ('e353f09e-4895-45a6-b5ca-5d0be011abe3', 'me encanta', 'I love', true)
ON CONFLICT (id) DO NOTHING;

-- ── actividades ──────────────────────────────────────────────
SELECT create_folder_table('d267d45c-ec57-4f36-867d-2ecbcb3864da');
INSERT INTO folders (id, name) VALUES ('d267d45c-ec57-4f36-867d-2ecbcb3864da', 'actividades') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_d267d45c_ec57_4f36_867d_2ecbcb3864da (id, spanish, english, enabled) VALUES
  ('578af59d-f11b-4c1c-9d59-4813e5817579', 'ir al gimnasio', 'go to the gym', true),
  ('db371fc8-9f2a-4244-a667-0f481c294520', 'volar', 'fly', true),
  ('5c47989a-81fd-4f01-b5ff-cd75e42371a6', 'viajar', 'travel', true),
  ('5254283e-bae1-4bdf-a3bb-bfd4a2e9891a', 'comer en un restaurante', 'eat at a restaurant', true),
  ('ae5e9990-8627-40f1-96ae-cf5db516ebf3', 'ir de compras', 'go shopping', true),
  ('c68a068c-4c46-467c-aa1d-c187caf2ee83', 'ir de camping', 'go camping', true),
  ('dcdca4d6-ea80-40fa-8666-f7114486ddcd', 'jugar al voleibol', 'play volleyball', true),
  ('188542f5-6841-4ccc-8771-ee4040940d55', 'jugar al pádel', 'play padel', true),
  ('883da162-3b70-42fa-a479-d370784deb5c', 'jugar al fútbol', 'play football', true),
  ('c939fa58-9f02-4c8f-8fd1-8eedb49158bb', 'ir al teatro', 'go to the theater', true),
  ('fd019f93-e26b-41d6-a8ca-905363049778', 'ir al cine', 'go to the movies', true),
  ('18492259-2d5e-4b06-83c7-3a43e8fff77d', 'esquiar', 'skiing', true),
  ('9fb8b5e5-12b9-49ca-98a9-32bc184240ff', 'ir al karaoke', 'go to karaoke', true),
  ('aa18984f-0963-4904-bb82-70b949720822', 'bailar', 'dancing', true),
  ('62dca59b-e065-433d-a9fa-9d52951616fd', 'ver netflix', 'watch netflix', true),
  ('10ea06e3-2a2a-430f-9375-cb074f7c85d3', 'pasear por la ciudad', 'stroll through the city', true),
  ('e4af2270-9dfc-472d-a582-5de3e8999ba8', 'salir de noche', 'going out at night', true),
  ('cc556f27-93af-4c1c-9ebe-eaee3655b15f', 'ir a la playa', 'go to the beach', true),
  ('7499e207-c4c6-463b-bfa6-e99a0858927f', 'hacer senderismo', 'hiking', true),
  ('85cb1dcd-0988-461f-94d3-13032601e06c', 'bailar en el club', 'dancing at the club', true),
  ('6234137f-411c-4b77-8752-afefdfe3bc4f', 'visitar museos', 'visit museums', true)
ON CONFLICT (id) DO NOTHING;

-- ── new words (07.05) ────────────────────────────────────────
SELECT create_folder_table('10bc1e98-0222-499e-9eaa-521978fadd12');
INSERT INTO folders (id, name) VALUES ('10bc1e98-0222-499e-9eaa-521978fadd12', 'new words (07.05)') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_10bc1e98_0222_499e_9eaa_521978fadd12 (id, spanish, english, enabled) VALUES
  ('7c1862b7-68bb-461d-b248-dabb6b8e2210', 'media hora', 'half an hour', true),
  ('8806b206-2980-4174-b2b2-9c78fc9f4691', 'cuarto', 'quarter', true),
  ('c4a2173d-767e-4230-9ee3-126e8834a3c9', 'son las doce del mediodía', 'It''s noon', true),
  ('b36d2696-d71b-4e67-8f3c-35288b64cf56', 'es la una de la tarde', 'It''s one o''clock in the afternoon', true),
  ('7d28d52a-567a-4956-9c9d-e102cf8a3064', 'todo el dia', 'all day', true),
  ('7b00839f-aaec-42fc-ba08-f595824571ff', 'requesón', 'cottage cheese', true),
  ('e16ef5f9-51b6-44e4-b5ca-93e0d037cd96', 'ajo', 'garlic', true),
  ('598d9e3c-21bc-4088-9dd0-06ee78b921a5', 'nuca', 'the back of the neck', true),
  ('1df3f289-2544-41e3-a49e-0ee84817c34a', 'comprendemos', 'understand', true),
  ('6ed2121d-6770-4b09-af62-3f5abcfa38c4', 'invierno', 'winter', true),
  ('cffe6d5c-3a6f-4741-8c8b-390da9356761', 'muy importante', 'very important', true),
  ('4d24216f-ee04-41bc-8984-53ccb1d82523', 'regla general', 'general rule', true),
  ('608b8c46-4806-4d2d-8c4f-83e40d5925ac', 'todos juntos', 'all together', true)
ON CONFLICT (id) DO NOTHING;

-- ── rutina ───────────────────────────────────────────────────
SELECT create_folder_table('9dcf11be-0b68-4819-b748-479ef70dca20');
INSERT INTO folders (id, name) VALUES ('9dcf11be-0b68-4819-b748-479ef70dca20', 'rutina') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_9dcf11be_0b68_4819_b748_479ef70dca20 (id, spanish, english, enabled) VALUES
  ('1bcf8488-2be6-4b7a-b25f-99ed91be5892', 'limpiar la casa', 'clean the house', true),
  ('ad9ce71e-ab7d-493d-af8b-bf2ad3f7242a', 'lavar la ropa', 'wash clothes', true),
  ('7894910c-00f7-4b91-a0cc-63c99fa4394f', 'lavar los platos', 'wash the dishes', true),
  ('5286b3a2-65be-4ddc-a1e8-13b6a1fed242', 'pasear al perro', 'walk the dog', true),
  ('f33d4d8b-4176-4517-8653-a7c9c9b92c54', 'navegar por Internet', 'browsing the Internet', true),
  ('832cdaa2-b0b4-49e5-a063-46ee5817d090', 'escuchar música', 'listen to music', true),
  ('f8df1837-2612-443d-bc45-03662b869845', 'comprar en el supermercado', 'buy at the supermarket', true),
  ('331e980a-8c7a-4abd-9cbb-67857707dc76', 'tomar el coche', 'take the car', true),
  ('9de746f7-4dc4-4cc5-9a9f-722cd22fc9a9', 'tomar el autobús', 'take the bus', true),
  ('60d20749-da45-48ba-84ff-203623643b1a', 'tomar el metro', 'take the subway', true),
  ('a34970ed-28c4-4879-acc0-c728a7720248', 'cenar', 'have dinner', true),
  ('6f3aad63-df9b-44ff-906b-8057091101e1', 'comer', 'have lunch', true),
  ('359288b5-2f2a-4e5e-acc3-635c402ee8fb', 'desayunar', 'have breakfast', true)
ON CONFLICT (id) DO NOTHING;

-- ── new words (05.04) ────────────────────────────────────────
SELECT create_folder_table('8e263609-354d-4ee9-a2f5-12383c27d1ca');
INSERT INTO folders (id, name) VALUES ('8e263609-354d-4ee9-a2f5-12383c27d1ca', 'new words (05.04)') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_8e263609_354d_4ee9_a2f5_12383c27d1ca (id, spanish, english, enabled) VALUES
  ('c3525826-5975-4e9a-8efd-4698eee6496b', 'noche', 'night', true),
  ('0f0ab472-7981-41a9-b9d0-5c6341b24a09', 'tarde', 'evening', true),
  ('74795b74-ddce-4ec4-82f2-d6340cc43196', 'mucho', 'a lot', true),
  ('384eabb4-9ad9-4294-b078-da7d3d3741e9', 'poco', 'little', true),
  ('80f968af-7f82-4d25-b4e4-b050556cd003', 'siempre', 'always', true),
  ('255d8de6-2c6c-4886-b288-2773d6c1fb54', 'ejercicio', 'exercise', true),
  ('806cc72d-6a2d-416c-830a-4c7f461b816b', 'cuándo', 'when', true),
  ('a852761b-81b9-49c0-96f1-e2d066c1f395', 'a veces', 'sometimes', true),
  ('a3bb752d-d205-49e7-9e48-a15a0fed1aa5', 'similar', 'similar', true),
  ('f4312dd0-2839-45dc-96e2-aca4605cf083', 'aceite', 'oil', true),
  ('310dab53-5ff0-49f5-9000-380150ff379c', 'olivas', 'olives', true),
  ('2abfd562-cd87-4340-9699-952de0c6c892', 'aceitunas', 'olives', true),
  ('c6f7c14b-f6c6-4b04-a287-9597a113534f', 'terraplén', 'embankment', true),
  ('bc80ba83-024e-4f11-8fad-d7b38613f903', 'gimnasia', 'gym', true),
  ('205c146c-6de8-48d0-a103-284798e6fc21', 'ciudad', 'city', true),
  ('f17df91f-21c5-452f-8c5c-6a3c62567fff', 'bosque', 'forest', true)
ON CONFLICT (id) DO NOTHING;

-- ── new words (30.04) ────────────────────────────────────────
SELECT create_folder_table('ba933e40-b672-42f8-a5e8-66a23047471c');
INSERT INTO folders (id, name) VALUES ('ba933e40-b672-42f8-a5e8-66a23047471c', 'new words (30.04)') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_ba933e40_b672_42f8_a5e8_66a23047471c (id, spanish, english, enabled) VALUES
  ('ccadca1e-7cf1-4b44-a642-ea25eee73702', 'próximo', 'next', true),
  ('b6931a8e-1340-4d37-b183-e3f5c01658a1', 'descansar', 'rest', true),
  ('6aea841a-417e-4c3d-b5fb-0462eff0431d', 'tiempo', 'time', true),
  ('1b027177-17f8-4c51-9399-06e0801a833e', 'belleza', 'beauty', true),
  ('2ab01db9-8b59-4c71-82e7-9af40588ce00', 'escuela', 'school', true),
  ('e1f53406-e14c-40ec-b3eb-f6bd62a50bc5', 'comisaría', 'police station', true),
  ('a0f1bee7-0b02-4d21-9efe-23328dc368cb', 'dedicarse', 'devote', true),
  ('d7040a40-ba6b-4376-b741-ed21023809f2', 'diseño', 'design', true),
  ('dc297edd-b731-4522-a332-a5144dff1632', 'diseñador', 'designer', true),
  ('c7782185-e491-4170-b2e1-69b2ab2b8e13', 'montaña', 'mountain', true),
  ('9650bfb6-06a7-467a-b243-143509e31b6a', 'playa', 'beach', true),
  ('522b9cf0-42f5-4217-b1e6-93715bb32032', 'centro comercial', 'mall', true),
  ('3058b1db-0c94-41e2-b456-f05284da9668', 'cine', 'cinema', true),
  ('0bc77019-c087-49b4-8b82-dc02f5aa2fe5', 'tele', 'tv', true),
  ('c3520e9a-25e5-4141-93a9-f04f8cf85cec', 'fotos', 'photos', true),
  ('fc218239-f2d4-44bc-8a6a-89b11802abde', 'bici', 'bike', true),
  ('f14a43f8-c468-464e-a3be-bcb74231e089', 'guitarra', 'guitar', true),
  ('46d582a7-c217-4332-91c8-3908273078b6', 'sol', 'sun', true),
  ('9452fda3-c20e-4694-983d-e86c0db25f6f', 'tenis', 'tennis', true)
ON CONFLICT (id) DO NOTHING;

-- ── tiempo libre (30.04) ─────────────────────────────────────
SELECT create_folder_table('d18b07bc-3405-4283-beeb-deb4f0c01a2b');
INSERT INTO folders (id, name) VALUES ('d18b07bc-3405-4283-beeb-deb4f0c01a2b', 'tiempo libre (30.04)') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_d18b07bc_3405_4283_beeb_deb4f0c01a2b (id, spanish, english, enabled) VALUES
  ('4a32f7e2-c9a8-4bef-aa01-d4f1e761e339', 'ir', 'go', true),
  ('656885c2-f6b1-4b12-b88e-7409044409a6', 'escribir', 'write', true),
  ('f5d39844-accd-4758-a16b-fdfb2854865d', 'ver', 'see', true),
  ('86867421-20dc-4fa0-bc11-a2acf848b12c', 'comer', 'eat', true),
  ('5f9b97e4-92be-46cc-802e-6ef681c9b897', 'hacer', 'do', true),
  ('fbe99f0d-bbf9-4b43-a547-c4398329c3fe', 'leer', 'read', true),
  ('b708163d-fcaf-46db-b203-1cf300f9ec9f', 'montar', 'ride', true),
  ('be98261e-1c2b-4e13-b50a-80aa5fee05b8', 'practicar', 'practice', true),
  ('fbc3fb49-38df-4e79-9b35-78df9bfa35ba', 'tocar', 'tap', true),
  ('bd66826a-693a-40f8-a02e-303e4e0c512c', 'estudiar', 'study', true),
  ('8b6c90a5-07cb-4235-b4e4-071559401bdd', 'tomar', 'take', true),
  ('6185e12c-fb3e-42d3-ab73-838e03eabf68', 'nadar', 'swim', true),
  ('7b196a19-4297-4ef8-8873-65c6e5987701', 'correr', 'run', true),
  ('2b64db0b-92b0-435a-ba53-a180adfba675', 'caminar', 'walk', true),
  ('08e16028-e2ac-45b9-b7fc-0c53f6046fc5', 'jugar', 'play', true)
ON CONFLICT (id) DO NOTHING;

-- ── new words (28.04) ────────────────────────────────────────
SELECT create_folder_table('031582b7-ae2b-48fb-a865-84d7c126047d');
INSERT INTO folders (id, name) VALUES ('031582b7-ae2b-48fb-a865-84d7c126047d', 'new words (28.04)') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_031582b7_ae2b_48fb_a865_84d7c126047d (id, spanish, english, enabled) VALUES
  ('3d4cc85c-4430-4594-8c4d-c7e7ff61eca3', 'la solución', 'solution', true),
  ('2469dc0c-1678-4f1b-8016-4a79aa7f074b', 'la canción', 'song', true),
  ('df23f079-be25-433d-ad20-85108012db0a', 'las televisiónes', 'televisions', true),
  ('777626d5-6980-477a-9a4b-e1405a189f89', 'las ventanas', 'windows', true),
  ('f96251a0-2ddb-424b-8686-a6e47c91bee2', 'el paraguas', 'umbrella', true),
  ('31ceff09-aaa7-4dbd-b3ed-fb6853b4d282', 'las tijeras', 'scissors', true),
  ('2d8580c3-e976-444e-843c-889b2f073555', 'las gafas', 'glasses', true),
  ('4e3b6e44-ebe1-4b95-b20f-7698b65ffdb5', 'el arból', 'tree', true),
  ('49e9cf8f-a31d-4448-a6a3-39004f44c0a8', 'botella', 'bottle', true),
  ('9640d735-9b58-4bf7-8e6b-4aee006aa607', 'esta', 'this', true),
  ('e3bbdd87-2016-418e-bf6e-e0eb70f39230', 'ahora', 'now', true),
  ('f1db1e65-364a-4c29-bbf7-98ef7ee02c28', 'claro', 'clear', true),
  ('2f54d15e-eac6-4803-9303-f849b2c0fd57', 'terminado', 'finish', true),
  ('14119b3a-ae57-4a4f-860f-4698697971e4', 'consonante', 'consonant', true),
  ('a8139157-2f88-4baf-832b-afd86772ff68', 'vocal', 'vowel', true),
  ('1c1221ca-698a-4c24-b472-ac7f43ce70e6', 'puerta', 'door', true),
  ('a4106ea4-c140-4fce-bf27-20a2afc7beb1', 'lengua', 'language', true),
  ('d53e8eae-30de-4b73-8053-8d7369016d65', 'todo', 'everything', true),
  ('e3415b6c-cfd7-49fd-97e1-9266f08d0550', 'todos', 'everyone', true)
ON CONFLICT (id) DO NOTHING;

-- ── gender exceptions ────────────────────────────────────────
SELECT create_folder_table('70154bb5-b690-48d0-8c7d-a881d9fdc439');
INSERT INTO folders (id, name) VALUES ('70154bb5-b690-48d0-8c7d-a881d9fdc439', 'gender exceptions') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_70154bb5_b690_48d0_8c7d_a881d9fdc439 (id, spanish, english, enabled) VALUES
  ('01c40f32-ad3f-4022-a5f9-e5c921cb9e9b', 'el aqua', 'water', true),
  ('2455c2fe-0b73-4f3d-8883-581c78bf992a', 'la estudiante', 'student (f)', true),
  ('200d1d61-02e7-42de-95ac-df852db4d9b6', 'el estudiante', 'student', true),
  ('f73e02d4-98df-4117-9e6b-a34bd4ab772e', 'la carne', 'meat', true),
  ('2843ef49-a0b6-4ad4-a930-60e80850bb1d', 'el coche', 'car', true),
  ('ffa8ebdf-a191-4775-a816-8e57d088b9a2', 'el cafe', 'coffee', true),
  ('09e23396-571b-41a4-b2d1-7cd39cc2bf96', 'la clase', 'class', true),
  ('48e8c079-43f3-4dec-935d-170ce60522f4', 'la moto', 'motorbike', true),
  ('34e7a879-1c20-4c0b-8b8d-063fa7c044f1', 'la foto', 'photo', true),
  ('dc762aba-f0de-49ee-a846-069fcd88b20d', 'la mano', 'hand', true),
  ('a63e102b-e0b4-4baf-a8c8-d3cbcaf0b0e2', 'el mapa', 'map', true),
  ('13abb8e9-c235-4eba-8617-2b5e529d7747', 'el idioma', 'language', true),
  ('eed2ab13-a1b1-4aa7-ba5c-f3180a634518', 'el día', 'day', true)
ON CONFLICT (id) DO NOTHING;

-- ── profeciones ──────────────────────────────────────────────
SELECT create_folder_table('08694a3a-7a89-40aa-a24f-9edc7724f22e');
INSERT INTO folders (id, name) VALUES ('08694a3a-7a89-40aa-a24f-9edc7724f22e', 'profeciones') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_08694a3a_7a89_40aa_a24f_9edc7724f22e (id, spanish, english, enabled) VALUES
  ('e99e37a5-cef7-459c-bace-2aeffe9cf5f5', 'la periodista', 'journalist (f)', true),
  ('268d9ea8-29f7-444b-85e9-db5d80887d87', 'la albañil', 'construction worker (f)', true),
  ('d7777170-ba77-4f27-8bec-5ae5e9a31d3e', 'la cantante', 'singer (f)', true),
  ('ed32a202-804c-41f6-8289-4abe6420b50b', 'cartero', 'mail carrier', true),
  ('fdf51863-5105-4667-8ce4-ec48b72f0f0a', 'el periodista', 'journalist', true),
  ('e3eebaad-936c-499b-b277-b7a0ecabe93b', 'el albañil', 'construction worker', true),
  ('2a2d69b8-545f-496f-bcef-bf6d23537858', 'conductor', 'driver', true),
  ('e024a6b7-dc80-496b-b898-62f388d14a6b', 'el cantante', 'singer', true),
  ('dea71246-0695-4317-995b-78a198aadcfa', 'fontanero', 'plumber', true),
  ('bb642e9c-cc18-4adc-b879-8e3c0fd4e954', 'dependiente', 'shop assistant', true),
  ('72943459-8d4a-4ba1-bf9b-d7a20aac2dc0', 'pintor', 'painter', false),
  ('e9f44608-dfb4-4ff3-945b-3a7268961adf', 'profesor', 'teacher', false),
  ('b410224f-ffff-4388-9e2b-faf4df3abcac', 'la dentista', 'dentist (f)', false),
  ('1465a796-9420-4cc4-b266-e5485ea24801', 'el dentista', 'dentist', false),
  ('c58753ce-e010-4c5c-a943-62f3830baf02', 'la taxista', 'taxi driver (f)', false),
  ('9bfc6629-9950-44cb-848e-104bab9fc0ba', 'el taxista', 'taxi driver', false),
  ('03a29150-7a6a-4457-9aae-29225fe1ccc6', 'la policía', 'police officer (f)', false),
  ('74347037-aa65-4ddb-8290-2ff209b5a845', 'el policía', 'police officer', false),
  ('9188fe24-6b83-4f20-822e-1f115b9b2765', 'camarero', 'waiter', false),
  ('5488ee2b-018d-4e22-8d17-db273f506416', 'veterinario', 'veterinarian', false),
  ('45880101-b4ff-4f89-ba6e-fd112e37547c', 'ingeniero', 'engineer', false),
  ('f0c9f7d4-9edb-4edc-b4a7-9c8c1716f905', 'cocinero', 'chef', false),
  ('8a1f2345-c70f-4630-9f8e-d9d924f36d40', 'abogado', 'lawyer', false),
  ('1fb2e089-0a8b-44b3-9f83-347bda58709a', 'enfermero', 'nurse', false),
  ('2a34d6b4-ebbe-40b9-afb8-ca2246a852ac', 'médico', 'doctor', false)
ON CONFLICT (id) DO NOTHING;

-- ── la familia ───────────────────────────────────────────────
SELECT create_folder_table('0dcde6d3-3c13-4d2a-aaee-8a969f1a5b5b');
INSERT INTO folders (id, name) VALUES ('0dcde6d3-3c13-4d2a-aaee-8a969f1a5b5b', 'la familia') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_0dcde6d3_3c13_4d2a_aaee_8a969f1a5b5b (id, spanish, english, enabled) VALUES
  ('173cae58-a95f-4af1-8c92-2ef560b72b45', 'pareja', 'partner', true),
  ('258b5acf-d76e-4c14-8b15-4f44a4b6dce3', 'primo', 'cousin', true),
  ('1fdf8129-071a-4d06-b275-1ac51c34620f', 'sobrino', 'nephew', true),
  ('1f792639-f69d-4865-af39-cc152f88324b', 'tío', 'uncle', true),
  ('22cca5af-3883-49c2-9f5b-d5a8c5ea6389', 'nieto', 'grandson', true),
  ('f932d554-fd08-4828-abae-4d965b05429e', 'abuelo', 'grandfather', true),
  ('71bd5309-4709-4f81-92d7-739c65b8cb26', 'hermano', 'brother', true),
  ('f3708a8e-f7a8-4c70-839b-324d59e13570', 'madre', 'mother', true),
  ('f3e3e67a-36da-4d95-95e8-11a8a896fd7a', 'padre', 'father', true),
  ('4208758b-9428-44a5-bca0-af61e1d9797e', 'hijo', 'son', true),
  ('5abb1573-b7e6-4d33-ab28-f8fa10ec1ffe', 'novio', 'boyfriend', true),
  ('2f607199-396d-4292-b272-ea07692e9685', 'mujer', 'wife', true),
  ('e1dca4d8-f36b-41c3-86cb-721d66d02218', 'esposo', 'husband (formal)', true),
  ('f19def7e-dc7f-42ff-bffd-e7ee7787620a', 'marido', 'husband', true),
  ('1b8f0970-32a0-4077-9f3c-8e32487b453b', 'soltero', 'single', true),
  ('e854ea00-164e-47bc-8d05-872bdbb5a430', 'casado', 'married', true)
ON CONFLICT (id) DO NOTHING;

-- ── números (>20) ────────────────────────────────────────────
SELECT create_folder_table('13fa7a7b-2fe2-46af-bbea-8746f6bc2594');
INSERT INTO folders (id, name) VALUES ('13fa7a7b-2fe2-46af-bbea-8746f6bc2594', 'números (>20)') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_13fa7a7b_2fe2_46af_bbea_8746f6bc2594 (id, spanish, english, enabled) VALUES
  ('63b5ac4d-d0e6-41bd-98be-89f6f8495552', 'ciento uno', 'one hundred one', true),
  ('796a5b4d-cf2a-482d-8124-568eedf6d70f', 'cien', 'hundred', true),
  ('7ec921ac-a150-4dfc-9432-666e7b85ac19', 'noventa', 'ninety', true),
  ('a25f5abc-be07-4554-8434-0f8d36df13af', 'ochenta', 'eighty', true),
  ('752b26e6-4312-4a99-a7a9-3de043b3c4f2', 'setenta', 'seventy', true),
  ('01da99fc-7812-4c53-8561-48304fb3fbf8', 'sesenta', 'sixty', true),
  ('55411617-6176-4ce4-a9e1-a030a3f69aff', 'cincuenta', 'fifty', true),
  ('a2372207-4021-41c1-b78d-31791d8b067a', 'cuarenta', 'forty', true),
  ('7d8ccb84-44e8-4807-9f73-93903ce061c6', 'treinta', 'thirty', true),
  ('b14d6ec3-f334-4470-a64f-531025458476', 'veintiuno', 'twenty one', true)
ON CONFLICT (id) DO NOTHING;

-- ── números ──────────────────────────────────────────────────
SELECT create_folder_table('3f895972-1d4c-4950-939f-40eb4ada03a8');
INSERT INTO folders (id, name) VALUES ('3f895972-1d4c-4950-939f-40eb4ada03a8', 'números') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_3f895972_1d4c_4950_939f_40eb4ada03a8 (id, spanish, english, enabled) VALUES
  ('d98bdf90-2e9b-4895-9a01-95124e31909a', 'cero', 'zero', true),
  ('d9f8c0ed-a7ea-4d40-bc97-1f4ab819a45c', 'viente', 'twenty', true),
  ('5d3dc418-c7f7-4b6a-854a-491bceb692c1', 'diecinueve', 'nineteen', true),
  ('4ce48577-c818-4a52-a2dd-1f3fa6a355eb', 'dieciocho', 'eighteen', true),
  ('3bc182d9-5727-4485-b5b8-d557776b35d3', 'diecisiete', 'seventeen', true),
  ('eccd7692-ab16-4779-bef0-61707fe9b6d1', 'dieciséis', 'sixteen', true),
  ('65e3b4ff-ae56-43b7-9659-498afab2578b', 'quince', 'fifteen', true),
  ('bad216a8-01c3-47a4-aca9-12df8d71ae55', 'catorce', 'fourteen', true),
  ('8fd7f69b-8708-482e-8051-a8a1c1138ac0', 'trese', 'thirteen', true),
  ('212b67f5-ec54-47ea-ac0a-6f56f341422b', 'doce', 'twelve', true),
  ('6e168a5e-9c01-47c2-8afc-785116591149', 'once', 'eleven', true),
  ('01ad0f81-7b20-4279-8949-85b879e9d96b', 'diez', 'ten', true),
  ('7c6aac39-75aa-430b-9756-8c64f176771b', 'nueve', 'nine', true),
  ('855abfc4-0d39-4bea-a61d-db7fda0c36d9', 'ocho', 'eight', true),
  ('c09cfebf-7440-4c3d-ade8-64584a6717df', 'siete', 'seven', true),
  ('59269b02-4528-4d66-84a4-fab78b159a94', 'seis', 'six', true),
  ('f395310b-605f-4ad7-99b8-29767abda5d9', 'cinco', 'five', true),
  ('9417bd67-0a6f-4741-9bd6-7f5b2fb6df05', 'cuatro', 'four', true),
  ('00f9eac1-82aa-4cff-9c19-63beed6e067f', 'tres', 'three', true),
  ('237752cb-b301-4c04-9d75-e43e5d1308c8', 'dos', 'two', true),
  ('d0797a5a-3547-4c9e-894f-cce988cda968', 'uno', 'one', true)
ON CONFLICT (id) DO NOTHING;

-- ── meses ────────────────────────────────────────────────────
SELECT create_folder_table('basics-folder');
INSERT INTO folders (id, name) VALUES ('basics-folder', 'meses') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_basics_folder (id, spanish, english, enabled) VALUES
  ('6a177e54-e569-4576-ad38-5fb740a86efe', 'diciembre', 'december', true),
  ('d3393442-01ee-4569-b5ec-ee03f9a2fafc', 'noviembre', 'november', true),
  ('3b9235fd-83e7-4d41-addd-b3f26a96ffa0', 'octubre', 'october', true),
  ('35f9f1d1-f6b9-47be-9745-6f3597ca3fb8', 'septiembre', 'september', true),
  ('ec099501-c5c6-4f3f-9660-e720508ef537', 'agosto', 'august', true),
  ('eb8d757c-7bc7-4f99-bcc3-deafc483f434', 'julio', 'july', true),
  ('c789851f-4ec6-462e-9ba0-4a1bb752204c', 'junio', 'june', true),
  ('6be0ebf6-180a-4deb-aa32-b5574eef4a88', 'mayo', 'may', true),
  ('3373799c-81e6-42fe-a273-4a8ba47da026', 'abril', 'april', true),
  ('casa-house', 'enero', 'january', true),
  ('agua-water', 'febrero', 'february', true),
  ('libro-book', 'marzo', 'march', true)
ON CONFLICT (id) DO NOTHING;

-- ── días de la semana ────────────────────────────────────────
SELECT create_folder_table('travel-folder');
INSERT INTO folders (id, name) VALUES ('travel-folder', 'días de la semana') ON CONFLICT (id) DO NOTHING;
INSERT INTO words_travel_folder (id, spanish, english, enabled) VALUES
  ('tren-train', 'tren', 'train', true),
  ('hotel-hotel', 'hotel', 'hotel', true)
ON CONFLICT (id) DO NOTHING;
