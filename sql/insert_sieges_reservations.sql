-- =============================================
-- SCRIPT D'INSERTION DES SIÈGES ET RÉSERVATIONS
-- Pour les avions de la compagnie aérienne malgache
-- =============================================

-- =============================================
-- 1. SIÈGES POUR AVION 1 - Boeing 737-800 (5R-MBA)
-- Capacité: 189 places
-- Configuration: 18 Affaires (rangées 1-3) + 171 Économique (rangées 4-32)
-- =============================================
-- Classe Affaires: 18 sièges
INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(1, '1A', 'Affaires'), (1, '1B', 'Affaires'), (1, '1C', 'Affaires'), (1, '1D', 'Affaires'), (1, '1E', 'Affaires'), (1, '1F', 'Affaires'),
(1, '2A', 'Affaires'), (1, '2B', 'Affaires'), (1, '2C', 'Affaires'), (1, '2D', 'Affaires'), (1, '2E', 'Affaires'), (1, '2F', 'Affaires'),
(1, '3A', 'Affaires'), (1, '3B', 'Affaires'), (1, '3C', 'Affaires'), (1, '3D', 'Affaires'), (1, '3E', 'Affaires'), (1, '3F', 'Affaires');

-- Classe Économique: 171 sièges
INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(1, '4A', 'Économique'), (1, '4B', 'Économique'), (1, '4C', 'Économique'), (1, '4D', 'Économique'), (1, '4E', 'Économique'), (1, '4F', 'Économique'),
(1, '5A', 'Économique'), (1, '5B', 'Économique'), (1, '5C', 'Économique'), (1, '5D', 'Économique'), (1, '5E', 'Économique'), (1, '5F', 'Économique'),
(1, '6A', 'Économique'), (1, '6B', 'Économique'), (1, '6C', 'Économique'), (1, '6D', 'Économique'), (1, '6E', 'Économique'), (1, '6F', 'Économique'),
(1, '7A', 'Économique'), (1, '7B', 'Économique'), (1, '7C', 'Économique'), (1, '7D', 'Économique'), (1, '7E', 'Économique'), (1, '7F', 'Économique'),
(1, '8A', 'Économique'), (1, '8B', 'Économique'), (1, '8C', 'Économique'), (1, '8D', 'Économique'), (1, '8E', 'Économique'), (1, '8F', 'Économique'),
(1, '9A', 'Économique'), (1, '9B', 'Économique'), (1, '9C', 'Économique'), (1, '9D', 'Économique'), (1, '9E', 'Économique'), (1, '9F', 'Économique'),
(1, '10A', 'Économique'), (1, '10B', 'Économique'), (1, '10C', 'Économique'), (1, '10D', 'Économique'), (1, '10E', 'Économique'), (1, '10F', 'Économique'),
(1, '11A', 'Économique'), (1, '11B', 'Économique'), (1, '11C', 'Économique'), (1, '11D', 'Économique'), (1, '11E', 'Économique'), (1, '11F', 'Économique'),
(1, '12A', 'Économique'), (1, '12B', 'Économique'), (1, '12C', 'Économique'), (1, '12D', 'Économique'), (1, '12E', 'Économique'), (1, '12F', 'Économique'),
(1, '13A', 'Économique'), (1, '13B', 'Économique'), (1, '13C', 'Économique'), (1, '13D', 'Économique'), (1, '13E', 'Économique'), (1, '13F', 'Économique'),
(1, '14A', 'Économique'), (1, '14B', 'Économique'), (1, '14C', 'Économique'), (1, '14D', 'Économique'), (1, '14E', 'Économique'), (1, '14F', 'Économique'),
(1, '15A', 'Économique'), (1, '15B', 'Économique'), (1, '15C', 'Économique'), (1, '15D', 'Économique'), (1, '15E', 'Économique'), (1, '15F', 'Économique'),
(1, '16A', 'Économique'), (1, '16B', 'Économique'), (1, '16C', 'Économique'), (1, '16D', 'Économique'), (1, '16E', 'Économique'), (1, '16F', 'Économique'),
(1, '17A', 'Économique'), (1, '17B', 'Économique'), (1, '17C', 'Économique'), (1, '17D', 'Économique'), (1, '17E', 'Économique'), (1, '17F', 'Économique'),
(1, '18A', 'Économique'), (1, '18B', 'Économique'), (1, '18C', 'Économique'), (1, '18D', 'Économique'), (1, '18E', 'Économique'), (1, '18F', 'Économique'),
(1, '19A', 'Économique'), (1, '19B', 'Économique'), (1, '19C', 'Économique'), (1, '19D', 'Économique'), (1, '19E', 'Économique'), (1, '19F', 'Économique'),
(1, '20A', 'Économique'), (1, '20B', 'Économique'), (1, '20C', 'Économique'), (1, '20D', 'Économique'), (1, '20E', 'Économique'), (1, '20F', 'Économique'),
(1, '21A', 'Économique'), (1, '21B', 'Économique'), (1, '21C', 'Économique'), (1, '21D', 'Économique'), (1, '21E', 'Économique'), (1, '21F', 'Économique'),
(1, '22A', 'Économique'), (1, '22B', 'Économique'), (1, '22C', 'Économique'), (1, '22D', 'Économique'), (1, '22E', 'Économique'), (1, '22F', 'Économique'),
(1, '23A', 'Économique'), (1, '23B', 'Économique'), (1, '23C', 'Économique'), (1, '23D', 'Économique'), (1, '23E', 'Économique'), (1, '23F', 'Économique'),
(1, '24A', 'Économique'), (1, '24B', 'Économique'), (1, '24C', 'Économique'), (1, '24D', 'Économique'), (1, '24E', 'Économique'), (1, '24F', 'Économique'),
(1, '25A', 'Économique'), (1, '25B', 'Économique'), (1, '25C', 'Économique'), (1, '25D', 'Économique'), (1, '25E', 'Économique'), (1, '25F', 'Économique'),
(1, '26A', 'Économique'), (1, '26B', 'Économique'), (1, '26C', 'Économique'), (1, '26D', 'Économique'), (1, '26E', 'Économique'), (1, '26F', 'Économique'),
(1, '27A', 'Économique'), (1, '27B', 'Économique'), (1, '27C', 'Économique'), (1, '27D', 'Économique'), (1, '27E', 'Économique'), (1, '27F', 'Économique'),
(1, '28A', 'Économique'), (1, '28B', 'Économique'), (1, '28C', 'Économique'), (1, '28D', 'Économique'), (1, '28E', 'Économique'), (1, '28F', 'Économique'),
(1, '29A', 'Économique'), (1, '29B', 'Économique'), (1, '29C', 'Économique'), (1, '29D', 'Économique'), (1, '29E', 'Économique'), (1, '29F', 'Économique'),
(1, '30A', 'Économique'), (1, '30B', 'Économique'), (1, '30C', 'Économique'), (1, '30D', 'Économique'), (1, '30E', 'Économique'), (1, '30F', 'Économique'),
(1, '31A', 'Économique'), (1, '31B', 'Économique'), (1, '31C', 'Économique'), (1, '31D', 'Économique'), (1, '31E', 'Économique'), (1, '31F', 'Économique'),
(1, '32A', 'Économique'), (1, '32B', 'Économique'), (1, '32C', 'Économique');

-- =============================================
-- 2. SIÈGES POUR AVION 2 - Airbus A320 (5R-MBB)
-- Capacité: 180 places
-- Configuration: 24 Affaires (rangées 1-4) + 156 Économique (rangées 5-30)
-- =============================================
-- Classe Affaires: 24 sièges
INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(2, '1A', 'Affaires'), (2, '1B', 'Affaires'), (2, '1C', 'Affaires'), (2, '1D', 'Affaires'), (2, '1E', 'Affaires'), (2, '1F', 'Affaires'),
(2, '2A', 'Affaires'), (2, '2B', 'Affaires'), (2, '2C', 'Affaires'), (2, '2D', 'Affaires'), (2, '2E', 'Affaires'), (2, '2F', 'Affaires'),
(2, '3A', 'Affaires'), (2, '3B', 'Affaires'), (2, '3C', 'Affaires'), (2, '3D', 'Affaires'), (2, '3E', 'Affaires'), (2, '3F', 'Affaires'),
(2, '4A', 'Affaires'), (2, '4B', 'Affaires'), (2, '4C', 'Affaires'), (2, '4D', 'Affaires'), (2, '4E', 'Affaires'), (2, '4F', 'Affaires');

-- Classe Économique: 156 sièges
INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(2, '5A', 'Économique'), (2, '5B', 'Économique'), (2, '5C', 'Économique'), (2, '5D', 'Économique'), (2, '5E', 'Économique'), (2, '5F', 'Économique'),
(2, '6A', 'Économique'), (2, '6B', 'Économique'), (2, '6C', 'Économique'), (2, '6D', 'Économique'), (2, '6E', 'Économique'), (2, '6F', 'Économique'),
(2, '7A', 'Économique'), (2, '7B', 'Économique'), (2, '7C', 'Économique'), (2, '7D', 'Économique'), (2, '7E', 'Économique'), (2, '7F', 'Économique'),
(2, '8A', 'Économique'), (2, '8B', 'Économique'), (2, '8C', 'Économique'), (2, '8D', 'Économique'), (2, '8E', 'Économique'), (2, '8F', 'Économique'),
(2, '9A', 'Économique'), (2, '9B', 'Économique'), (2, '9C', 'Économique'), (2, '9D', 'Économique'), (2, '9E', 'Économique'), (2, '9F', 'Économique'),
(2, '10A', 'Économique'), (2, '10B', 'Économique'), (2, '10C', 'Économique'), (2, '10D', 'Économique'), (2, '10E', 'Économique'), (2, '10F', 'Économique'),
(2, '11A', 'Économique'), (2, '11B', 'Économique'), (2, '11C', 'Économique'), (2, '11D', 'Économique'), (2, '11E', 'Économique'), (2, '11F', 'Économique'),
(2, '12A', 'Économique'), (2, '12B', 'Économique'), (2, '12C', 'Économique'), (2, '12D', 'Économique'), (2, '12E', 'Économique'), (2, '12F', 'Économique'),
(2, '13A', 'Économique'), (2, '13B', 'Économique'), (2, '13C', 'Économique'), (2, '13D', 'Économique'), (2, '13E', 'Économique'), (2, '13F', 'Économique'),
(2, '14A', 'Économique'), (2, '14B', 'Économique'), (2, '14C', 'Économique'), (2, '14D', 'Économique'), (2, '14E', 'Économique'), (2, '14F', 'Économique'),
(2, '15A', 'Économique'), (2, '15B', 'Économique'), (2, '15C', 'Économique'), (2, '15D', 'Économique'), (2, '15E', 'Économique'), (2, '15F', 'Économique'),
(2, '16A', 'Économique'), (2, '16B', 'Économique'), (2, '16C', 'Économique'), (2, '16D', 'Économique'), (2, '16E', 'Économique'), (2, '16F', 'Économique'),
(2, '17A', 'Économique'), (2, '17B', 'Économique'), (2, '17C', 'Économique'), (2, '17D', 'Économique'), (2, '17E', 'Économique'), (2, '17F', 'Économique'),
(2, '18A', 'Économique'), (2, '18B', 'Économique'), (2, '18C', 'Économique'), (2, '18D', 'Économique'), (2, '18E', 'Économique'), (2, '18F', 'Économique'),
(2, '19A', 'Économique'), (2, '19B', 'Économique'), (2, '19C', 'Économique'), (2, '19D', 'Économique'), (2, '19E', 'Économique'), (2, '19F', 'Économique'),
(2, '20A', 'Économique'), (2, '20B', 'Économique'), (2, '20C', 'Économique'), (2, '20D', 'Économique'), (2, '20E', 'Économique'), (2, '20F', 'Économique'),
(2, '21A', 'Économique'), (2, '21B', 'Économique'), (2, '21C', 'Économique'), (2, '21D', 'Économique'), (2, '21E', 'Économique'), (2, '21F', 'Économique'),
(2, '22A', 'Économique'), (2, '22B', 'Économique'), (2, '22C', 'Économique'), (2, '22D', 'Économique'), (2, '22E', 'Économique'), (2, '22F', 'Économique'),
(2, '23A', 'Économique'), (2, '23B', 'Économique'), (2, '23C', 'Économique'), (2, '23D', 'Économique'), (2, '23E', 'Économique'), (2, '23F', 'Économique'),
(2, '24A', 'Économique'), (2, '24B', 'Économique'), (2, '24C', 'Économique'), (2, '24D', 'Économique'), (2, '24E', 'Économique'), (2, '24F', 'Économique'),
(2, '25A', 'Économique'), (2, '25B', 'Économique'), (2, '25C', 'Économique'), (2, '25D', 'Économique'), (2, '25E', 'Économique'), (2, '25F', 'Économique'),
(2, '26A', 'Économique'), (2, '26B', 'Économique'), (2, '26C', 'Économique'), (2, '26D', 'Économique'), (2, '26E', 'Économique'), (2, '26F', 'Économique'),
(2, '27A', 'Économique'), (2, '27B', 'Économique'), (2, '27C', 'Économique'), (2, '27D', 'Économique'), (2, '27E', 'Économique'), (2, '27F', 'Économique'),
(2, '28A', 'Économique'), (2, '28B', 'Économique'), (2, '28C', 'Économique'), (2, '28D', 'Économique'), (2, '28E', 'Économique'), (2, '28F', 'Économique'),
(2, '29A', 'Économique'), (2, '29B', 'Économique'), (2, '29C', 'Économique'), (2, '29D', 'Économique'), (2, '29E', 'Économique'), (2, '29F', 'Économique'),
(2, '30A', 'Économique'), (2, '30B', 'Économique'), (2, '30C', 'Économique'), (2, '30D', 'Économique'), (2, '30E', 'Économique'), (2, '30F', 'Économique');

-- =============================================
-- 3. SIÈGES POUR AVION 3 - ATR 72-600 (5R-MBC)
-- Capacité: 72 places
-- Configuration: 8 Affaires (rangées 1-2) + 64 Économique (rangées 3-18)
-- =============================================
-- Classe Affaires: 8 sièges
INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(3, '1A', 'Affaires'), (3, '1B', 'Affaires'), (3, '1C', 'Affaires'), (3, '1D', 'Affaires'),
(3, '2A', 'Affaires'), (3, '2B', 'Affaires'), (3, '2C', 'Affaires'), (3, '2D', 'Affaires');

-- Classe Économique: 64 sièges
INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(3, '3A', 'Économique'), (3, '3B', 'Économique'), (3, '3C', 'Économique'), (3, '3D', 'Économique'),
(3, '4A', 'Économique'), (3, '4B', 'Économique'), (3, '4C', 'Économique'), (3, '4D', 'Économique'),
(3, '5A', 'Économique'), (3, '5B', 'Économique'), (3, '5C', 'Économique'), (3, '5D', 'Économique'),
(3, '6A', 'Économique'), (3, '6B', 'Économique'), (3, '6C', 'Économique'), (3, '6D', 'Économique'),
(3, '7A', 'Économique'), (3, '7B', 'Économique'), (3, '7C', 'Économique'), (3, '7D', 'Économique'),
(3, '8A', 'Économique'), (3, '8B', 'Économique'), (3, '8C', 'Économique'), (3, '8D', 'Économique'),
(3, '9A', 'Économique'), (3, '9B', 'Économique'), (3, '9C', 'Économique'), (3, '9D', 'Économique'),
(3, '10A', 'Économique'), (3, '10B', 'Économique'), (3, '10C', 'Économique'), (3, '10D', 'Économique'),
(3, '11A', 'Économique'), (3, '11B', 'Économique'), (3, '11C', 'Économique'), (3, '11D', 'Économique'),
(3, '12A', 'Économique'), (3, '12B', 'Économique'), (3, '12C', 'Économique'), (3, '12D', 'Économique'),
(3, '13A', 'Économique'), (3, '13B', 'Économique'), (3, '13C', 'Économique'), (3, '13D', 'Économique'),
(3, '14A', 'Économique'), (3, '14B', 'Économique'), (3, '14C', 'Économique'), (3, '14D', 'Économique'),
(3, '15A', 'Économique'), (3, '15B', 'Économique'), (3, '15C', 'Économique'), (3, '15D', 'Économique'),
(3, '16A', 'Économique'), (3, '16B', 'Économique'), (3, '16C', 'Économique'), (3, '16D', 'Économique'),
(3, '17A', 'Économique'), (3, '17B', 'Économique'), (3, '17C', 'Économique'), (3, '17D', 'Économique'),
(3, '18A', 'Économique'), (3, '18B', 'Économique'), (3, '18C', 'Économique'), (3, '18D', 'Économique');

-- =============================================
-- 4. SIÈGES POUR AVION 4 - Embraer E190 (5R-MBD)
-- Capacité: 124 places
-- Configuration: 12 Affaires (rangées 1-3) + 112 Économique (rangées 4-31)
-- =============================================
-- Classe Affaires: 12 sièges
INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(4, '1A', 'Affaires'), (4, '1B', 'Affaires'), (4, '1C', 'Affaires'), (4, '1D', 'Affaires'),
(4, '2A', 'Affaires'), (4, '2B', 'Affaires'), (4, '2C', 'Affaires'), (4, '2D', 'Affaires'),
(4, '3A', 'Affaires'), (4, '3B', 'Affaires'), (4, '3C', 'Affaires'), (4, '3D', 'Affaires');

-- Classe Économique: 112 sièges
INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(4, '4A', 'Économique'), (4, '4B', 'Économique'), (4, '4C', 'Économique'), (4, '4D', 'Économique'),
(4, '5A', 'Économique'), (4, '5B', 'Économique'), (4, '5C', 'Économique'), (4, '5D', 'Économique'),
(4, '6A', 'Économique'), (4, '6B', 'Économique'), (4, '6C', 'Économique'), (4, '6D', 'Économique'),
(4, '7A', 'Économique'), (4, '7B', 'Économique'), (4, '7C', 'Économique'), (4, '7D', 'Économique'),
(4, '8A', 'Économique'), (4, '8B', 'Économique'), (4, '8C', 'Économique'), (4, '8D', 'Économique'),
(4, '9A', 'Économique'), (4, '9B', 'Économique'), (4, '9C', 'Économique'), (4, '9D', 'Économique'),
(4, '10A', 'Économique'), (4, '10B', 'Économique'), (4, '10C', 'Économique'), (4, '10D', 'Économique'),
(4, '11A', 'Économique'), (4, '11B', 'Économique'), (4, '11C', 'Économique'), (4, '11D', 'Économique'),
(4, '12A', 'Économique'), (4, '12B', 'Économique'), (4, '12C', 'Économique'), (4, '12D', 'Économique'),
(4, '13A', 'Économique'), (4, '13B', 'Économique'), (4, '13C', 'Économique'), (4, '13D', 'Économique'),
(4, '14A', 'Économique'), (4, '14B', 'Économique'), (4, '14C', 'Économique'), (4, '14D', 'Économique'),
(4, '15A', 'Économique'), (4, '15B', 'Économique'), (4, '15C', 'Économique'), (4, '15D', 'Économique'),
(4, '16A', 'Économique'), (4, '16B', 'Économique'), (4, '16C', 'Économique'), (4, '16D', 'Économique'),
(4, '17A', 'Économique'), (4, '17B', 'Économique'), (4, '17C', 'Économique'), (4, '17D', 'Économique'),
(4, '18A', 'Économique'), (4, '18B', 'Économique'), (4, '18C', 'Économique'), (4, '18D', 'Économique'),
(4, '19A', 'Économique'), (4, '19B', 'Économique'), (4, '19C', 'Économique'), (4, '19D', 'Économique'),
(4, '20A', 'Économique'), (4, '20B', 'Économique'), (4, '20C', 'Économique'), (4, '20D', 'Économique'),
(4, '21A', 'Économique'), (4, '21B', 'Économique'), (4, '21C', 'Économique'), (4, '21D', 'Économique'),
(4, '22A', 'Économique'), (4, '22B', 'Économique'), (4, '22C', 'Économique'), (4, '22D', 'Économique'),
(4, '23A', 'Économique'), (4, '23B', 'Économique'), (4, '23C', 'Économique'), (4, '23D', 'Économique'),
(4, '24A', 'Économique'), (4, '24B', 'Économique'), (4, '24C', 'Économique'), (4, '24D', 'Économique'),
(4, '25A', 'Économique'), (4, '25B', 'Économique'), (4, '25C', 'Économique'), (4, '25D', 'Économique'),
(4, '26A', 'Économique'), (4, '26B', 'Économique'), (4, '26C', 'Économique'), (4, '26D', 'Économique'),
(4, '27A', 'Économique'), (4, '27B', 'Économique'), (4, '27C', 'Économique'), (4, '27D', 'Économique'),
(4, '28A', 'Économique'), (4, '28B', 'Économique'), (4, '28C', 'Économique'), (4, '28D', 'Économique'),
(4, '29A', 'Économique'), (4, '29B', 'Économique'), (4, '29C', 'Économique'), (4, '29D', 'Économique'),
(4, '30A', 'Économique'), (4, '30B', 'Économique'), (4, '30C', 'Économique'), (4, '30D', 'Économique'),
(4, '31A', 'Économique'), (4, '31B', 'Économique'), (4, '31C', 'Économique'), (4, '31D', 'Économique');

-- =============================================
-- 5. SIÈGES POUR AVION 5 - Boeing 777-200ER (5R-MBE)
-- Capacité: 314 places
-- Configuration: 42 Affaires (rangées 1-7) + 272 Économique (rangées 8-52 + 2 rangée 53)
-- =============================================
-- Classe Affaires: 42 sièges
INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(5, '1A', 'Affaires'), (5, '1B', 'Affaires'), (5, '1C', 'Affaires'), (5, '1D', 'Affaires'), (5, '1E', 'Affaires'), (5, '1F', 'Affaires'),
(5, '2A', 'Affaires'), (5, '2B', 'Affaires'), (5, '2C', 'Affaires'), (5, '2D', 'Affaires'), (5, '2E', 'Affaires'), (5, '2F', 'Affaires'),
(5, '3A', 'Affaires'), (5, '3B', 'Affaires'), (5, '3C', 'Affaires'), (5, '3D', 'Affaires'), (5, '3E', 'Affaires'), (5, '3F', 'Affaires'),
(5, '4A', 'Affaires'), (5, '4B', 'Affaires'), (5, '4C', 'Affaires'), (5, '4D', 'Affaires'), (5, '4E', 'Affaires'), (5, '4F', 'Affaires'),
(5, '5A', 'Affaires'), (5, '5B', 'Affaires'), (5, '5C', 'Affaires'), (5, '5D', 'Affaires'), (5, '5E', 'Affaires'), (5, '5F', 'Affaires'),
(5, '6A', 'Affaires'), (5, '6B', 'Affaires'), (5, '6C', 'Affaires'), (5, '6D', 'Affaires'), (5, '6E', 'Affaires'), (5, '6F', 'Affaires'),
(5, '7A', 'Affaires'), (5, '7B', 'Affaires'), (5, '7C', 'Affaires'), (5, '7D', 'Affaires'), (5, '7E', 'Affaires'), (5, '7F', 'Affaires');

-- Classe Économique: 272 sièges (45 rangées complètes + 2 sièges rangée 53)
INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(5, '8A', 'Économique'), (5, '8B', 'Économique'), (5, '8C', 'Économique'), (5, '8D', 'Économique'), (5, '8E', 'Économique'), (5, '8F', 'Économique'),
(5, '9A', 'Économique'), (5, '9B', 'Économique'), (5, '9C', 'Économique'), (5, '9D', 'Économique'), (5, '9E', 'Économique'), (5, '9F', 'Économique'),
(5, '10A', 'Économique'), (5, '10B', 'Économique'), (5, '10C', 'Économique'), (5, '10D', 'Économique'), (5, '10E', 'Économique'), (5, '10F', 'Économique'),
(5, '11A', 'Économique'), (5, '11B', 'Économique'), (5, '11C', 'Économique'), (5, '11D', 'Économique'), (5, '11E', 'Économique'), (5, '11F', 'Économique'),
(5, '12A', 'Économique'), (5, '12B', 'Économique'), (5, '12C', 'Économique'), (5, '12D', 'Économique'), (5, '12E', 'Économique'), (5, '12F', 'Économique'),
(5, '13A', 'Économique'), (5, '13B', 'Économique'), (5, '13C', 'Économique'), (5, '13D', 'Économique'), (5, '13E', 'Économique'), (5, '13F', 'Économique'),
(5, '14A', 'Économique'), (5, '14B', 'Économique'), (5, '14C', 'Économique'), (5, '14D', 'Économique'), (5, '14E', 'Économique'), (5, '14F', 'Économique'),
(5, '15A', 'Économique'), (5, '15B', 'Économique'), (5, '15C', 'Économique'), (5, '15D', 'Économique'), (5, '15E', 'Économique'), (5, '15F', 'Économique'),
(5, '16A', 'Économique'), (5, '16B', 'Économique'), (5, '16C', 'Économique'), (5, '16D', 'Économique'), (5, '16E', 'Économique'), (5, '16F', 'Économique'),
(5, '17A', 'Économique'), (5, '17B', 'Économique'), (5, '17C', 'Économique'), (5, '17D', 'Économique'), (5, '17E', 'Économique'), (5, '17F', 'Économique'),
(5, '18A', 'Économique'), (5, '18B', 'Économique'), (5, '18C', 'Économique'), (5, '18D', 'Économique'), (5, '18E', 'Économique'), (5, '18F', 'Économique'),
(5, '19A', 'Économique'), (5, '19B', 'Économique'), (5, '19C', 'Économique'), (5, '19D', 'Économique'), (5, '19E', 'Économique'), (5, '19F', 'Économique'),
(5, '20A', 'Économique'), (5, '20B', 'Économique'), (5, '20C', 'Économique'), (5, '20D', 'Économique'), (5, '20E', 'Économique'), (5, '20F', 'Économique'),
(5, '21A', 'Économique'), (5, '21B', 'Économique'), (5, '21C', 'Économique'), (5, '21D', 'Économique'), (5, '21E', 'Économique'), (5, '21F', 'Économique'),
(5, '22A', 'Économique'), (5, '22B', 'Économique'), (5, '22C', 'Économique'), (5, '22D', 'Économique'), (5, '22E', 'Économique'), (5, '22F', 'Économique'),
(5, '23A', 'Économique'), (5, '23B', 'Économique'), (5, '23C', 'Économique'), (5, '23D', 'Économique'), (5, '23E', 'Économique'), (5, '23F', 'Économique'),
(5, '24A', 'Économique'), (5, '24B', 'Économique'), (5, '24C', 'Économique'), (5, '24D', 'Économique'), (5, '24E', 'Économique'), (5, '24F', 'Économique'),
(5, '25A', 'Économique'), (5, '25B', 'Économique'), (5, '25C', 'Économique'), (5, '25D', 'Économique'), (5, '25E', 'Économique'), (5, '25F', 'Économique'),
(5, '26A', 'Économique'), (5, '26B', 'Économique'), (5, '26C', 'Économique'), (5, '26D', 'Économique'), (5, '26E', 'Économique'), (5, '26F', 'Économique'),
(5, '27A', 'Économique'), (5, '27B', 'Économique'), (5, '27C', 'Économique'), (5, '27D', 'Économique'), (5, '27E', 'Économique'), (5, '27F', 'Économique'),
(5, '28A', 'Économique'), (5, '28B', 'Économique'), (5, '28C', 'Économique'), (5, '28D', 'Économique'), (5, '28E', 'Économique'), (5, '28F', 'Économique'),
(5, '29A', 'Économique'), (5, '29B', 'Économique'), (5, '29C', 'Économique'), (5, '29D', 'Économique'), (5, '29E', 'Économique'), (5, '29F', 'Économique'),
(5, '30A', 'Économique'), (5, '30B', 'Économique'), (5, '30C', 'Économique'), (5, '30D', 'Économique'), (5, '30E', 'Économique'), (5, '30F', 'Économique'),
(5, '31A', 'Économique'), (5, '31B', 'Économique'), (5, '31C', 'Économique'), (5, '31D', 'Économique'), (5, '31E', 'Économique'), (5, '31F', 'Économique'),
(5, '32A', 'Économique'), (5, '32B', 'Économique'), (5, '32C', 'Économique'), (5, '32D', 'Économique'), (5, '32E', 'Économique'), (5, '32F', 'Économique'),
(5, '33A', 'Économique'), (5, '33B', 'Économique'), (5, '33C', 'Économique'), (5, '33D', 'Économique'), (5, '33E', 'Économique'), (5, '33F', 'Économique'),
(5, '34A', 'Économique'), (5, '34B', 'Économique'), (5, '34C', 'Économique'), (5, '34D', 'Économique'), (5, '34E', 'Économique'), (5, '34F', 'Économique'),
(5, '35A', 'Économique'), (5, '35B', 'Économique'), (5, '35C', 'Économique'), (5, '35D', 'Économique'), (5, '35E', 'Économique'), (5, '35F', 'Économique'),
(5, '36A', 'Économique'), (5, '36B', 'Économique'), (5, '36C', 'Économique'), (5, '36D', 'Économique'), (5, '36E', 'Économique'), (5, '36F', 'Économique'),
(5, '37A', 'Économique'), (5, '37B', 'Économique'), (5, '37C', 'Économique'), (5, '37D', 'Économique'), (5, '37E', 'Économique'), (5, '37F', 'Économique'),
(5, '38A', 'Économique'), (5, '38B', 'Économique'), (5, '38C', 'Économique'), (5, '38D', 'Économique'), (5, '38E', 'Économique'), (5, '38F', 'Économique'),
(5, '39A', 'Économique'), (5, '39B', 'Économique'), (5, '39C', 'Économique'), (5, '39D', 'Économique'), (5, '39E', 'Économique'), (5, '39F', 'Économique'),
(5, '40A', 'Économique'), (5, '40B', 'Économique'), (5, '40C', 'Économique'), (5, '40D', 'Économique'), (5, '40E', 'Économique'), (5, '40F', 'Économique'),
(5, '41A', 'Économique'), (5, '41B', 'Économique'), (5, '41C', 'Économique'), (5, '41D', 'Économique'), (5, '41E', 'Économique'), (5, '41F', 'Économique'),
(5, '42A', 'Économique'), (5, '42B', 'Économique'), (5, '42C', 'Économique'), (5, '42D', 'Économique'), (5, '42E', 'Économique'), (5, '42F', 'Économique'),
(5, '43A', 'Économique'), (5, '43B', 'Économique'), (5, '43C', 'Économique'), (5, '43D', 'Économique'), (5, '43E', 'Économique'), (5, '43F', 'Économique'),
(5, '44A', 'Économique'), (5, '44B', 'Économique'), (5, '44C', 'Économique'), (5, '44D', 'Économique'), (5, '44E', 'Économique'), (5, '44F', 'Économique'),
(5, '45A', 'Économique'), (5, '45B', 'Économique'), (5, '45C', 'Économique'), (5, '45D', 'Économique'), (5, '45E', 'Économique'), (5, '45F', 'Économique'),
(5, '46A', 'Économique'), (5, '46B', 'Économique'), (5, '46C', 'Économique'), (5, '46D', 'Économique'), (5, '46E', 'Économique'), (5, '46F', 'Économique'),
(5, '47A', 'Économique'), (5, '47B', 'Économique'), (5, '47C', 'Économique'), (5, '47D', 'Économique'), (5, '47E', 'Économique'), (5, '47F', 'Économique'),
(5, '48A', 'Économique'), (5, '48B', 'Économique'), (5, '48C', 'Économique'), (5, '48D', 'Économique'), (5, '48E', 'Économique'), (5, '48F', 'Économique'),
(5, '49A', 'Économique'), (5, '49B', 'Économique'), (5, '49C', 'Économique'), (5, '49D', 'Économique'), (5, '49E', 'Économique'), (5, '49F', 'Économique'),
(5, '50A', 'Économique'), (5, '50B', 'Économique'), (5, '50C', 'Économique'), (5, '50D', 'Économique'), (5, '50E', 'Économique'), (5, '50F', 'Économique'),
(5, '51A', 'Économique'), (5, '51B', 'Économique'), (5, '51C', 'Économique'), (5, '51D', 'Économique'), (5, '51E', 'Économique'), (5, '51F', 'Économique'),
(5, '52A', 'Économique'), (5, '52B', 'Économique'), (5, '52C', 'Économique'), (5, '52D', 'Économique'), (5, '52E', 'Économique'), (5, '52F', 'Économique'),
(5, '53A', 'Économique'), (5, '53B', 'Économique');
-- 6. RÉSERVATIONS DE SIÈGES POUR LES BILLETS
-- =============================================

-- Billet 1: Vol 1 (Tana->Nosy Be, Boeing 737), Économique
INSERT INTO reservation_siege (id_billet, id_siege, id_vol_fille, date_reservation)
SELECT 1, s.id, 1, NOW()
FROM siege s
WHERE s.id_avion = 1 AND s.classe = 'Économique' AND s.numero_siege = '6A'
LIMIT 1;

-- Billet 2: Vol 1 (Tana->Nosy Be, Boeing 737), Affaires
INSERT INTO reservation_siege (id_billet, id_siege, id_vol_fille, date_reservation)
SELECT 2, s.id, 1, NOW()
FROM siege s
WHERE s.id_avion = 1 AND s.classe = 'Affaires' AND s.numero_siege = '1A'
LIMIT 1;

-- Billet 3: Vol 1 (Tana->Nosy Be, Boeing 737), Économique
INSERT INTO reservation_siege (id_billet, id_siege, id_vol_fille, date_reservation)
SELECT 3, s.id, 1, NOW()
FROM siege s
WHERE s.id_avion = 1 AND s.classe = 'Économique' AND s.numero_siege = '6B'
LIMIT 1;

-- Billet 4: Vol 1 (Tana->Nosy Be, Boeing 737), Affaires (enfant)
INSERT INTO reservation_siege (id_billet, id_siege, id_vol_fille, date_reservation)
SELECT 4, s.id, 1, NOW()
FROM siege s
WHERE s.id_avion = 1 AND s.classe = 'Affaires' AND s.numero_siege = '1B'
LIMIT 1;

-- Billet 5: Vol 5 (Nosy Be->Tana, Airbus A320), Économique
INSERT INTO reservation_siege (id_billet, id_siege, id_vol_fille, date_reservation)
SELECT 5, s.id, 5, NOW()
FROM siege s
WHERE s.id_avion = 2 AND s.classe = 'Économique' AND s.numero_siege = '5A'
LIMIT 1;

-- Billet 6: Vol 5 (Nosy Be->Tana, Airbus A320), Affaires
INSERT INTO reservation_siege (id_billet, id_siege, id_vol_fille, date_reservation)
SELECT 6, s.id, 5, NOW()
FROM siege s
WHERE s.id_avion = 2 AND s.classe = 'Affaires' AND s.numero_siege = '1A'
LIMIT 1;

-- Billet 7: Vol 8 (Tana->Majunga, ATR 72), Économique
INSERT INTO reservation_siege (id_billet, id_siege, id_vol_fille, date_reservation)
SELECT 7, s.id, 8, NOW()
FROM siege s
WHERE s.id_avion = 3 AND s.classe = 'Économique' AND s.numero_siege = '3A'
LIMIT 1;

-- Billet 8: Vol 8 (Tana->Majunga, ATR 72), Affaires (enfant)
INSERT INTO reservation_siege (id_billet, id_siege, id_vol_fille, date_reservation)
SELECT 8, s.id, 8, NOW()
FROM siege s
WHERE s.id_avion = 3 AND s.classe = 'Affaires' AND s.numero_siege = '1A'
LIMIT 1;

-- Billet 9: Vol 12 (Tana->Antalaha, Airbus A320), Économique
INSERT INTO reservation_siege (id_billet, id_siege, id_vol_fille, date_reservation)
SELECT 9, s.id, 12, NOW()
FROM siege s
WHERE s.id_avion = 2 AND s.classe = 'Économique' AND s.numero_siege = '5B'
LIMIT 1;

-- Billet 10: Vol 12 (Tana->Antalaha, Airbus A320), Affaires (senior)
INSERT INTO reservation_siege (id_billet, id_siege, id_vol_fille, date_reservation)
SELECT 10, s.id, 12, NOW()
FROM siege s
WHERE s.id_avion = 2 AND s.classe = 'Affaires' AND s.numero_siege = '1B'
LIMIT 1;
